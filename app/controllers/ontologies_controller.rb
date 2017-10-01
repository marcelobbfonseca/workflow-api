class OntologiesController < ApplicationController
  before_action :set_ontology, only: [:show, :edit, :update, :destroy, :sparql_query]
  before_action :authenticate_user!, only: [:show, :create, :edit, :update, :destroy]
  #load_and_authorize_resource
  skip_before_action :verify_authenticity_token

  include BpmnDirFileHandler
  include SparqlModule

  # GET /ontologies
  # GET /ontologies.json
  def index
    @ontologies = Ontology.all
  end

  # GET /ontologies/1
  # GET /ontologies/1.json
  def show
  end

  # GET /ontologies/new
  def new
    @ontology = Ontology.new
  end

  # GET /ontologies/1/edit
  def edit
  end

  # POST /ontologies
  # POST /ontologies.json
  def create
    @ontology = Ontology.new(ontology_params)

    respond_to do |format|
      if @ontology.save
        format.html { redirect_to @ontology, notice: 'Ontology was successfully created.' }
        format.json { render :show, status: :created, location: @ontology }
      else
        format.html { render :new }
        format.json { render json: @ontology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ontologies/1
  # PATCH/PUT /ontologies/1.json
  def update
    respond_to do |format|
      if @ontology.update(ontology_params)
        format.html { redirect_to @ontology, notice: 'Ontology was successfully updated.' }
        format.json { render :show, status: :ok, location: @ontology }
      else
        format.html { render :edit }
        format.json { render json: @ontology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ontologies/1
  # DELETE /ontologies/1.json
  def destroy
    @ontology.destroy
    respond_to do |format|
      format.html { redirect_to ontologies_url, notice: 'Ontology was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 # POST ontologies/1
  def sparql_query

    #response = "[{\"process\":\"produção da notícia web\n\"},{\"userTask\":[\"pré-apura pauta\n\",\"apresenta Pauta\n\",\"apura pauta\n\",\"redige matéria\n\",\"revisa matéria\n\"]}] "
    response = HTTParty.get("http://localhost:3000/bpmn/parser.json?name=#{params[:bpmn_name]}", {timeout: 10})
    response = JSON.parse(response.body)
    byebug

    # usertask sparql query
    result = user_task_sparql(@ontology.path_name.path, response)

    # show result.
    render json: { message: result }, status: :ok
    # check for role problems, unless something wrong. notify then create new bpmn.
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ontology
      @ontology = Ontology.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ontology_params
      params.require(:ontology).permit(:path_name, :name, :prefix)
    end
end
