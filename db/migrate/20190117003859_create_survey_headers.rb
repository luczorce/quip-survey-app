class CreateSurveyHeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_headers do |t|
      t.string :value
      t.integer :order
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
