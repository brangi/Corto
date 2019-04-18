defmodule Corto.Repo.Mnesia do
  use Ecto.Repo, otp_app: :corto

  def init(_, opts) do
    {:ok, opts}
  end
end
