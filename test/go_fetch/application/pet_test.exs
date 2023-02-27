defmodule GoFetch.PetTest do
  use ExUnit.Case, async: true
  alias GoFetch.Pet

  import GoFetch.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GoFetch.Repo)
  end

  describe "changesets" do
    test "With valid fields creates a pet" do
      user = insert(:user)

      assert {:ok, %Pet{}} =
               %Pet{}
               |> Pet.changeset(%{
                 name: "some name",
                 user_id: user.id
               })
               |> GoFetch.Repo.insert()
    end

    test "changeset/2 validate required fields of a pet" do
      assert %Ecto.Changeset{
               action: _,
               changes: _,
               errors: [
                 name: {"can't be blank", [validation: :required]},
                 user_id: {"can't be blank", [validation: :required]}
               ],
               data: _,
               valid?: false
             } =
               %Pet{}
               |> Pet.changeset(%{})
    end
  end
end
