defmodule TestAppWeb.InnBaseApi do
  import Ecto.Query

  alias TestApp.Repo
  alias TestAppWeb.Structs.InnBase

  def write_inn(%{"body" => inn, "date" => date, "check_result" => check}) do
    Repo.insert(%InnBase{date: date, inn: inn, check: check})
  end

  def write_inn(_date) do
    {:error, "data is wrong"}
  end

  def sorted_list_inns() do
    Repo.all(order_by(InnBase, desc: :inserted_at))
  end
end
