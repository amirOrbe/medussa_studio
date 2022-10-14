defmodule MedussaStudio.Repo.Migrations.CreateAppointment do
  use Ecto.Migration

  def up do
    create table(:appointment) do
      add :date, :string
      add :time, :string
      add :service, :string
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:appointment, [:user_id])
  end

  def down do
    drop table(:appointment)
  end
end
