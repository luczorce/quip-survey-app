class AddTypeToHeader < ActiveRecord::Migration[5.2]
  def up
    add_column :survey_headers, :question_type, :string, default: "header"
  end

  def down
    remove_column :survey_headers, :question_type
  end
end
