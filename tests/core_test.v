import usaii_global_ai_hackathon as core

fn test_demo_plan_is_explainable_and_ready() {
	plan := core.build_demo_plan()
	assert plan.recommendation.id == 'career_readiness_copilot'
	assert plan.fit_score >= 80
	assert plan.gaps.len >= 1
	assert plan.guardrails.len >= 5
	assert plan.evidence_graph.len >= 5
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
	assert payload.submission_url == core.public_demo_url
	assert payload.source_repo_url == core.source_repo_url
	assert payload.built_with.any(it == 'Vlang')
	assert payload.description.contains('synthetic student profile')
}

fn test_qualifier_template_names_student_gate() {
	qualifier := core.qualifier_template()
	assert qualifier.student_gate.contains('currently enrolled eligible student')
	assert qualifier.final_authority.contains('eligible student lead')
}

fn test_qualifier_rehearsal_matches_official_shape() {
	rehearsal := core.qualifier_rehearsal()
	assert rehearsal.question_count == 8
	assert rehearsal.estimated_minutes == 30
	assert 'Health & Wellbeing' in rehearsal.themes
	assert 'Sustainability' in rehearsal.themes
	assert 'Community' in rehearsal.themes
	assert rehearsal.questions.any(it.id == 'q8_build_window')
	assert rehearsal.stop_gates.any(it.contains('fake student accounts'))
}

fn test_judge_readiness_tracks_official_rubric() {
	readiness := core.judge_readiness_scorecard()
	assert readiness.track == 'Undergraduate'
	assert readiness.overall >= 94
	assert readiness.scores.len == 5
	assert readiness.scores.any(it.dimension.label == 'AI/Analytics Reasoning')
}

fn test_competitive_experiment_shows_delta_and_risk_reduction() {
	report := core.competitive_experiment('test')
	assert report.cases.len >= 5
	assert report.coach_average > report.baseline_average
	assert report.decision_delta >= 25
	assert report.risk_reduction >= 60
	assert report.competitive_claims.any(it.contains('Not a chatbot'))
}
