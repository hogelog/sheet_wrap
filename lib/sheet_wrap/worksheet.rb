module SheetWrap
  class Worksheet
    extend Forwardable

    attr_reader :drive_worksheet, :headers, :rows

    def_delegator :@drive_worksheet, :title, :title
    def_delegator :@drive_worksheet, :title=, :title=
    def_delegator :@drive_worksheet, :[], :[]
    def_delegator :@drive_worksheet, :[]=, :[]=
    def_delegator :@drive_worksheet, :num_cols, :num_cols
    def_delegator :@drive_worksheet, :num_rows, :num_rows
    def_delegator :@drive_worksheet, :save, :save

    def initialize(drive_worksheet)
      @drive_worksheet = drive_worksheet
      load
    end

    def load
      @headers = (1..num_cols).map{|col| drive_worksheet[1, col] }

      @rows = (2..num_rows).map do |row|
        ::SheetWrap::Row.new(self, row)
      end
    end

    def reload
      @drive_worksheet.reload
      load
    end
  end
end
