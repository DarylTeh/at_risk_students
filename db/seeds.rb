course1 = Course.create!(
  name: "Generative AI Product Design",
  level: "Professional Certificate",
  description: "A practical, project-driven course built for professionals who want to apply generative AI to marketing, product design, and customer experience. The curriculum covers prompt workflows, bias-aware evaluation, LLM selection, and production-ready guardrails.",
  key_topics: "Prompt engineering, workflow design, prompt testing, bias mitigation, model evaluation, prototype delivery"
)

course2 = Course.create!(
  name: "Applied Business Analytics",
  level: "Intermediate",
  description: "An industry-aligned analytics course that teaches learners how to turn real business data into insights. Students practice SQL, dashboarding, and story-backed recommendations with case studies in retention, segmentation, and performance reporting.",
  key_topics: "Data modeling, SQL querying, KPI definition, dashboard storytelling, stakeholder communication"
)

Student.create!([
  {
    name: "Daryl",
    course: course1,
    last_active_at: 10.days.ago,
    progress: 20,
    engagement_score: 30,
    age: 28,
    major: "Human-Computer Interaction",
    profile_summary: "Daryl is a part-time professional balancing a day job in customer support with evening AI coursework. He is motivated by career transition and struggles to maintain consistency because of long workdays and family obligations.",
    previous_courses: "Completed an introductory UX design bootcamp, a short course in data storytelling, and a beginner Python course focused on automation.",
    learning_style: "Prefers short hands-on lessons with examples and concrete checklists before attempting projects.",
    goals: "Finish the AI assistant project and build a portfolio piece that demonstrates prompt engineering and practical deployment readiness."
  },
  {
    name: "Denise",
    course: course1,
    last_active_at: 1.day.ago,
    progress: 80,
    engagement_score: 90,
    age: 32,
    major: "Communications",
    profile_summary: "Denise is an experienced marketer who uses AI tools daily. She reads quickly, participates in discussion threads, and wants to refine her ability to build responsible AI prompts for customer-facing workflows.",
    previous_courses: "Studied digital marketing strategy, analytics for content teams, and an ethics in AI microcredential.",
    learning_style: "Likes high-level concepts combined with real-world case studies and practical templates.",
    goals: "Use generative AI to improve campaign personalization while keeping output aligned to brand voice and compliance."
  },
  {
    name: "Darren",
    course: course2,
    last_active_at: 12.days.ago,
    progress: 10,
    engagement_score: 25,
    age: 24,
    major: "Economics",
    profile_summary: "Darren recently switched to analytics from a retail operations role. He is eager to prove himself but tends to get overwhelmed by SQL syntax and report storytelling.",
    previous_courses: "Finished a statistics fundamentals course, an Excel modelling workshop, and a beginner SQL tutorial.",
    learning_style: "Learns best with step-by-step examples and short review quizzes after each section.",
    goals: "Gain confidence in analytics workflows and present a clear retention analysis to a mock business stakeholder."
  }
])