require "log_parser"

describe LogParser do
  before do
    @parser = LogParser.new "#{File.dirname(__FILE__)}/history_test.log"
  end

  describe "load lines" do
    it "should return totals of lines" do
      expect(@parser.lines.size).to eq(4)
    end
  end

  it "should return datatable with all events" do
    expect(@parser.datatable.size).to eq(2)
  end
end
