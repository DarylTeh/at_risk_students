# At-Risk Student Follow-Up Tool

## Overview
This Rails app helps internal teams identify at-risk students and automate follow-up messaging using AI.

## Features
- Student dashboard with risk indicators
- Rule-based risk scoring system
- Detailed student risk breakdown
- AI-generated follow-up messages

## Risk Logic
A student is flagged as at-risk based on:
- Inactivity (> 7 days)
- Low progress (< 30%)
- Low engagement (< 40%)

## AI Usage
Uses OpenAI API to generate personalized follow-up messages for at-risk students.

## Tech Stack
- Ruby on Rails
- SQLite
- OpenAI API

## How to run
bundle install
rails db:migrate
rails db:seed
rails server

## Environment
Set `OPENAI_API_KEY` in your operating system environment before starting the app. It does not need to be in a local `.env` file unless you choose to use one.

If `MOCK_AI=true`, the service returns hardcoded fallback text instead of calling OpenAI.