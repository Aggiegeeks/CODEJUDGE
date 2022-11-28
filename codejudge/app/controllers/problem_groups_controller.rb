class ProblemGroupsController < ApplicationController
  before_action :set_problem_group, only: %i[ show edit update destroy ]
  helper_method :get_title_id

  # GET /problem_groups or /problem_groups.json
  def index
    @problem_groups = ProblemGroup.all
  end

  # GET /problem_groups/1 or /problem_groups/1.json
  def show
  end

  # GET /problem_groups/new
  def new
    @problem_group = ProblemGroup.new
  end

  # GET /problem_groups/1/edit
  def edit
  end

  # POST /problem_groups or /problem_groups.json
  def create
    @problem_group = ProblemGroup.new(problem_group_params)

    respond_to do |format|
      if @problem_group.save
        format.html { redirect_to problem_group_url(@problem_group), notice: "Problem group was successfully created." }
        format.json { render :show, status: :created, location: @problem_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problem_groups/1 or /problem_groups/1.json
  def update
    respond_to do |format|
      if @problem_group.update(problem_group_params)
        format.html { redirect_to problem_group_url(@problem_group), notice: "Problem group was successfully updated." }
        format.json { render :show, status: :ok, location: @problem_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @problem_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_groups/1 or /problem_groups/1.json
  def destroy
    @problem_group.destroy

    respond_to do |format|
      format.html { redirect_to problem_groups_url, notice: "Problem group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_problem_form
    title_id = get_title_id()
    prob_id = title_id[params[:problem_title]]
    @problem_group_temp = ProblemGroup.new
    @problem_group_temp.group_id = params[:group_id]
    @problem_group_temp.problem_id = prob_id
    puts @probelm_group_temp
    @problem_group_temp.save
    redirect_back(fallback_location: root_path)
  end

  def get_title_id
    @problems = Problem.all
    titles = {}
    for problem in @problems
      titles[problem.title] = problem.id
    end
    titles = titles
  end

  def remove_problem_group
    puts params[:id]
    @student_group_temp = ProblemGroup.where(id: params[:id])
    @student_group_temp.first.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem_group
      @problem_group = ProblemGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def problem_group_params
      params.require(:problem_group).permit(:group_id, :problem_id)
    end
end
