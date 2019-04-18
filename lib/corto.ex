defmodule Corto do
  @moduledoc """
  Corto keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def env() do
    Application.get_env(:corto, :env, :undefined)
  end
end
