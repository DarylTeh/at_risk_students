class StudentsController < ApplicationController
  def index
    @students = Student.all.includes(:course)
  end

  def show
    @student = Student.find(params[:id])
  end

  def ai_message
    student = Student.find(params[:id])
    result = AiService.followup(student)
    render json: result
  end
end