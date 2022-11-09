class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    #@groups = Group.all
    @groups = Group.where(author_id: cookies.signed[:user_id])
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
