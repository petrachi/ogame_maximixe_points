module BlueprintScopes
  def [] name
    # includes(:blueprint).find_by(blueprints: {name: name})
    # includes(:blueprint).find{ |e| e.blueprint.name == name}
    find{ |e| e.blueprint.name == name}
  end

  def where_name name
    case name
    when Regexp
      includes(:blueprint).where("blueprints.name ~* ?", name.source).references(:blueprints)
    else
      includes(:blueprint).where(blueprints: {name: name})
    end
  end
end
