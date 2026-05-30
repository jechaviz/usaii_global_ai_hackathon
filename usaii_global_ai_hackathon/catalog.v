module usaii_global_ai_hackathon

pub fn demo_student_profile() StudentProfile {
	return StudentProfile{
		name:        'Maya Demo Student'
		level:       'undergraduate'
		interests:   ['responsible AI', 'education', 'career readiness', 'data storytelling']
		goals:       ['choose a realistic AI portfolio project', 'build proof for an internship',
			'avoid generic career advice']
		skills:      {
			'python':            58
			'data_analysis':     64
			'frontend':          46
			'product_thinking':  72
			'responsible_ai':    67
			'communication':     78
			'experiment_design': 52
		}
		constraints: ['8 hours per week', 'needs low-cost tools',
			'wants human review before outreach']
	}
}

pub fn opportunity_catalog() []Opportunity {
	return [
		Opportunity{
			id:                 'learning_analytics_assistant'
			title:              'Learning analytics assistant for first-year students'
			category:           'education'
			signals:            ['responsible AI', 'education', 'data storytelling']
			required_skills:    {
				'python':            62
				'data_analysis':     72
				'frontend':          55
				'responsible_ai':    75
				'experiment_design': 65
			}
			portfolio_artifact: 'A privacy-safe dashboard comparing study habits, confidence, and next actions.'
		},
		Opportunity{
			id:                 'career_readiness_copilot'
			title:              'Career readiness copilot for scholarship and internship prep'
			category:           'career'
			signals:            ['career readiness', 'education', 'responsible AI']
			required_skills:    {
				'frontend':         58
				'product_thinking': 76
				'responsible_ai':   72
				'communication':    80
				'data_analysis':    62
			}
			portfolio_artifact: 'A verified plan, portfolio rubric, and outreach-safe opportunity shortlist.'
		},
		Opportunity{
			id:                 'community_data_story'
			title:              'Community data story for local opportunity gaps'
			category:           'social impact'
			signals:            ['data storytelling', 'career readiness']
			required_skills:    {
				'data_analysis':     70
				'communication':     82
				'product_thinking':  68
				'experiment_design': 60
			}
			portfolio_artifact: 'A public story that explains one access gap and a student-led intervention.'
		},
	]
}

pub fn responsible_ai_guardrails() []string {
	return [
		'Use synthetic demo personas unless a real student explicitly opts in.',
		'Never infer protected traits or rank students by worth; score only stated goals and skills.',
		'Show why every recommendation was made, including weak evidence and missing inputs.',
		'Keep career actions human-approved before outreach, applications, or public portfolio changes.',
		'Warn that the system supports decisions and does not guarantee jobs, admissions, or awards.',
	]
}
