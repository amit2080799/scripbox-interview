require 'optparse'
require 'json'

class NoSql
  def parse
    OptionParser.new do |opts|
      opts.banner = 'Usage: example.rb [options]'

      opts.on('-i Record', '--insert=Record', 'Insert record') do |argument|
        insert_record(argument)
        puts 'Record inserted!'
      end

      opts.on('-d pair', '--delete=pair', 'Delete records') do |argument|
        delete_records(argument)
        puts 'Record(s) deleted!'
      end

      opts.on('-f Value', '--find-all=Value', 'Find records') do |argument|
        searched_data = find_records(argument)
        puts "#{searched_data.size} record(s) found!"
        searched_data.each { |record| puts record }
      end

      opts.on('-s Key,Value Fields', '--select-fields=Key,Value Fields', 'Select fields') do |argument|
        searched_data = select_fields(argument)
        puts "#{searched_data.size} record(s) found!"
        searched_data.each { |record| puts record }
      end

    end.parse!
  end

  def insert_record(record)
    File.open('collection.json', 'a+') { |f| f.puts(record) }
  end

  def delete_records(key_value_pair)
    contents = File.readlines('collection.json')

    File.open('collection.json', 'w') { |f| f.truncate(0) }
    deletion_criteria = JSON.parse(key_value_pair)
    contents.delete_if do |c|
      JSON.parse(c).key?(deletion_criteria.keys.first) &&
        JSON.parse(c).value?(deletion_criteria.values.first)
    end

    contents.each do |content|
      File.open('collection.json', 'a') { |f| f.puts(content) }
    end
  end

  def find_records(value)
    contents = File.readlines('collection.json')
    contents.select do |record|
      parsed_record = JSON.parse(record)
      parsed_record.values.include?(value)
    end
  end

  def select_fields(key_value_pair)
    contents = File.readlines('collection.json')
    key, value = key_value_pair.split(',')

    contents.map do |record|
      parsed_record = JSON.parse(record)
      if ARGV.empty?
        parsed_record if parsed_record.key?(key) && parsed_record.value?(value)
      else
        parsed_record.select { |k,_| ARGV.include?(k) }  if parsed_record.key?(key) && parsed_record.value?(value)
      end
    end.compact!
  end
end

no_sql = NoSql.new
no_sql.parse
