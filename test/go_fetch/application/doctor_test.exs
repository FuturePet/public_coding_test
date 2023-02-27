defmodule GoFetch.DoctorTest do
  use ExUnit.Case, async: true
  alias GoFetch.Doctor

  import GoFetch.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GoFetch.Repo)
    {:ok, doctor: insert(:doctor)}
  end

  describe "changesets" do
    test "get_doctors/0 gets all doctors" do
      assert Doctor.get_doctors() |> length() == 1
    end

    test "With valid fields creates a doctor" do
      assert {:ok, %Doctor{}} =
               %Doctor{}
               |> Doctor.changeset(%{
                 first_name: "some first name",
                 last_name: "some last name"
               })
               |> GoFetch.Repo.insert()
    end

    test "changeset/2 validate required fields of a doctor" do
      assert %Ecto.Changeset{
               action: _,
               changes: _,
               errors: [
                 first_name: {"can't be blank", [validation: :required]},
                 last_name: {"can't be blank", [validation: :required]}
               ],
               data: _,
               valid?: false
             } =
               %Doctor{}
               |> Doctor.changeset(%{})
    end
  end
end
