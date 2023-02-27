defmodule GoFetch.UserTest do
  use ExUnit.Case, async: true
  alias GoFetch.User

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GoFetch.Repo)
  end

  describe "changesets" do
    test "With valid fields creates a user" do
      assert {:ok, %User{}} =
               %User{}
               |> User.changeset(%{
                 email: "some@email.com",
                 name: "some name"
               })
               |> GoFetch.Repo.insert()
    end

    test "changeset/2 validate required fields of a user" do
      assert %Ecto.Changeset{
               action: _,
               changes: _,
               errors: [
                 email: {"can't be blank", [validation: :required]}
               ],
               data: _,
               valid?: false
             } =
               %User{}
               |> User.changeset(%{})
    end
  end
end
