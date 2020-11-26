defmodule Checker.SampleTest do
  use Checker.DataCase

  alias Checker.Sample

  describe "person" do
    alias Checker.Sample.Person

    @valid_attrs %{age: 42, name: "some name"}
    @update_attrs %{age: 43, name: "some updated name"}
    @invalid_attrs %{age: nil, name: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sample.create_person()

      person
    end

    test "list_person/0 returns all person" do
      person = person_fixture()
      assert Sample.list_person() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Sample.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Sample.create_person(@valid_attrs)
      assert person.age == 42
      assert person.name == "some name"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sample.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = Sample.update_person(person, @update_attrs)
      assert person.age == 43
      assert person.name == "some updated name"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Sample.update_person(person, @invalid_attrs)
      assert person == Sample.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Sample.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Sample.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Sample.change_person(person)
    end
  end
end
