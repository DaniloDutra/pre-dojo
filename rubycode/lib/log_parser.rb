require "date_utils"

class LogParser
  attr_reader :datatable, :lines, :logfile

  def initialize(logfile = "#{File.dirname(__FILE__)}/../history.log")
    @logfile = logfile
    file = File.open(logfile, "r")
    @lines = []
    file.each_line do |line|
      @lines << line
    end
  end

  def datatable
    return @datatable if @datatable

    @datatable = []
    match = nil

    @lines.each do |line|
      if match_data = started_match?(line)
        match = match_data
      elsif id = ended_match?(line)
        match = nil
      elsif event = match_event?(line) and match
        event[:match_id] = match[:id]
        event[:match_created_at] = match[:created_at]
        @datatable << event
      end
    end
    @datatable
  end

  private

  def started_match?(line)
    m = /^(\d{2}\/\d{2}\/\d{4}) (\d{2}:\d{2}:\d{2}) - New match (\d+) has started$/.match line
    m.nil? ? nil : { id: m[3], created_at: DateUtils.parse("#{m[1]} #{m[2]}") }
  end

  def ended_match?(line)
    m = /^(\d{2}\/\d{2}\/\d{4}) (\d{2}:\d{2}:\d{2}) - Match (\d+) has ended$/.match line
    m.nil? ? nil : { id: m[3], created_at: DateUtils.parse("#{m[1]} #{m[2]}") }
  end

  def match_event?(line)
    m = /^(\d{2}\/\d{2}\/\d{4}) (\d{2}:\d{2}:\d{2}) - (\S+) killed (\S+) (using|by) (\w+)$/.match line
    m.nil? ? nil : { from_player: m[3], to_player: m[4], weapon: m[5], created_at: DateUtils.parse("#{m[1]} #{m[2]}") }
  end

end
