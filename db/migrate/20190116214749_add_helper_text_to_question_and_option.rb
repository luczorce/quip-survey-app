class AddHelperTextToQuestionAndOption < ActiveRecord::Migration[5.2]
  def up
    add_column :input_text_questions, :question_helper, :string
    add_column :input_number_questions, :question_helper, :string
    add_column :textarea_questions, :question_helper, :string
    add_column :option_questions, :question_helper, :string
    add_column :option_questions, :option_helpers, :string, array: true
  end

  def down
    remove_column :input_text_questions, :question_helper, :string
    remove_column :input_number_questions, :question_helper, :string
    remove_column :textarea_questions, :question_helper, :string
    remove_column :option_questions, :question_helper, :string
    remove_column :option_questions, :option_helpers, :string, array: true
  end
end
