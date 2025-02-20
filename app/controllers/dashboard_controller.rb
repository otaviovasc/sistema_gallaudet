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
    @students = Student.all

    # Apply search filter by name if provided.
    @students = @students.where("name ILIKE ?", "%#{@query}%") if @query.present?

    # Apply course filter if provided.
    if params[:course].present? && params[:course] != ""
      # Join courses through enrollments (assuming association exists)
      @students = @students.joins(:courses).where(courses: { id: params[:course] }).distinct
    end

    # Apply sorting based on attendances if provided.
    if params[:sort].present?
      case params[:sort]
      when "attendances_desc"
        @students = @students.left_joins(:attendances)
                             .group("students.id")
                             .order("COUNT(attendances.id) DESC")
      when "attendances_asc"
        @students = @students.left_joins(:attendances)
                             .group("students.id")
                             .order("COUNT(attendances.id) ASC")
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
