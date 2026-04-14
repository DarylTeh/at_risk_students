class AiService
  def self.client
    api_key = ENV["OPENAI_API_KEY"].to_s.strip
    raise "OPENAI_API_KEY is required for realtime AI calls" if api_key.empty?

    OpenAI::Client.new(access_token: api_key)
  end

  def self.followup(student)
    # Use mock if MOCK_AI environment variable is set
    if ENV["MOCK_AI"] == "true"
      return mock_followup(student)
    end

    system_prompt = <<~SYSTEM
      You are a senior education success consultant with domain expertise in adult and professional learning.
      For each request, return valid JSON with keys: summary, risk_reasoning, follow_up_message.
      summary: one internal summary sentence describing why the student is at risk.
      risk_reasoning: one concise explanation of the student's main risk factors and recommended action.
      follow_up_message: one friendly follow-up message to the student.
      Do not include any additional keys or commentary outside valid JSON.
    SYSTEM

    user_prompt = <<~USER
      Student profile:
      Name: #{student.name}
      Age: #{student.age}
      Major: #{student.major}
      Background: #{student.profile_summary}
      Previous coursework: #{student.previous_courses}
      Learning style: #{student.learning_style}
      Goals: #{student.goals}

      Current course: #{student.course.name} (#{student.course.level})
      Course description: #{student.course.description}
      Course topics: #{student.course.key_topics}

      Current progress: #{student.progress}%
      Progress status: #{student.progress_status}
      Engagement score: #{student.engagement_score}
      Engagement level: #{student.engagement_level}
      Days inactive: #{student.days_inactive}
      Risk score: #{student.risk_score} / 3
      Holistic health score: #{student.learning_health_score} (#{student.learning_health_label})
      Risk factors: #{student.risk_factors.join(", ")}
      Recommended action: #{student.recommended_action}

      Build a small internal summary, a risk reasoning statement, and a follow-up message. Keep the JSON valid. Use the student profile and metrics above.
    USER

    raw_response = call_openai_with_retry(system_prompt, user_prompt)
    parse_ai_response(raw_response)
  end

  def self.parse_ai_response(raw_response)
    require "json"
    json = JSON.parse(raw_response)
    {
      summary: json["summary"] || json["internal_summary"] || "Summary unavailable.",
      risk_reasoning: json["risk_reasoning"] || json["reasoning"] || "Reasoning unavailable.",
      follow_up_message: json["follow_up_message"] || json["followup_message"] || json["message"] || mock_followup(nil)
    }
  rescue JSON::ParserError
    {
      summary: "Unable to parse AI response.",
      risk_reasoning: "Unable to parse AI response.",
      follow_up_message: raw_response.to_s.strip.presence || "Unable to generate follow-up message at this time."
    }
  end

  private

  def self.call_openai_with_retry(system_prompt, user_prompt, retries = 5)
    retry_count = 0
    max_retries = retries

    begin
      response = self.client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [
            { role: "system", content: system_prompt },
            { role: "user", content: user_prompt }
          ]
        }
      )

      response.dig("choices", 0, "message", "content")
    rescue Faraday::TooManyRequestsError => e
      retry_count += 1
      if retry_count <= max_retries
        # Exponential backoff: 2s, 4s, 8s, 16s, 32s
        wait_time = 2 ** retry_count
        Rails.logger.warn("OpenAI rate limited. Retrying in #{wait_time}s (attempt #{retry_count}/#{max_retries})")
        sleep(wait_time)
        retry
      else
        Rails.logger.error("OpenAI rate limit exceeded after #{max_retries} retries. Falling back to mock response.")
        # Gracefully fall back to mock response instead of crashing
        prompt_match = user_prompt.match(/Name: (.+?)\n/)
        student_name = prompt_match ? prompt_match[1] : "Student"
        return "We're experiencing high demand right now. Thank you for your patience, #{student_name}. Our team will reach out to you shortly with personalized guidance."
      end
    rescue Faraday::ClientError => e
      Rails.logger.error("OpenAI API error: #{e.message}")
      raise e
    end
  end

  private

  def self.mock_followup(student)
    case student.risk_factors.count
    when 0
      "Great job! You're keeping up with the course. Keep the momentum going!"
    when 1
      "We noticed #{student.risk_factors.first.downcase}. We're here to support you—reach out if you need help!"
    else
      "We'd love to see you back in action. Your progress matters to us. How can we support you?"
    end
  end
end