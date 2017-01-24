module SheetWrap
  class Row
    def initialize(worksheet, row_num)
      @worksheet = worksheet
      @row_num = row_num
      @headers = worksheet.headers
      @getter_names = worksheet.headers.map(&:to_sym)
      @setter_names = worksheet.headers.map{|header| :"#{header}=" }
    end

    def method_missing(name, *args)
      if (index = @getter_names.index(name))
        return @worksheet[@row_num, index + 1]
      elsif (index = @setter_names.index(name))
        return @worksheet[@row_num, index + 1] = args.first
      end
      super
    end

    def save(args = {})
      args.each do |key, value|
        self.send("#{key}=", value)
      end
      @worksheet.save
    end

    def to_h
      @getter_names.each_with_object({}){|name, h| h[name] =  self.send(:"#{name}") }
    end

    alias_method :to_hash, :to_h
  end
end
