# At-Risk Student Follow-Up Tool

## Overview
This Rails application helps educators identify at-risk students and generate personalized follow-up messages using AI. It provides a dashboard view of student progress, risk indicators, and automated communication suggestions.

## Features
- **Student Dashboard**: Clean overview of all students with risk status badges
- **Risk Assessment**: Automated scoring based on progress, engagement, and activity
- **Detailed Profiles**: Comprehensive student information including course details and learning preferences
- **AI-Powered Insights**: Asynchronous generation of internal summaries, risk reasoning, and suggested follow-up messages
- **Robust Error Handling**: Graceful fallbacks when AI services are unavailable

## Risk Logic
Students are flagged as at-risk based on three criteria:
- **Inactivity**: Last active more than 7 days ago
- **Low Progress**: Progress percentage below 30%
- **Low Engagement**: Engagement score below 40

Risk score ranges from 0-3, with 2+ considered at-risk.

## AI Usage
The application integrates OpenAI's GPT-4o-mini model to generate three key outputs for each at-risk student:
1. **Internal Summary**: Concise explanation of risk factors
2. **Risk Reasoning**: Detailed analysis and recommended actions
3. **Follow-up Message**: Personalized communication ready for student outreach

AI calls are made asynchronously to prevent blocking the user interface.

## Tech Stack
- Ruby on Rails 8.1
- SQLite database
- OpenAI API (ruby-openai gem)
- Vanilla JavaScript for async UI updates

## Setup Instructions

### Prerequisites
- Ruby 3.1 or higher
- Rails 8.1
- OpenAI API key

### Installation
1. Clone this repository
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:setup` (this runs migrations and seeds)
4. Set your OpenAI API key: `export OPENAI_API_KEY=your_key_here` (or equivalent for your OS)
5. Start the server: `rails server`

### Seed Data
The application includes realistic seed data with 3 sample students across 2 courses. Run `rails db:seed` to populate the database. The seed data includes:
- Course information with descriptions and topics
- Student profiles with ages, majors, backgrounds, and learning styles
- Realistic progress and engagement metrics

### Environment Variables
- `OPENAI_API_KEY`: Required for AI functionality
- `MOCK_AI=true`: Optional, uses hardcoded responses instead of calling OpenAI (useful for development/testing)

## Usage
1. Visit the dashboard at `http://localhost:3000`
2. Browse students and click "View" to see detailed information
3. AI insights load automatically on the student detail page
4. Use the generated messages as templates for student communication

## Development
- Run tests: `rails test`
- Check code style: `bin/rubocop`
- Security audit: `bin/bundler-audit`

## Architecture Notes
- **MVC Structure**: Clean separation with service objects for AI logic
- **Async Loading**: JavaScript fetch API for non-blocking AI content
- **Error Resilience**: Retry logic, fallbacks, and graceful degradation
- **Security**: Parameter filtering and CSP headers configured