module usaii_global_ai_hackathon

import time

pub fn readiness_report(version string) ReadinessReport {
	plan := build_demo_plan()
	judge := judge_readiness_scorecard()
	mut status := 'pass'
	mut blockers := []string{}
	if plan.fit_score < 70 {
		status = 'needs_review'
		blockers << 'demo plan fit score below 70'
	}
	if judge.overall < 90 {
		status = 'needs_review'
		blockers << 'judge readiness below 90'
	}
	blockers << 'eligible 2-5 student team required for real Devpost account'
	blockers << 'AI Readiness Qualifier approval code required before final submission'
	blockers << 'final build and video must be completed during the official hackathon window'
	return ReadinessReport{
		generated_at: time.now().format_rfc3339()
		package_name: product_slug
		product:      project_title
		version:      version
		status:       status
		score:        judge.overall
		checks:       {
			'student_partner_track':     internal_track
			'team_size':                 '2-5 students required'
			'qualifier_window':          '2026-06-07 to 2026-06-10'
			'hackathon_window':          '2026-06-14 to 2026-06-21'
			'final_deadline':            '2026-06-21 23:59 ET'
			'demo_persona_private_data': 'synthetic only'
			'judge_readiness':           judge.overall.str()
			'final_submit_allowed':      'false'
		}
		blockers:     blockers
		artifacts:    [
			'evidence/readiness_report.json',
			'evidence/competitive_experiment.json',
			'evidence/judge_readiness.json',
			'submission/generated/devpost_payload.redacted.json',
			'submission/qualifier_response_template.md',
			'C:\\git\\websites\\usaii_global_ai_hackathon',
		]
	}
}

pub fn readiness_ok(report ReadinessReport) bool {
	return report.status == 'pass' && report.score >= 70
		&& report.checks['final_submit_allowed'] == 'false'
}
