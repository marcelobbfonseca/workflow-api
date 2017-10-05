class BusinessProcessesController < ApplicationController
  before_action :set_business_process, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  # GET /business_processes
  # GET /business_processes.json
  def index
    @business_processes = BusinessProcess.all
  end

  # GET /business_processes/1
  # GET /business_processes/1.json
  def show

    @business_process = BusinessProcess.eager_load(lanes:[tasks: [:assignee]] ).find(params[:id])
  end

  # GET /business_processes/new
  def new
    @business_process = BusinessProcess.new
  end

  # GET /business_processes/1/edit
  def edit
  end

  # POST /business_processes
  # POST /business_processes.json
  def create
    @business_process = BusinessProcess.new(business_process_params)

    respond_to do |format|
      if @business_process.save
        format.html { redirect_to @business_process, notice: 'Business process was successfully created.' }
        format.json { render :show, status: :created, location: @business_process }
      else
        format.html { render :new }
        format.json { render json: @business_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_processes/1
  # PATCH/PUT /business_processes/1.json
  def update
    respond_to do |format|
      if @business_process.update(business_process_params)
        format.html { redirect_to @business_process, notice: 'Business process was successfully updated.' }
        format.json { render :show, status: :ok, location: @business_process }
      else
        format.html { render :edit }
        format.json { render json: @business_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_processes/1
  # DELETE /business_processes/1.json
  def destroy
    @business_process.destroy
    respond_to do |format|
      format.html { redirect_to business_processes_url, notice: 'Business process was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_process
      @business_process = BusinessProcess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_process_params
      params.require(:business_process).permit(:name, :current_task, :diagram_id)
    end
end
