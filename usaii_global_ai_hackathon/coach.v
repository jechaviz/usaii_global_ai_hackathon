module usaii_global_ai_hackathon

pub fn build_demo_plan() CoachPlan {
	return build_plan(demo_student_profile())
}

pub fn build_plan(profile StudentProfile) CoachPlan {
	ranked := rank_opportunities(profile)
	best := if ranked.len > 0 {
		ranked[0]
	} else {
		OpportunityScore{
			opportunity: Opportunity{}
			score:       0
			reasons:     ['No matching opportunities were available.']
		}
	}
	return CoachPlan{
		profile:        profile
		recommendation: best.opportunity
		fit_score:      best.score
		gaps:           skill_gaps(profile, best.opportunity)
		plan:           plan_steps(best.opportunity)
		guardrails:     responsible_ai_guardrails()
		evidence_graph: evidence_graph(best.opportunity)
		demo_claims:    demo_claims()
	}
}

pub fn rank_opportunities(profile StudentProfile) []OpportunityScore {
	mut scores := []OpportunityScore{}
	for opportunity in opportunity_catalog() {
		scores << score_opportunity(profile, opportunity)
	}
	scores.sort(a.score > b.score)
	return scores
}

pub fn score_opportunity(profile StudentProfile, opportunity Opportunity) OpportunityScore {
	mut score := 35
	mut reasons := []string{}
	goals_text := profile.goals.join(' ').to_lower()
	for signal in opportunity.signals {
		if signal in profile.interests || goals_text.contains(signal.to_lower()) {
			score += 8
			reasons << 'Matches stated interest: ${signal}.'
		}
	}
	for skill, target in opportunity.required_skills {
		current := profile.skills[skill] or { 0 }
		if current >= target {
			score += 6
			reasons << 'Ready on ${skill}: ${current}/${target}.'
		} else if current + 15 >= target {
			score += 3
			reasons << 'Near target on ${skill}: ${current}/${target}.'
		} else {
			score -= 4
			reasons << 'Needs focused work on ${skill}: ${current}/${target}.'
		}
	}
	if profile.constraints.any(it.contains('low-cost')) {
		score += 4
		reasons << 'Can be built with low-cost tools and public/synthetic data.'
	}
	if score > 100 {
		score = 100
	}
	if score < 0 {
		score = 0
	}
	return OpportunityScore{
		opportunity: opportunity
		score:       score
		reasons:     reasons
	}
}

pub fn skill_gaps(profile StudentProfile, opportunity Opportunity) []SkillGap {
	mut gaps := []SkillGap{}
	for skill, target in opportunity.required_skills {
		current := profile.skills[skill] or { 0 }
		if current < target {
			priority := if target - current >= 15 { 'high' } else { 'medium' }
			gaps << SkillGap{
				skill:    skill
				current:  current
				target:   target
				priority: priority
			}
		}
	}
	gaps.sort(a.priority < b.priority)
	return gaps
}

fn plan_steps(opportunity Opportunity) []PlanStep {
	return [
		PlanStep{
			week:       1
			title:      'Decision baseline'
			action:     'Confirm the student goal, constraints, target role, and success rubric.'
			evidence:   'Goal statement plus rubric snapshot.'
			human_gate: 'Student approves goals before recommendations are used.'
		},
		PlanStep{
			week:       2
			title:      'Skill-gap sprint'
			action:     'Practice the top two missing skills with one artifact per skill.'
			evidence:   'Two short artifacts and self-rating deltas.'
			human_gate: 'Mentor or peer reviews evidence before the next step.'
		},
		PlanStep{
			week:       3
			title:      'Portfolio artifact'
			action:     'Build and explain: ${opportunity.portfolio_artifact}'
			evidence:   'Portfolio page, demo screenshot, and transparent model notes.'
			human_gate: 'Student confirms no private data appears in the artifact.'
		},
		PlanStep{
			week:       4
			title:      'Opportunity match'
			action:     'Map the artifact to internships, scholarships, clubs, or research openings.'
			evidence:   'Shortlist with why-match reasoning and outreach draft.'
			human_gate: 'Student approves each outreach action manually.'
		},
	]
}

fn demo_claims() []string {
	return [
		'Turns vague student goals into an explainable decision ledger.',
		'Produces portfolio evidence instead of only advice.',
		'Keeps sensitive student identity and school proof out of public artifacts.',
		'Supports responsible AI review through transparent scores, gaps, counterfactuals, and warnings.',
	]
}

fn evidence_graph(opportunity Opportunity) []EvidenceNode {
	return [
		EvidenceNode{
			id:       'input_goal'
			label:    'Student-stated goal'
			kind:     'input'
			status:   'synthetic_demo'
			evidence: 'Profile goals, interests, constraints and skill ratings.'
		},
		EvidenceNode{
			id:       'skill_gap_score'
			label:    'Skill-gap score'
			kind:     'reasoning'
			status:   'computed'
			evidence: 'Required skills compared against current confidence.'
		},
		EvidenceNode{
			id:       'portfolio_artifact'
			label:    'Portfolio artifact'
			kind:     'output'
			status:   'planned'
			evidence: opportunity.portfolio_artifact
		},
		EvidenceNode{
			id:       'human_gate'
			label:    'Human approval gate'
			kind:     'control'
			status:   'required'
			evidence: 'Student approves outreach, public claims and sensitive data use.'
		},
		EvidenceNode{
			id:       'judge_receipt'
			label:    'Judge evidence receipt'
			kind:     'evidence'
			status:   'ready'
			evidence: 'Generated experiment, readiness report and demo screenshots.'
		},
	]
}
