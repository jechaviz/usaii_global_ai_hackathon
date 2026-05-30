module usaii_global_ai_hackathon

pub const project_title = 'AI Study-to-Work Coach'
pub const official_event = 'USAII Global AI Hackathon 2026'
pub const internal_track = 'student_partner_track'
pub const product_slug = 'usaii_global_ai_hackathon'
pub const public_demo_url = 'https://jechaviz.github.io/usaii_global_ai_hackathon_web/'
pub const source_repo_url = 'https://github.com/jechaviz/usaii_global_ai_hackathon'
pub const web_repo_url = 'https://github.com/jechaviz/usaii_global_ai_hackathon_web'
pub const contest_repo_url = 'https://github.com/jechaviz/usaii_global_ai_hackathon_contest'

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
	evidence_graph []EvidenceNode
	demo_claims    []string
}

pub struct EvidenceNode {
pub:
	id       string
	label    string
	kind     string
	status   string
	evidence string
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
	source_repo_url      string
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

pub struct QualifierQuestion {
pub:
	id             string
	theme          string
	prompt         string
	winning_signal string
	risk_check     string
	evidence_hint  string
}

pub struct QualifierRehearsal {
pub:
	generated_at      string
	product           string
	question_count    int
	estimated_minutes int
	themes            []string
	questions         []QualifierQuestion
	coach_rules       []string
	stop_gates        []string
}

pub struct RubricDimension {
pub:
	id       string
	label    string
	weight   int
	target   string
	evidence string
}

pub struct RubricScore {
pub:
	dimension RubricDimension
	score     int
	rationale string
}

pub struct JudgeReadiness {
pub:
	track       string
	overall     int
	scores      []RubricScore
	killer_demo []string
}

pub struct ExperimentCase {
pub:
	id             string
	student        string
	baseline_score int
	coach_score    int
	risk_before    int
	risk_after     int
	winning_signal string
}

pub struct ExperimentReport {
pub:
	generated_at       string
	product            string
	version            string
	cases              []ExperimentCase
	baseline_average   int
	coach_average      int
	decision_delta     int
	risk_before_total  int
	risk_after_total   int
	risk_reduction     int
	judge_takeaways    []string
	competitive_claims []string
}
