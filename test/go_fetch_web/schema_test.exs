defmodule GoFetchWeb.SchemaTest do
  use GoFetchWeb.ConnCase, async: true

  test "validate /api/graphiql is working", %{conn: conn} do
    conn = post(conn, "/api/graphiql", %{"query" => %{}})

    assert json_response(conn, 200)
  end
end
