module usaii_global_ai_hackathon

pub fn devpost_payload() DevpostPayload {
	return DevpostPayload{
		project_title:        project_title
		tagline:              'An explainable AI coach that turns student interests into a learning plan, portfolio artifact, and human-approved opportunity match.'
		built_with:           ['Vlang', 'Vue 3 CDN', 'UnoCSS', 'WAIBAv', 'Devpost']
		team_size_required:   '2-5 eligible students'
		qualifier_code:       'PRIVATE_REQUIRED_AFTER_QUALIFIER'
		submission_url:       'REPLACE_WITH_PUBLIC_DEMO_URL'
		video_url:            'REPLACE_WITH_3_TO_5_MIN_VIDEO_URL'
		description:          'AI Study-to-Work Coach helps students decide what to learn next and what proof to build. The demo ingests a synthetic student profile, scores career-oriented opportunities, explains skill gaps, creates a four-week action plan, and keeps outreach or public portfolio changes behind human approval.'
		ai_architecture:      'The MVP uses deterministic scoring for transparent demo behavior and is designed for LLM-assisted preference extraction, rubric generation, opportunity matching, and responsible AI critique during the hackathon build week.'
		responsible_ai:       'The system avoids protected-trait inference, uses synthetic personas in public demos, explains recommendations, shows missing evidence, and requires human approval before outreach or public claims.'
		what_it_does:         [
			'Captures student goals, constraints, interests, and current skill confidence.',
			'Scores opportunity paths and explains why one path is recommended.',
			'Creates a four-week learning-to-portfolio plan with evidence checkpoints.',
			'Prepares Devpost and qualifier materials without storing private student proof.',
		]
		how_we_built_it:      [
			'Vlang product core for scoring, payload generation, QA, and static serving.',
			'Vue3 CDN + SFC + UnoCSS web demo for a fast judge walkthrough.',
			'WAIBAv playbooks for authorized qualifier and Devpost draft preparation.',
			'ContestOps AI shared profile for rules, evidence, scorecard, and proof sprint.',
		]
		challenges:           [
			'Keeping public artifacts useful while excluding private student eligibility evidence.',
			'Making AI recommendations explainable enough for students to trust and challenge.',
			'Respecting the official build window while preparing architecture and evidence now.',
		]
		accomplishments:      [
			'Built a complete pre-qualifier package with synthetic demo data.',
			'Separated product core, web demo, evidence package, and automation runbooks.',
			'Designed responsible AI guardrails around privacy, transparency, and human approval.',
		]
		what_is_next:         [
			'Confirm the eligible student team and complete Devpost registration.',
			'Pass the AI Readiness Qualifier and insert the approval code privately.',
			'During hackathon week, wire final model behavior, record video, and submit before deadline.',
		]
		final_submit_allowed: 'false'
	}
}

pub fn qualifier_template() QualifierTemplate {
	return QualifierTemplate{
		team_name:       'AI Study-to-Work Coach'
		idea_summary:    'We are building an explainable AI coach that helps students convert interests and skill confidence into a responsible learning plan, portfolio artifact, and human-approved opportunity shortlist.'
		ai_use:          'AI assists preference extraction, skill-gap reasoning, rubric generation, opportunity matching, and responsible AI critique. The demo exposes scores, gaps, guardrails, and approval gates.'
		ethics:          'We avoid protected-trait inference, use synthetic public personas, require human review before outreach, and clearly warn that recommendations support decisions rather than guarantee outcomes.'
		data_boundary:   'Public demo data is synthetic. Real student records, school proof, age verification, guardian contacts, and account credentials stay private and are never committed.'
		student_gate:    'Every team member must be a currently enrolled eligible student and registered on Devpost before the qualifier.'
		final_authority: 'Only the eligible student lead may perform final external submissions from an authenticated account.'
	}
}

pub fn qualifier_markdown() string {
	q := qualifier_template()
	return '# USAII AI Readiness Qualifier Response Template\n\n' + 'Team: ${q.team_name}\n\n' +
		'## Idea Summary\n\n${q.idea_summary}\n\n' + '## AI Use\n\n${q.ai_use}\n\n' +
		'## Responsible AI\n\n${q.ethics}\n\n' + '## Data Boundary\n\n${q.data_boundary}\n\n' +
		'## Student Gate\n\n${q.student_gate}\n\n' + '## Final Authority\n\n${q.final_authority}\n'
}
