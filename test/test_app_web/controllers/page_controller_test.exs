defmodule TestAppWeb.PageControllerTest do
  use TestAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Check INN!"
  end
end
