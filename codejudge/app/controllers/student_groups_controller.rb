class StudentGroupsController < ApplicationController
  before_action :set_student_group, only: %i[ show edit update destroy ]
  helper_method :get_users_of_group, :get_problems_of_group, :get_user


  # GET /student_groups or /student_groups.json
  def index
    @student_groups = StudentGroup.all
    @users = User.all
    @problems = Problem.all
    @problem_group = ProblemGroup.all
    @group_ids = StudentGroup.where(user_id: session[:user_id]).pluck(:group_id)
    puts @group_ids
    @groups_2 = Group.where(id: @group_ids)
    puts @groups_2
  end

  # GET /student_groups/1 or /student_groups/1.json
  def show
  end

  # GET /student_groups/new
  def new
    @student_group = StudentGroup.new
  end

  # GET /student_groups/1/edit
  def edit
  end

  def joinclass
    group_id= Group.find_by(classcode: user_params_2).id
    puts session[:user_id]

    @student_group = StudentGroup.new
    @student_group.group_id = group_id
    @student_group.user_id = session[:user_id]

    if @student_group.save
      redirect_to student_groups_path, notice: 'Joined class successfully'
    else
      redirect_to student_groups_path, notice: 'Unable to join class'
    end
  end


  # POST /student_groups or /student_groups.json
  def create
    @student_group = StudentGroup.new(student_group_params)

    respond_to do |format|
      if @student_group.save
        format.html { redirect_to student_group_url(@student_group), notice: "Student group was successfully created." }
        format.json { render :show, status: :created, location: @student_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_groups/1 or /student_groups/1.json
  def update
    respond_to do |format|
      if @student_group.update(student_group_params)
        format.html { redirect_to student_group_url(@student_group), notice: "Student group was successfully updated." }
        format.json { render :show, status: :ok, location: @student_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_groups/1 or /student_groups/1.json
  def destroy
    @student_group.destroy

    respond_to do |format|
      format.html { redirect_to student_groups_url, notice: "Student group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_users_of_group
      student_group_mappings = StudentGroup.where(group_id: params[:id])
#       @students_of_this_group = []
#
#       student_group_mappings.each do |t|
#             m = User.find(t.user_id)
#             @students_of_this_group.push(user: m)
#             puts " Current student is : " + m.username
#       end   
  end

    def get_problems_of_group
        problem_group_mappings = ProblemGroup.where(group_id: params[:id])
  #       @students_of_this_group = []
  #
  #       student_group_mappings.each do |t|
  #             m = User.find(t.user_id)
  #             @students_of_this_group.push(user: m)
  #             puts " Current student is : " + m.username
  #       end
    end

    def addition_from
      puts params
      puts params[:email]
      @student_group_temp = StudentGroup.new
      @student_group_temp.group_id = params[:group_id]
      @student_group_temp.user_id = get_user.first.id
      puts @student_group_temp
      @student_group_temp.save
      redirect_back(fallback_location: root_path)
    end
    
    def get_user 
      user = User.where(email: params[:email])
    end

    def remove_student_group
      puts params[:id]
      @student_group_temp = StudentGroup.where(id: params[:id])
      @student_group_temp.first.destroy
      redirect_back(fallback_location: root_path)
    end

    def addition
      id = params[:group_id]
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_group
      @student_group = StudentGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_group_params
      params.require(:student_group).permit(:group_id, :user_id)
    end

    def user_params_2
      params.require(:classcode)
    end
end
