class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # If manager_general, load all schools to display in a select dropdown
    if current_user.role == "manager_general"
      @schools = School.all
    else
      # If manager_unit, they are tied to a single school
      @schools = [current_user.school].compact
    end
  end

  # PATCH /dashboard/select_school
  def select_school
    return unless current_user.role == "manager_general"

    # Save the chosen school in session or persist in DB if desired
    session[:selected_school_id] = params[:school_id]
    redirect_to dashboard_path, notice: "Escola selecionada com sucesso!"
  end

  # GET /dashboard/list_students
  def list_students
    # We'll fill out the listing logic when we implement the second column.
  end

  # GET /dashboard/list_professionals
  def list_professionals
    # We'll fill out the listing logic when we implement the second column.
  end
end
