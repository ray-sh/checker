defmodule CheckerWeb.PersonController do
  use CheckerWeb, :controller

  alias Checker.Sample
  alias Checker.Sample.Person

  action_fallback CheckerWeb.FallbackController

  def index(conn, _params) do
    person = Sample.list_person()
    render(conn, "index.json", person: person)
  end

  def create(conn, %{"person" => person_params}) do
    with {:ok, %Person{} = person} <- Sample.create_person(person_params) do
      conn
      |> put_status(:created)
      |> render("show.json", person: person)
    end
  end
end
