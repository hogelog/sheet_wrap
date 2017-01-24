require "sheet_wrap/version"
require "sheet_wrap/worksheet"
require "sheet_wrap/row"

module SheetWrap
  def self.wrap(drive_spreadsheet)
    ::SheetWrap::Worksheet.new(drive_spreadsheet)
  end
end
