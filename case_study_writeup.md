# At-Risk Student Follow-Up Tool: Case Study and Solution

## Introduction

This case study presents the development of a small Ruby on Rails application designed to assist educators in identifying and following up with at-risk students. The application leverages AI to generate personalized follow-up messages, demonstrating practical integration of modern web technologies with artificial intelligence. The project emphasizes problem-solving, product thinking, and hands-on implementation within the constraints of a Rails framework.

## Problem Analysis

### The Case Study Context
Educational institutions face significant challenges in student retention, particularly with adult learners who balance coursework with professional and personal responsibilities. Traditional methods of identifying at-risk students rely on manual review of metrics like progress, engagement, and activity levels. However, personalized follow-up communication often requires significant time and expertise to craft effective messages.

The assignment required building a feature that:
- Identifies students at risk based on configurable criteria
- Provides actionable insights for educators
- Incorporates an AI component for automated message generation
- Demonstrates Rails proficiency and clean architecture

### Key Requirements
- **Data Model**: Students with progress tracking, engagement scores, and course associations
- **Risk Assessment**: Automated calculation of risk levels based on multiple factors
- **AI Integration**: Real-time generation of personalized follow-up messages
- **User Interface**: Clean, responsive dashboard and detail views
- **Robustness**: Error handling, rate limiting, and fallback mechanisms

## Solution Design

### Product Thinking Approach
The solution prioritizes educator efficiency while ensuring student-centric communication. Key design decisions included:

1. **Asynchronous AI Loading**: Immediate page rendering with background AI generation to prevent blocking user interactions
2. **Structured AI Prompts**: Engineered prompts that incorporate student profiles, course details, and risk factors for contextually relevant outputs
3. **Fallback Mechanisms**: Graceful degradation when AI services are unavailable, ensuring the application remains functional
4. **Modular Architecture**: Separation of concerns between data models, business logic, and AI services

### Trade-offs and Decisions
- **AI vs. Manual**: Automated message generation reduces educator workload but requires careful prompt engineering to maintain quality
- **Real-time vs. Cached**: Live AI calls provide fresh insights but introduce latency; implemented retry logic and caching considerations for future scalability
- **Simplicity vs. Features**: Focused on core functionality rather than extensive customization, allowing for rapid iteration and clear demonstration of concepts
- **SQLite vs. Production DB**: Used SQLite for development simplicity while maintaining production-ready patterns

## Implementation Details

### Technical Architecture
The application follows Rails conventions with a clear MVC structure:

- **Models**: `Student` and `Course` with associations and business logic methods
- **Controller**: RESTful `StudentsController` with index and show actions, plus an AI endpoint
- **Views**: ERB templates with vanilla JavaScript for dynamic content loading
- **Service Layer**: `AiService` class handling OpenAI API interactions with error handling

### Key Features Implemented

#### 1. Student Risk Assessment
```ruby
def risk_score
  score = 0
  score += 1 if last_active_at.present? && last_active_at < 7.days.ago
  score += 1 if progress < 30
  score += 1 if engagement_score < 40
  score
end
```
This method calculates risk based on inactivity, progress, and engagement thresholds.

#### 2. AI-Powered Insights
The AI service generates three key outputs:
- **Internal Summary**: Concise explanation of why the student is at risk
- **Risk Reasoning**: Detailed analysis of risk factors and recommended actions
- **Follow-up Message**: Personalized communication ready for student outreach

#### 3. Asynchronous User Experience
JavaScript fetch API loads AI content in the background:
```javascript
fetch("/students/" + studentId + "/ai_message", {
  headers: { "Accept": "application/json" }
})
.then(function(response) { return response.json(); })
.then(function(data) {
  // Update UI with AI-generated content
});
```

#### 4. Robust Error Handling
- API key validation prevents runtime failures
- Exponential backoff retry logic for rate-limited requests
- Fallback to mock responses when AI is unavailable
- JSON parsing with error recovery

### Development Process
1. **Planning**: Identified core requirements and user workflows
2. **Data Modeling**: Designed Student and Course schemas with profile fields
3. **Core Logic**: Implemented risk calculation and AI service integration
4. **UI Development**: Created responsive dashboard and detail views
5. **Testing**: Verified functionality with seed data and edge cases
6. **Refinement**: Added async loading, error handling, and documentation

## Challenges and Learnings

### Technical Challenges
- **AI Rate Limiting**: OpenAI's API constraints required implementing retry mechanisms and fallback strategies
- **Async UI Updates**: Coordinating background AI calls with immediate page rendering demanded careful JavaScript integration
- **Prompt Engineering**: Crafting effective AI prompts that balance specificity with flexibility

### Problem-Solving Insights
- **Iterative Development**: Started with basic functionality and progressively added complexity
- **Error Resilience**: Building in multiple layers of error handling ensured reliable operation
- **User-Centric Design**: Prioritizing educator workflow led to more intuitive interfaces

### Rails Best Practices Applied
- **RESTful Routing**: Clean URL structure and resource-based actions
- **Service Objects**: Separated AI logic from controllers for better testability
- **Asset Pipeline**: Organized CSS and JavaScript for maintainable styling
- **Seed Data**: Realistic test data for development and demonstration

## Conclusion

This Rails application successfully demonstrates the integration of AI capabilities within a web framework to solve a real educational challenge. The solution balances technical implementation with user experience considerations, showcasing both hands-on coding skills and product thinking.

Key achievements include:
- Functional risk assessment system with configurable criteria
- Seamless AI integration with robust error handling
- Clean, responsive user interface
- Production-ready code structure following Rails conventions

The project highlights the potential of AI-augmented tools in education while maintaining the human element essential for effective student support. Future enhancements could include batch processing, advanced analytics, and integration with learning management systems.

## Appendix: Setup Instructions

### Prerequisites
- Ruby 3.1+
- Rails 8.1
- OpenAI API key

### Installation
1. Clone the repository
2. Run `bundle install`
3. Set `OPENAI_API_KEY` environment variable
4. Run `rails db:setup`
5. Start the server with `rails server`

### Usage
- Visit the dashboard at `/`
- Click "View" on any student to see detailed information
- AI insights load asynchronously on the student detail page

This implementation demonstrates a thoughtful approach to building AI-enhanced educational tools, balancing technical excellence with practical usability.