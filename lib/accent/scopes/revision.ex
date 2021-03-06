defmodule Accent.Scopes.Revision do
  import Ecto.Query, only: [from: 2]

  @doc """
  ## Examples

    iex> Accent.Scopes.Revision.from_project(Accent.Revision, "test")
    #Ecto.Query<from r in Accent.Revision, join: l in assoc(r, :language), where: r.project_id == ^\"test\", order_by: [desc: r.master, asc: l.name]>
  """
  @spec from_project(Ecto.Queryable.t(), String.t()) :: Ecto.Queryable.t()
  def from_project(query, project_id) do
    from(
      revision in query,
      where: [project_id: ^project_id],
      inner_join: language in assoc(revision, :language),
      order_by: [desc: revision.master, asc: language.name]
    )
  end

  @doc """
  ## Examples

    iex> Accent.Scopes.Revision.from_language(Accent.Revision, "test")
    #Ecto.Query<from r in Accent.Revision, where: r.language_id == ^\"test\">
  """
  @spec from_language(Ecto.Queryable.t(), String.t()) :: Ecto.Queryable.t()
  def from_language(query, language_id) do
    from(r in query, where: [language_id: ^language_id])
  end

  @doc """
  ## Examples

    iex> Accent.Scopes.Revision.master(Accent.Revision)
    #Ecto.Query<from r in Accent.Revision, where: r.master == true>
  """
  @spec master(Ecto.Queryable.t()) :: Ecto.Queryable.t()
  def master(query) do
    from(r in query, where: [master: true])
  end

  @doc """
  ## Examples

    iex> Accent.Scopes.Revision.slaves(Accent.Revision)
    #Ecto.Query<from r in Accent.Revision, where: r.master == false>
  """
  @spec slaves(Ecto.Queryable.t()) :: Ecto.Queryable.t()
  def slaves(query) do
    from(r in query, where: [master: false])
  end
end
