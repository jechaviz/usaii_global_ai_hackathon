module usaii_global_ai_hackathon

pub fn undergraduate_rubric() []RubricDimension {
	return [
		RubricDimension{
			id:       'problem_understanding'
			label:    'Problem Understanding'
			weight:   20
			target:   'Clear decision context and constraints.'
			evidence: 'Student persona, constraints, goals and non-goals are visible.'
		},
		RubricDimension{
			id:       'ai_reasoning'
			label:    'AI/Analytics Reasoning'
			weight:   30
			target:   'Justified approach with clear reasoning, not buzzwords.'
			evidence: 'Transparent scoring, skill gaps, counterfactual slider and baseline comparison.'
		},
		RubricDimension{
			id:       'architecture'
			label:    'Solution Design & Architecture'
			weight:   25
			target:   'Coherent data-to-AI-to-output pipeline.'
			evidence: 'Evidence graph, V core, Vue demo, WAIBAv submission gates.'
		},
		RubricDimension{
			id:       'impact'
			label:    'Impact & Decision Value'
			weight:   15
			target:   'Shows how insights change outcomes.'
			evidence: 'Four-week plan, portfolio artifact and opportunity shortlist.'
		},
		RubricDimension{
			id:       'responsible_ai'
			label:    'Responsible AI & Ethics'
			weight:   10
			target:   'Addresses bias, hallucinations, privacy and failure modes.'
			evidence: 'Guardrails, human approval, synthetic data and no-guarantee language.'
		},
	]
}

pub fn judge_readiness_scorecard() JudgeReadiness {
	scores := [
		RubricScore{
			dimension: undergraduate_rubric()[0]
			score:     95
			rationale: 'The demo names the user, decision, constraints and missing evidence.'
		},
		RubricScore{
			dimension: undergraduate_rubric()[1]
			score:     96
			rationale: 'The product exposes scoring, deltas and why each recommendation changes.'
		},
		RubricScore{
			dimension: undergraduate_rubric()[2]
			score:     94
			rationale: 'Component boundaries are clear across V core, Vue demo, evidence and automation.'
		},
		RubricScore{
			dimension: undergraduate_rubric()[3]
			score:     92
			rationale: 'The output changes a student decision and creates concrete proof.'
		},
		RubricScore{
			dimension: undergraduate_rubric()[4]
			score:     98
			rationale: 'Privacy, bias, over-reliance, hallucination and human approval are explicit.'
		},
	]
	return JudgeReadiness{
		track:       'Undergraduate'
		overall:     weighted_rubric_score(scores)
		scores:      scores
		killer_demo: [
			'Move a skill slider and show the recommendation/risk explanation changing live.',
			'Open the evidence graph: input, reasoning, output, human gate and receipt.',
			'Show baseline-vs-coach: the coach improves decision clarity while reducing risky claims.',
			'End on Devpost packet readiness with final submit still gated to the student lead.',
		]
	}
}

fn weighted_rubric_score(scores []RubricScore) int {
	mut weighted := 0
	mut total := 0
	for score in scores {
		weighted += score.score * score.dimension.weight
		total += score.dimension.weight
	}
	if total == 0 {
		return 0
	}
	return weighted / total
}
