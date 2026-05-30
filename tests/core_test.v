import usaii_global_ai_hackathon as core

fn test_demo_plan_is_explainable_and_ready() {
	plan := core.build_demo_plan()
	assert plan.recommendation.id == 'career_readiness_copilot'
	assert plan.fit_score >= 80
	assert plan.gaps.len >= 1
	assert plan.guardrails.len >= 5
	assert plan.plan.len == 4
}

fn test_readiness_keeps_final_submit_blocked() {
	report := core.readiness_report('test')
	assert core.readiness_ok(report)
	assert report.checks['final_submit_allowed'] == 'false'
	assert report.blockers.any(it.contains('eligible 2-5 student team'))
}

fn test_devpost_payload_is_redacted() {
	payload := core.devpost_payload()
	assert payload.qualifier_code == 'PRIVATE_REQUIRED_AFTER_QUALIFIER'
	assert payload.final_submit_allowed == 'false'
	assert payload.built_with.any(it == 'Vlang')
	assert payload.description.contains('synthetic student profile')
}

fn test_qualifier_template_names_student_gate() {
	qualifier := core.qualifier_template()
	assert qualifier.student_gate.contains('currently enrolled eligible student')
	assert qualifier.final_authority.contains('eligible student lead')
}
