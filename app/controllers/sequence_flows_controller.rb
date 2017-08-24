class SequenceFlowsController < ApplicationController
  before_action :set_sequence_flow, only: [:show, :edit, :update, :destroy]

  # GET /sequence_flows
  # GET /sequence_flows.json
  def index
    @sequence_flows = SequenceFlow.all
  end

  # GET /sequence_flows/1
  # GET /sequence_flows/1.json
  def show
  end

  # GET /sequence_flows/new
  def new
    @sequence_flow = SequenceFlow.new
  end

  # GET /sequence_flows/1/edit
  def edit
  end

  # POST /sequence_flows
  # POST /sequence_flows.json
  def create
    @sequence_flow = SequenceFlow.new(sequence_flow_params)

    respond_to do |format|
      if @sequence_flow.save
        format.html { redirect_to @sequence_flow, notice: 'Sequence flow was successfully created.' }
        format.json { render :show, status: :created, location: @sequence_flow }
      else
        format.html { render :new }
        format.json { render json: @sequence_flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequence_flows/1
  # PATCH/PUT /sequence_flows/1.json
  def update
    respond_to do |format|
      if @sequence_flow.update(sequence_flow_params)
        format.html { redirect_to @sequence_flow, notice: 'Sequence flow was successfully updated.' }
        format.json { render :show, status: :ok, location: @sequence_flow }
      else
        format.html { render :edit }
        format.json { render json: @sequence_flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequence_flows/1
  # DELETE /sequence_flows/1.json
  def destroy
    @sequence_flow.destroy
    respond_to do |format|
      format.html { redirect_to sequence_flows_url, notice: 'Sequence flow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequence_flow
      @sequence_flow = SequenceFlow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequence_flow_params
      params.require(:sequence_flow).permit(:target, :source)
    end
end
