class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  helper_method :get_users_of_group, :get_problems_of_group
  # GET /groups or /groups.json
  def index
    @groups = Group.where(author_id: cookies.signed[:user_id])
    @student_groups = StudentGroup.all
    @users = User.all
    @problems = Problem.all
    @problem_group = ProblemGroup.all
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
    @group.author_id ||= cookies.signed[:user_id]
  end

  # GET /groups/1/edit
  def edit
  end

  def details()
    puts "reached test block"
    id = params[:id]
    puts "current id is " + id
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

      if @group.save
        redirect_to instructors_path
      end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    
      if @group.update(group_params)
        redirect_to instructors_path
      end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    if @group.destroy
      redirect_to instructors_path
    end
  end

  def get_users_of_group
    student_group_mappings = StudentGroup.where(group_id: params[:id])
  end

  def get_problems_of_group
    problem_group_mappings = ProblemGroup.where(group_id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:author_id, :group_title, :description)
    end
end
