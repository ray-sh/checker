defmodule CheckerWeb.PersonView do
  use CheckerWeb, :view
  alias CheckerWeb.PersonView

  def render("index.json", %{person: person}) do
    %{data: render_many(person, PersonView, "person.json")}
  end

  def render("show.json", %{person: person}) do
    %{data: render_one(person, PersonView, "person.json")}
  end

  def render("person.json", %{person: person}) do
    %{id: person.id,
      name: person.name,
      age: person.age}
  end
end
