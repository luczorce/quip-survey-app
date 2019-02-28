desc "This task validates all quip thread ids, and deletes answers when the thread id is not valid"
task :validate_thread_ids => :environment do
  puts "Finding invalid ids"
  
  input_text_ids = InputTextAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  input_number_ids = InputNumberAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  textarea_ids = TextareaAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  option_ids = InputTextAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  
  # grab the intersection of each of these arrays to grab the unique ids
  # https://stackoverflow.com/a/16114613 
  available_thread_ids = input_text_ids & input_number_ids & textarea_ids & option_ids

  # puts "found #{invalid_ids.size} invalid ids"

  # if 
end
