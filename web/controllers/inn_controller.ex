defmodule TestApp.InnController do
  use TestApp.Web, :controller
  def check_inn(conn, _params) do
    inns_list = TestApp.InnBaseApi.sorted_list_inns()
    render conn, "check_inn.html", inns_list: inns_list
  end
end
