module usaii_global_ai_hackathon

import time

pub fn qualifier_rehearsal() QualifierRehearsal {
	questions := qualifier_questions()
	return QualifierRehearsal{
		generated_at:      time.now().format_rfc3339()
		product:           project_title
		question_count:    questions.len
		estimated_minutes: 30
		themes:            ['Health & Wellbeing', 'Sustainability', 'Community']
		questions:         questions
		coach_rules:       [
			'Answer as a team in one shared session, then let one student lead submit.',
			'Use concrete users, decisions, data, AI role, risks and mitigations in every answer.',
			'Prefer one crisp example over broad claims.',
			'Name when AI should not decide alone.',
			'Keep private student, school and age proof outside public artifacts.',
		]
		stop_gates:        [
			'No qualifier submission without 2-5 real eligible students.',
			'No invented teammate emails or fake student accounts.',
			'No final Devpost submit without qualifier code and student lead review.',
		]
	}
}

fn qualifier_questions() []QualifierQuestion {
	return [
		QualifierQuestion{
			id:             'q1_problem'
			theme:          'Community'
			prompt:         'What real student decision does the solution improve, and why does that decision matter now?'
			winning_signal: 'Names one decision, one affected student group and one consequence of poor guidance.'
			risk_check:     'Avoid framing students as deficient or using protected traits as shortcuts.'
			evidence_hint:  'Use the synthetic persona and decision delta evidence.'
		},
		QualifierQuestion{
			id:             'q2_people'
			theme:          'Community'
			prompt:         'Who is affected by the problem, who reviews the AI output, and who has final authority?'
			winning_signal: 'Separates student, mentor, team lead and platform roles.'
			risk_check:     'Do not imply AI can replace counselors, guardians or school officials.'
			evidence_hint:  'Reference human approval gates and private eligibility boundary.'
		},
		QualifierQuestion{
			id:             'q3_ai_fit'
			theme:          'Health & Wellbeing'
			prompt:         'Why is AI useful here instead of a static checklist or generic template?'
			winning_signal: 'Explains preference extraction, skill-gap reasoning and rubric-aligned planning.'
			risk_check:     'State that AI supports decisions and does not guarantee admissions, jobs or scholarships.'
			evidence_hint:  'Show recommendation reasons, gaps and baseline-vs-coach comparison.'
		},
		QualifierQuestion{
			id:             'q4_data'
			theme:          'Sustainability'
			prompt:         'What data is needed, what data is excluded, and how is private information protected?'
			winning_signal: 'Uses synthetic public demo data and keeps real proof private.'
			risk_check:     'No private student proof, credentials, age or school documents in repos or public forms.'
			evidence_hint:  'Point to Data Boundary and account ops runbook.'
		},
		QualifierQuestion{
			id:             'q5_risks'
			theme:          'Health & Wellbeing'
			prompt:         'What could go wrong if a student over-trusts the system, and how do you reduce that risk?'
			winning_signal: 'Names hallucination, missing evidence, bias, privacy and over-reliance mitigations.'
			risk_check:     'Avoid unsupported claims about accuracy or outcomes.'
			evidence_hint:  'Use risk reduction and guardrail evidence.'
		},
		QualifierQuestion{
			id:             'q6_evaluation'
			theme:          'Community'
			prompt:         'How will the team know the solution is better than baseline advice?'
			winning_signal: 'Defines before/after decision clarity, evidence completeness and human-review pass rate.'
			risk_check:     'Do not overfit to one persona; explain what would be tested during build week.'
			evidence_hint:  'Use baseline 57, coach 86, decision delta +29 and judge readiness 94.'
		},
		QualifierQuestion{
			id:             'q7_pitch'
			theme:          'Sustainability'
			prompt:         'Give a short pitch that connects problem, AI approach, impact and responsible design.'
			winning_signal: 'One sentence for user pain, one for AI workflow, one for proof and safeguards.'
			risk_check:     'Keep the pitch specific and do not promise real-world placement outcomes.'
			evidence_hint:  'Use the video close and submission packet tagline.'
		},
		QualifierQuestion{
			id:             'q8_build_window'
			theme:          'Community'
			prompt:         'What will be built during the official window, and what prior work is only a scaffold?'
			winning_signal: 'Clearly separates this readiness package from substantial official hackathon work.'
			risk_check:     'No claim that prebuilt work is the final hackathon build.'
			evidence_hint:  'Use the build-window compliance log and fresh branch receipts.'
		},
	]
}

pub fn qualifier_rehearsal_markdown(rehearsal QualifierRehearsal) string {
	mut lines := []string{}
	lines << '# Qualifier Rehearsal Kit'
	lines << ''
	lines << 'Product: ${rehearsal.product}'
	lines << 'Estimated time: ${rehearsal.estimated_minutes} minutes'
	lines << 'Question count: ${rehearsal.question_count}'
	lines << ''
	lines << 'Themes: ${rehearsal.themes.join(', ')}'
	lines << ''
	lines << '## Coach Rules'
	lines << ''
	for rule in rehearsal.coach_rules {
		lines << '- ${rule}'
	}
	lines << ''
	lines << '## Practice Questions'
	lines << ''
	for item in rehearsal.questions {
		lines << '### ${item.id}: ${item.theme}'
		lines << ''
		lines << item.prompt
		lines << ''
		lines << '- Winning signal: ${item.winning_signal}'
		lines << '- Risk check: ${item.risk_check}'
		lines << '- Evidence hint: ${item.evidence_hint}'
		lines << ''
	}
	lines << '## Stop Gates'
	lines << ''
	for gate in rehearsal.stop_gates {
		lines << '- ${gate}'
	}
	return lines.join('\n') + '\n'
}
