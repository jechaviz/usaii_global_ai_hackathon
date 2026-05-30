module usaii_global_ai_hackathon

pub fn plan_markdown(plan CoachPlan) string {
	mut lines := []string{}
	lines << '# AI Study-to-Work Coach Demo Plan'
	lines << ''
	lines << 'Student persona: ${plan.profile.name} (${plan.profile.level})'
	lines << ''
	lines << 'Recommended path: ${plan.recommendation.title}'
	lines << ''
	lines << 'Fit score: ${plan.fit_score}/100'
	lines << ''
	lines << '## Skill Gaps'
	lines << ''
	lines << '| Priority | Skill | Current | Target |'
	lines << '|---|---|---:|---:|'
	for gap in plan.gaps {
		lines << '| ${gap.priority} | ${gap.skill} | ${gap.current} | ${gap.target} |'
	}
	lines << ''
	lines << '## Four-Week Plan'
	lines << ''
	lines << '| Week | Step | Evidence | Human Gate |'
	lines << '|---:|---|---|---|'
	for step in plan.plan {
		lines << '| ${step.week} | ${step.title}: ${step.action} | ${step.evidence} | ${step.human_gate} |'
	}
	lines << ''
	lines << '## Guardrails'
	lines << ''
	for item in plan.guardrails {
		lines << '- ${item}'
	}
	return lines.join('\n') + '\n'
}
