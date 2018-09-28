defmodule DetectiveWeb.PageControllerTest do
  use DetectiveWeb.ConnCase

  test "GET /", %{conn: conn} do
    response = conn |> get("/") |> html_response(200)

    assert response =~ "Welcome to Scotland Yard Reports!"
  end
end
