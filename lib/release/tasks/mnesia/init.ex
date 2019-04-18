defmodule Release.Tasks.Mnesia.Init do
  @repo Corto.Repo.Mnesia

  def run() do
    :ok = Node.list()
          |> run()
    File.touch!("ready")
  end

  defp run([]), do: init_cluster()
  defp run([node | _]), do: join_cluster(node)

  defp init_cluster() do
    :ok = init_schema()
    _ = migrate()
    :ok
  end

  defp join_cluster(node) do
    :ok = db_down()
    # EctoMnesia.storage_down also starts Mnesia after stop
    :ok = connect(node)
    :ok = copy_schema(node)
    :ok = copy_tables()
    :ok
  end

  defp connect(node) do
    case :mnesia.change_config(:extra_db_nodes, [node]) do
      {:ok, [_node]} ->
        :ok
      {:ok, []} ->
        {:error, :connection_failure}
      error ->
        {:error, error}
    end
  end

  defp db_up() do
    case @repo.__adapter__.storage_up(@repo.config) do
      :ok ->
        IO.puts "The database for Mnesia has been created"
        :ok
      {:error, :already_up} ->
        IO.puts "The database for Mnesia has already been created"
        :ok
      {:error, error} ->
        IO.puts "The database for Mnesia couldn't be created: #{inspect error}"
        :error
    end
  end

  defp db_down() do
    case @repo.__adapter__.storage_down(@repo.config) do
      :ok ->
        IO.puts "Mnesia DB has been dropped"
        :ok
      {:error, :already_down} ->
        IO.puts "Mnesia DB has already been dropped"
        :ok
      {:error, reason} ->
        IO.puts "Mnesia DB couldn't be dropped: #{inspect reason}"
        :error
    end
  end

  defp init_schema() do
    case extra_nodes() do
      [] ->
        db_up()
      [_ | _] ->
        :ok
    end
  end

  defp copy_schema(node) do
    case :mnesia.change_table_copy_type(:schema, node, :disc_copies) do
      {:atomic, :ok} ->
        :ok
      {:aborted, {:already_exists, :schema, _, :disc_copies}} ->
        :ok
      {:aborted, error} ->
        {:error, error}
    end
  end

  defp copy_tables() do
    tables()
    |> Enum.each(fn(table) ->
      :mnesia.add_table_copy(table, node(), :disc_copies)
    end)
  end

  defp extra_nodes() do
    :mnesia.system_info(:extra_db_nodes)
  end

  defp migrate() do
    Ecto.Migrator.run(@repo, migrations_path(), :up, all: true)
  end

  def migrations_path(), do: Path.join([repo_path(), "migrations"])
  def repo_path(), do: Path.join([priv_dir(), "mnesia"])
  def priv_dir(), do: "#{:code.priv_dir(:corto)}"

  defp tables() do
    :mnesia.system_info(:tables) -- [:schema_migrations, :schema, :id_seq]
  end
end
