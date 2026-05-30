module main

import json
import local_http_core as http_core
import net.http
import os
import project_line_guard
import time
import usaii_global_ai_hackathon as core

const default_worth_it = 'C:/git/v_projects/contests/worth_it/usaii_global_ai_hackathon'
const default_site = 'C:/git/websites/usaii_global_ai_hackathon'
const default_port = 4197
const product_version = '1.3.0'

struct StaticHandler {
	site_root string
}

fn main() {
	args := os.args[1..].filter(it != '--')
	cmd := if args.len == 0 { 'help' } else { args[0] }
	exit_code := match cmd {
		'generate' {
			run_generate(args[1..])
		}
		'plan' {
			run_plan(args[1..])
		}
		'judge' {
			run_judge(args[1..])
		}
		'qa' {
			run_qa(args[1..])
		}
		'form' {
			run_form(args[1..])
		}
		'serve' {
			run_serve(args[1..])
		}
		'help', '--help', '-h' {
			print_help()
		}
		else {
			eprintln('unknown command: ${cmd}')
			print_help()
			1
		}
	}

	if exit_code != 0 {
		exit(exit_code)
	}
}

fn run_generate(args []string) int {
	worth_it := flag_value(args, '--worth-it', default_worth_it)
	site := flag_value(args, '--site', default_site)
	ensure_dirs([os.join_path(site, 'src', 'data'), os.join_path(worth_it, 'evidence'),
		os.join_path(worth_it, 'submission', 'generated'), os.join_path(worth_it, 'docs')]) or {
		return fail(err.msg())
	}
	plan := core.build_demo_plan()
	report := core.readiness_report(product_version)
	payload := core.devpost_payload()
	qualifier := core.qualifier_template()
	rehearsal := core.qualifier_rehearsal()
	experiment := core.competitive_experiment(product_version)
	rubric := core.judge_readiness_scorecard()
	write_text(os.join_path(site, 'src', 'data', 'coach_plan.json'), json.encode_pretty(plan)) or {
		return fail(err.msg())
	}
	write_text(os.join_path(site, 'src', 'data', 'opportunities.json'),
		json.encode_pretty(core.rank_opportunities(core.demo_student_profile()))) or {
		return fail(err.msg())
	}
	write_text(os.join_path(site, 'src', 'data', 'readiness_report.json'),
		json.encode_pretty(report)) or { return fail(err.msg()) }
	write_text(os.join_path(site, 'src', 'data', 'competitive_experiment.json'),
		json.encode_pretty(experiment)) or { return fail(err.msg()) }
	write_text(os.join_path(site, 'src', 'data', 'judge_readiness.json'),
		json.encode_pretty(rubric)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'evidence', 'readiness_report.json'),
		json.encode_pretty(report)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'evidence', 'competitive_experiment.json'),
		json.encode_pretty(experiment)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'evidence', 'judge_readiness.json'),
		json.encode_pretty(rubric)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'submission', 'generated', 'devpost_payload.redacted.json'),
		json.encode_pretty(payload)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'submission', 'generated', 'qualifier_template.redacted.json'),
		json.encode_pretty(qualifier)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'evidence', 'qualifier_rehearsal.json'),
		json.encode_pretty(rehearsal)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'submission', 'qualifier_rehearsal_kit.md'),
		core.qualifier_rehearsal_markdown(rehearsal)) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'submission', 'qualifier_response_template.md'),
		core.qualifier_markdown()) or { return fail(err.msg()) }
	write_text(os.join_path(worth_it, 'docs', 'DEMO_MVP.generated.md'), core.plan_markdown(plan)) or {
		return fail(err.msg())
	}
	write_text(os.join_path(worth_it, 'docs', 'JUDGE_MODE.generated.md'), core.judge_mode_markdown(experiment,
		rubric)) or { return fail(err.msg()) }
	println('generated USAII product data, evidence and redacted submission artifacts')
	return 0
}

fn run_plan(args []string) int {
	plan := core.build_demo_plan()
	if has_flag(args, '--json') {
		println(json.encode_pretty(plan))
		return 0
	}
	print(core.plan_markdown(plan))
	return 0
}

fn run_judge(args []string) int {
	experiment := core.competitive_experiment(product_version)
	rubric := core.judge_readiness_scorecard()
	if has_flag(args, '--json') {
		println(json.encode_pretty({
			'experiment': json.encode(experiment)
			'rubric':     json.encode(rubric)
		}))
		return 0
	}
	print(core.judge_mode_markdown(experiment, rubric))
	return 0
}

