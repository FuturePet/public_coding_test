defmodule GoFetchWeb.PageControllerTest do
  use GoFetchWeb.ConnCase

  test "index", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end
end
