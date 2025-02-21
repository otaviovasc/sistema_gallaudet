class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == "manager_general"
      @schools = School.all
    else
      @schools = [current_user.school].compact
    end
  end

  def select_school
    return unless current_user.role == "manager_general"

    session[:selected_school_id] = params[:school_id]
    redirect_to dashboard_path, notice: "Escola selecionada com sucesso!"
  end

  def list_students
    @query = params[:query]

    school_id = if current_user.role == "manager_general"
                  session[:selected_school_id]
                else
                  current_user.school_id
                end

    # Join courses to limit to the school's students,
    # left join attendances and select the count as an alias.
    @students = Student
                  .joins(:courses)
                  .where(courses: { school_id: school_id })
                  .left_joins(:attendances)
                  .select("students.*, COUNT(attendances.id) AS attendances_count")
                  .group("students.id")

    # Apply search filter by name if provided.
    @students = @students.where("students.name ILIKE ?", "%#{@query}%") if @query.present?

    # Apply course filter if provided.
    if params[:course].present? && params[:course] != ""
      @students = @students.where(courses: { id: params[:course] })
    end

    # Apply sorting based on attendances using the alias.
    if params[:sort].present?
      case params[:sort]
      when "attendances_desc"
        @students = @students.order("attendances_count DESC")
      when "attendances_asc"
        @students = @students.order("attendances_count ASC")
      end
    end

    render partial: "dashboard/list", locals: { students: @students }
  end

  def list_professionals
    @query = params[:query]
    @professionals = if @query.present?
                       Professional.where("name ILIKE ?", "%#{@query}%")
                     else
                       Professional.all
                     end

    render partial: "dashboard/list", locals: { professionals: @professionals }
  end
end
