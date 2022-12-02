class ProblemsController < ApplicationController
  before_action :set_problem, only: %i[ show edit update destroy ]

  before_action :set_languages

  # GET /problems or /problems.json
  def index
    @tags = Tag.all
    @problems = Problem.all
    @map = Hash.new
    for prb in @problems do
      tag_name = Tag.where(id: ProblemTag.where(problem_id: prb.id).pluck(:tag_id)).pluck(:tag)
      @map.store(prb.title,tag_name[0])
    end
    
    render :index
  end

  # GET /problems/1 or /problems/1.json
  def show
    @languages_list = Language.pluck(:pretty_name)
    @attempt = Attempt.new
    @visible_test_cases = @problem.visible_test_cases @problem, current_user.role
    @no_test_cases_prompt = current_user.role?(:student) ? "No example Test Cases provided." : "No Test Cases were specified for that Problem."
  end

  # GET /problems/new
  def new
    @tags = Tag.all
    @problem = Problem.new
    authorize @problem
    # @test_cases = @problem.test_cases
  end

  # GET /problems/1/edit
  def edit
    authorize :problem
    @tags = Tag.all
  end

  # POST /problems or /problems.json
  def create
    @problem = Problem.new(problem_params)
    @problem_tag = ProblemTag.new
    @problem_tag.tag_id = tag_params
    authorize @problem
    puts "entering in create"

    respond_to do |format|
      if @problem.save
        @problem_tag.problem_id = @problem.id
        if @problem_tag.save!
          format.html { redirect_to problem_url(@problem), notice: "Problem was successfully created." }
          format.json { render :show, status: :created, location: @problem }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1 or /problems/1.json
  def update
    authorize :problem
    @tags = Tag.all

    if @problem.update(problem_params)
      redirect_to questions_path
    end
  end

  # DELETE /problems/1 or /problems/1.json
  def destroy
    authorize @problem
    
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Problem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def problem_params
      params.require(:problem).permit(:title, :body, test_cases_attributes: [:id, :input, :output, :example, :_destroy])
    end

    def tag_params
      params.require(:tags)
    end

    def set_languages
      @languages = ['Bash', 'C++', 'Python']
    end
end
