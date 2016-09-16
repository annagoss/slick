defmodule Slick.Room do
  use Slick.Web, :model

  schema "rooms" do
    field :title, :string
    field :description, :string

    # add an association between room and messages
    has_many :messages, Slick.Message

    timestamps()
  end

  @required_fields ~w(title)
  @optional_fields ~w(description)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:title, ~r/#/, message: "needs a hash symbol")
  end
end
