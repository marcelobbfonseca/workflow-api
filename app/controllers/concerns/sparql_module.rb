module SparqlModule
  extended ActiveSupport::Concern


  #
  def remove_prefix(rdf_triple)
    rdf_triple.s.value.split('#')[1]
  end


  def user_task_sparql(file, response)
    result = Array.new
    queryable = RDF::Repository.load(file)
    response[1]['userTask'].each do |userTask|
      remove_new_line(userTask)
      predicate, object = usertask.split(' ')
      sse = SPARQL.parse("PREFIX news: <http://www.semanticweb.org/2017/multi-newsroom#>
                          SELECT *
                          WHERE { ?s ?#{predicate} ?#{object} }")
      triple_result = queryable.query(sse).first
      subject = remove_prefix(triple_result)

      result.push("Sujestão: #{subject} #{predicate} #{object} é o mais indicado.")
    end
    result
  end
end



#queryable = RDF::Repository.load(file)
#sse = SPARQL.parse("PREFIX uni: <http://www.workflow-api.herokuapp.com/ontologies/university#>
#                        SELECT *
#                        WHERE { ?s uni:OWLObjectProperty_studies ?o }"
#)
#result = queryable.query(sse)