module usaii_global_ai_hackathon

pub const project_title = 'AI Study-to-Work Coach'
pub const official_event = 'USAII Global AI Hackathon 2026'
pub const internal_track = 'student_partner_track'
pub const product_slug = 'usaii_global_ai_hackathon'

pub struct StudentProfile {
pub:
	name        string
	level       string
	interests   []string
	goals       []string
	skills      map[string]int
	constraints []string
}

pub struct Opportunity {
pub:
	id                 string
	title              string
	category           string
	signals            []string
	required_skills    map[string]int
	portfolio_artifact string
}

pub struct OpportunityScore {
pub:
	opportunity Opportunity
	score       int
	reasons     []string
}

pub struct SkillGap {
pub:
	skill    string
	current  int
	target   int
	priority string
}

pub struct PlanStep {
pub:
	week       int
	title      string
	action     string
	evidence   string
	human_gate string
}

pub struct CoachPlan {
pub:
	profile        StudentProfile
	recommendation Opportunity
	fit_score      int
	gaps           []SkillGap
	plan           []PlanStep
	guardrails     []string
	demo_claims    []string
}

pub struct ReadinessReport {
pub:
	generated_at string
	package_name string
	product      string
	version      string
	status       string
	score        int
	checks       map[string]string
	blockers     []string
	artifacts    []string
}

pub struct DevpostPayload {
pub:
	project_title        string
	tagline              string
	built_with           []string
	team_size_required   string
	qualifier_code       string
	submission_url       string
	video_url            string
	description          string
	ai_architecture      string
	responsible_ai       string
	what_it_does         []string
	how_we_built_it      []string
	challenges           []string
	accomplishments      []string
	what_is_next         []string
	final_submit_allowed string
}

pub struct QualifierTemplate {
pub:
	team_name       string
	idea_summary    string
	ai_use          string
	ethics          string
	data_boundary   string
	student_gate    string
	final_authority string
}
