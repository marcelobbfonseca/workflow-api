class LanesController < ApplicationController
  before_action :set_lane, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /lanes
  # GET /lanes.json
  def index
    @lanes = Lane.all
  end

  # GET /lanes/1
  # GET /lanes/1.json
  def show
  end

  # GET /lanes/new
  def new
    @lane = Lane.new
  end

  # GET /lanes/1/edit
  def edit
  end

  # POST /lanes
  # POST /lanes.json
  def create
    @lane = Lane.new(lane_params)

    respond_to do |format|
      if @lane.save
        format.html { redirect_to @lane, notice: 'Lane was successfully created.' }
        format.json { render :show, status: :created, location: @lane }
      else
        format.html { render :new }
        format.json { render json: @lane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lanes/1
  # PATCH/PUT /lanes/1.json
  def update
    respond_to do |format|
      if @lane.update(lane_params)
        format.html { redirect_to @lane, notice: 'Lane was successfully updated.' }
        format.json { render :show, status: :ok, location: @lane }
      else
        format.html { render :edit }
        format.json { render json: @lane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lanes/1
  # DELETE /lanes/1.json
  def destroy
    @lane.destroy
    respond_to do |format|
      format.html { redirect_to lanes_url, notice: 'Lane was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lane
      @lane = Lane.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lane_params
      params.require(:lane).permit(:name)
    end
end
