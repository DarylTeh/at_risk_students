class Student < ApplicationRecord
  belongs_to :course

  def at_risk?
    risk_score >= 2
  end

  def risk_score
    score = 0
    score += 1 if last_active_at.present? && last_active_at < 7.days.ago
    score += 1 if progress < 30
    score += 1 if engagement_score < 40
    score
  end

  def risk_factors
    factors = []
    factors << "Inactive > 7 days" if last_active_at.present? && last_active_at < 7.days.ago
    factors << "Low progress (<30%)" if progress < 30
    factors << "Low engagement (<40)" if engagement_score < 40
    factors
  end

  def recommended_action
    return "Immediate outreach: student is highly at risk" if risk_score >= 2
    return "Send encouragement message" if progress < 30
    "Monitor activity"
  end

  def days_inactive
    return 0 unless last_active_at
    (Date.current - last_active_at.to_date).to_i
  end

  def engagement_level
    case engagement_score
    when 0..39 then "Low"
    when 40..69 then "Moderate"
    else "High"
    end
  end

  def progress_status
    case progress
    when 0..24 then "Just started"
    when 25..69 then "Making steady progress"
    else "Nearly complete"
    end
  end

  def learning_health_score
    base = progress * 0.6 + engagement_score * 0.3
    penalty = [days_inactive - 3, 0].max * 1.5
    score = base - penalty
    [[score.round, 0].max, 100].min
  end

  def learning_health_label
    case learning_health_score
    when 0..44 then "Critical"
    when 45..69 then "Fragile"
    when 70..84 then "Stable"
    else "Strong"
    end
  end

  def display_age
    age || fallback_profile[:age]
  end

  def display_major
    major.presence || fallback_profile[:major]
  end

  def display_profile_summary
    profile_summary.presence || fallback_profile[:profile_summary]
  end

  def display_previous_courses
    previous_courses.presence || fallback_profile[:previous_courses]
  end

  def display_learning_style
    learning_style.presence || fallback_profile[:learning_style]
  end

  def display_goals
    goals.presence || fallback_profile[:goals]
  end

  private

  def fallback_profile
    case name
    when "Daryl"
      {
        age: 28,
        major: "Human-Computer Interaction",
        profile_summary: "Daryl is a part-time learner working in customer support. He is transitioning into AI product operations and learns best with short, applied examples.",
        previous_courses: "UX research fundamentals, marketing analytics, and beginner Python for automation.",
        learning_style: "Prefers hands-on labs with clear checklists and real-world examples.",
        goals: "Build a portfolio AI workflow and present a practical prompt-driven prototype."
      }
    when "Denise"
      {
        age: 32,
        major: "Communications",
        profile_summary: "Denise is a digital marketer focused on responsible AI for campaigns, looking to build repeatable prompt frameworks for brand-safe personalization.",
        previous_courses: "Digital brand strategy, content analytics, and AI ethics microcredentials.",
        learning_style: "Likes concept-plus-example learning and industry-ready templates.",
        goals: "Deploy an AI-enabled customer experience workflow aligned to brand voice and policy."
      }
    when "Darren"
      {
        age: 24,
        major: "Economics",
        profile_summary: "Darren is switching from retail operations into analytics. He wants practical, step-by-step SQL and storytelling support.",
        previous_courses: "Statistics foundations, Excel modeling, and introductory SQL for business.",
        learning_style: "Learns best with short, guided exercises and quick review checks.",
        goals: "Gain confidence with analytics workflows and deliver a retention recommendation."
      }
    else
      {
        age: "N/A",
        major: "N/A",
        profile_summary: "No student profile is available.",
        previous_courses: "No previous coursework available.",
        learning_style: "Not specified.",
        goals: "Not specified."
      }
    end
  end
end