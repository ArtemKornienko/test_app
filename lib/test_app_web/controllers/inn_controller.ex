defmodule TestAppWeb.InnController do
  use TestAppWeb, :controller
  def check_inn(conn, _params) do
    inns_list = TestAppWeb.InnBaseApi.sorted_list_inns()
    render conn, "check_inn.html", inns_list: inns_list
  end
end
