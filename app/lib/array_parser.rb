require 'spreadsheet'
require 'securerandom'

class ArrayParser
  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def output
    data.each_with_index do |row, idx|
      sheet1.row(idx).push *row
    end

    book.write file

    {
      'body' => file.string.force_encoding('binary'),
      'filename' => filename
    }
  end

  private

  def file
    @file ||= StringIO.new
  end

  def filename
    name = options['filename'].to_s

    if name.empty?
      name = SecureRandom.uuid
    else
      name = File.basename(name, '.xls')
    end

    "#{name}.xls"
  end

  def data
    options['data']
  end

  def book
    @book ||= Spreadsheet::Workbook.new
  end

  def sheet1
    @sheet1 ||= book.create_worksheet
  end
end
