module SparqlModule
  extended ActiveSupport::Concern

  #
  def remove_prefix(rdf_triple)
    raise 'rdf_triple is nil' if rdf_triple.nil?
    rdf_triple.s.value.split('#')[1]
  end


  def user_task_sparql(file, response)
    result = Array.new
    queryable = RDF::Repository.load(file)

    response[1].stringify_keys['userTask'].each do |user_task|
      user_task = remove_new_line(user_task)

      predicate, object = user_task.split(' ')
      sse = SPARQL.parse("PREFIX news: <#{@ontology.prefix}>
                          SELECT *
                          WHERE { ?s news:#{predicate} news:#{object} }")
      triple_result = queryable.query(sse).first
      subject = remove_prefix(triple_result)

      result.push("#{subject} #{predicate} #{object} é o mais indicado.")
    end
    result
  end




end


# Ontology.last.path_name.path
#queryable = RDF::Repository.load(file)
#sse = SPARQL.parse("PREFIX uni: <http://www.workflow-api.herokuapp.com/ontologies/university#>
#                        SELECT *
#                        WHERE { ?s uni:OWLObjectProperty_studies ?o }"
#)
#result = queryable.query(sse)