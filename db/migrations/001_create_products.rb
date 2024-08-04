Sequel.migration do
  change do
    create_table(:products) do
      primary_key :id
      String :name, null: false
      String :price, null: false
    end
  end
end
