class StudentGroupsController < ApplicationController
  before_action :set_student_group, only: %i[ show edit update destroy ]

  # GET /student_groups or /student_groups.json
  def index
    @student_groups = StudentGroup.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_group
      @student_group = StudentGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_group_params
      params.require(:student_group).permit(:group_id, :user_id)
    end
end
