class ValidateEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :is_validated, :boolean, default:nil
  end
end