fn run_qa(args []string) int {
	worth_it := flag_value(args, '--worth-it', default_worth_it)
	site := flag_value(args, '--site', default_site)
	product := os.dir(os.dir(os.dir(@FILE)))
	limit := flag_value(args, '--line-limit', '600').int()
	near_limit := flag_value(args, '--near-limit', '560').int()
	mut failures := []string{}
	for target in [product, site, worth_it] {
		if !os.exists(target) {
			failures << 'missing target: ${target}'
			continue
		}
		report := project_line_guard.audit_line_caps(project_line_guard.GuardOptions{
			root:       target
			limit:      limit
			near_limit: near_limit
		})
		for item in report.failures {
			failures << '${item.rel} has ${item.lines} lines'
		}
	}
	readiness := core.readiness_report(product_version)
	if !core.readiness_ok(readiness) {
		failures << 'readiness report did not pass product gates'
	}
	experiment := core.competitive_experiment(product_version)
	if experiment.decision_delta < 20 || experiment.risk_reduction < 20 {
		failures << 'competitive experiment improvement is too weak'
	}
	if core.judge_readiness_scorecard().overall < 90 {
		failures << 'judge readiness below 90'
	}
	rehearsal := core.qualifier_rehearsal()
	if rehearsal.question_count != 8 || rehearsal.themes.len != 3 {
		failures << 'qualifier rehearsal does not match official practice shape'
	}
	if failures.len > 0 {
		eprintln('qa failed:')
		for item in failures {
			eprintln('- ${item}')
		}
		return 2
	}
	println('qa passed: readiness, line caps and target presence ok')
	return 0
}

fn run_form(args []string) int {
	worth_it := flag_value(args, '--worth-it', default_worth_it)
	dry_run := has_flag(args, '--dry-run') || !has_flag(args, '--submit')
	payload := core.devpost_payload()
	preview := {
		'target':       'https://usaii-global-ai-hackathon-2026.devpost.com/'
		'dry_run':      dry_run.str()
		'generated_at': time.now().format_rfc3339()
		'ok_to_submit': 'false'
		'payload':      json.encode(payload)
		'blockers':     'eligible student session; qualifier code; final video URL; explicit final submit approval'
		'final_gate':   'USAII_DEVPOST_SUBMIT_AUTHORIZED=YES plus student lead review'
	}
	out_path := os.join_path(worth_it, 'evidence', 'devpost_payload_preview_v.json')
	write_text(out_path, json.encode_pretty(preview)) or { return fail(err.msg()) }
	if dry_run {
		println('dry-run preview written: ${out_path}')
		return 0
	}
	if os.getenv('USAII_DEVPOST_SUBMIT_AUTHORIZED') != 'YES' {
		eprintln('blocked: set USAII_DEVPOST_SUBMIT_AUTHORIZED=YES only in an authorized student session')
		return 3
	}
	eprintln('blocked: use WAIBAv Devpost playbook for browser draft fill and final student review')
	return 4
}

fn run_serve(args []string) int {
	site := flag_value(args, '--site', default_site)
	port := flag_value(args, '--port', default_port.str()).int()
	if !os.exists(os.join_path(site, 'index.html')) {
		eprintln('site index not found: ${site}')
		return 2
	}
	println('serving ${site} at http://127.0.0.1:${port}')
	mut server := http.Server{
		addr:                 '127.0.0.1:${port}'
		handler:              StaticHandler{
			site_root: site
		}
		show_startup_message: false
	}
	server.listen_and_serve()
	return 0
}

fn (handler StaticHandler) handle(req http.Request) http.Response {
	path := http_core.request_path(req.url)
	mut rel := path.trim_left('/')
	if rel == '' {
		rel = 'index.html'
	}
	if rel.contains('..') || os.is_abs_path(rel) {
		return http_core.forbidden_response(security_headers())
	}
	full_path := os.join_path(handler.site_root, rel)
	if os.exists(full_path) && os.is_file(full_path) {
		return http_core.file_response(full_path, cache_for(rel), security_headers())
	}
	return http_core.file_response(os.join_path(handler.site_root, 'index.html'), 'no-cache',
		security_headers())
}

fn ensure_dirs(paths []string) ! {
	for path in paths {
		os.mkdir_all(path)!
	}
}

fn write_text(path string, content string) ! {
	os.mkdir_all(os.dir(path))!
	os.write_file(path, content)!
}

fn flag_value(args []string, name string, fallback string) string {
	for i, item in args {
		if item == name && i + 1 < args.len {
			return args[i + 1]
		}
		prefix := name + '='
		if item.starts_with(prefix) {
			return item[prefix.len..]
		}
	}
	return fallback
}

fn has_flag(args []string, name string) bool {
	return args.any(it == name)
}

fn cache_for(rel string) string {
	if rel.ends_with('.js') || rel.ends_with('.vue') || rel.ends_with('.css')
		|| rel.ends_with('.json') {
		return 'no-cache'
	}
	return 'public, max-age=300'
}

fn security_headers() http_core.LocalSecurityHeaders {
	return http_core.LocalSecurityHeaders{
		content_security_policy: "default-src 'self' https://unpkg.com https://cdn.jsdelivr.net; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; connect-src 'self'; img-src 'self' data:; font-src 'self' data:"
	}
}

fn fail(message string) int {
	eprintln(message)
	return 1
}

fn print_help() int {
	println('usaii commands: generate | plan | judge | qa | form | serve')
	return 0
}
