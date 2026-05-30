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
	lines << ''
	lines << '## Evidence Graph'
	lines << ''
	for node in plan.evidence_graph {
		lines << '- ${node.status}: ${node.label} (${node.kind}) - ${node.evidence}'
	}
	return lines.join('\n') + '\n'
}

pub fn judge_mode_markdown(experiment ExperimentReport, readiness JudgeReadiness) string {
	mut lines := []string{}
	lines << '# Judge Mode'
	lines << ''
	lines << 'Track: ${readiness.track}'
	lines << 'Overall judge readiness: ${readiness.overall}/100'
	lines << 'Decision delta: +${experiment.decision_delta}'
	lines << 'Risk reduction: ${experiment.risk_reduction}%'
	lines << ''
	lines << '## Rubric Fit'
	lines << ''
	lines << '| Weight | Dimension | Score | Evidence |'
	lines << '|---:|---|---:|---|'
	for score in readiness.scores {
		lines << '| ${score.dimension.weight}% | ${score.dimension.label} | ${score.score} | ${score.dimension.evidence} |'
	}
	lines << ''
	lines << '## Baseline Versus Coach'
	lines << ''
	lines << '| Student | Baseline | Coach | Risk Before | Risk After | Winning Signal |'
	lines << '|---|---:|---:|---:|---:|---|'
	for item in experiment.cases {
		lines << '| ${item.student} | ${item.baseline_score} | ${item.coach_score} | ${item.risk_before} | ${item.risk_after} | ${item.winning_signal} |'
	}
	lines << ''
	lines << '## Killer Demo Beats'
	lines << ''
	for item in readiness.killer_demo {
		lines << '- ${item}'
	}
	return lines.join('\n') + '\n'
}
