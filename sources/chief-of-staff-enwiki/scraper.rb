#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Image'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[image rank name title dates].freeze
    end

    def empty?
      raw_combo_date.include?('?') || raw_combo_date.include?('Early')
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
