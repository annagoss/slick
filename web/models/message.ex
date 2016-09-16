defmodule Slick.Message do
  use Slick.Web, :model

  schema "messages" do
    field :body, :string
    belongs_to :room, Slick.Room

    timestamps()
  end

  @required_fields ~w(room_id body)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :room_id])
    |> validate_required([:body, :room_id])
  end
end
