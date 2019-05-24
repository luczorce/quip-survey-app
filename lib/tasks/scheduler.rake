desc "This task validates all quip thread ids, and deletes answers when the thread id is not valid"
task :validate_thread_ids => :environment do
  client = Quip::QuipClient.new(access_token: ENV.fetch("QUIP_TOKEN"))
  
  input_text_ids = InputTextAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  input_number_ids = InputNumberAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  textarea_ids = TextareaAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  option_ids = OptionAnswer.select(:quip_id).distinct.map { |a| a.quip_id }
  option_ids = RankedAnswer.select(:quip_id).distinct.map { |a| a.quip_id }

  available_thread_ids = input_text_ids.concat(input_number_ids)
  available_thread_ids.concat(textarea_ids)
  available_thread_ids.concat(option_ids)
  available_thread_ids.uniq!

  puts "testing #{available_thread_ids.size} threads..."
  start_time = Time.now
  invalid_ids = []
  available_thread_ids.each do |thread|
    response = client.get_thread(thread)

    if [400, 403].include? response["error_code"]
      invalid_ids << thread
    end
  end

  end_time = Time.now
  clock = end_time - start_time
  puts "found #{invalid_ids.size} invalid id(s) in ~#{clock.floor} seconds"

  if invalid_ids.size > 0
    puts "removing invalid answers..."
    invalid_answers = []

    invalid_ids.each do |id|
      invalid_answers << InputTextAnswer.where(quip_id: id).destroy_all
      invalid_answers << InputNumberAnswer.where(quip_id: id).destroy_all
      invalid_answers << TextareaAnswer.where(quip_id: id).destroy_all
      invalid_answers << OptionAnswer.where(quip_id: id).destroy_all
      invalid_answers << RankedAnswer.where(quip_id: id).destroy_all
    end

    puts "removed #{invalid_answers.size} answers"
  end
end
