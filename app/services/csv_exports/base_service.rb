# frozen_string_literals: true

module CsvExports
  class BaseService
    require 'csv'

    def initialize(collection, csv_columns = nil)
      @collection = collection
      @csv_columns = csv_columns
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << column_names

        # NOTE here was the original logic
        # if iterable?(collection)
        #   collection.each do |item|
        #     csv << data(item)
        #   end
        # else
        #   csv << data(collection)
        # end

        # NOTE here is a very survey specific implementation
        collection.each do |key, value|
          csv << data()
        end
      
      end.encode('cp1252').force_encoding('UTF-8')
    end


    private

    attr_reader :collection, :csv_columns

    def iterable?(object)
      object.respond_to?(:each)
    end

    def column_names
      if csv_columns.blank? && collection.present?
        collection.first.class.column_names
      else
        csv_columns
      end
    end

    def data(item)
      data = []
      column_names.each do |column|
        data << item.public_send(column)
      end

      data
    end
  end
end