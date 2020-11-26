defmodule CheckerWeb.PersonControllerTest do
  use CheckerWeb.ConnCase

  alias Checker.Sample
  alias Checker.Sample.Person

  @create_attrs %{
    age: 42,
    name: "some name"
  }
  @update_attrs %{
    age: 43,
    name: "some updated name"
  }
  @invalid_attrs %{age: nil, name: nil}

  def fixture(:person) do
    {:ok, person} = Sample.create_person(@create_attrs)
    person
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create person" do
    test "renders person when data is valid", %{conn: conn} do
      conn = post(conn, Routes.person_path(conn, :create), person: @create_attrs)

      assert %{
               "id" => id,
               "age" => 42,
               "name" => "some name"
             } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.person_path(conn, :create), person: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_person(_) do
    person = fixture(:person)
    %{person: person}
  end
end
