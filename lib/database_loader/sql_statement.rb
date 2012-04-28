module DatabaseLoader
  class SqlStatement
    attr_accessor :contents

    # Regular expresion for parsing PL/SQL statements
    SQLREGEXP=/(create\s|alter\s|drop\s|)(?# select statement type
    )(?:or\s*replace|)(?:on\s*force\s*|\sforce\s*|\s*public\s*|unique\s*|\s*|)(?# remove unnecessary sql flags
    )(grant\s*|view\s|materialized\s*view\s|package\s*body\s|package\s|procedure\s|function\s|sequence\s|index\s|synonym\s|)(?# select statement type
    )(?:\s*select|\s*execute|,|\s*on\s*)*(?# remove unnecessary sql flags
    )(?:\w+\.|)(\w+)(?# select object name
    )(?:\s|\(|;|$)(?# object name seperator
    )/i

    def initialize(contents)
      self.contents = contents.squish
    end

    def excerpt
      text = contents.gsub(/\-\-[^\r\n]*/, "").squish
      if text.size > 60
        "#{text.first(60)} ..."
      else
        text
      end
    end

    def name
      contents.split(SQLREGEXP)[3]
    end

    def type
      contents.split(SQLREGEXP)[2].try(:squish).try(:downcase)
    end

    def execute
      ActiveRecord::Base.connection.execute(contents)
    end

    def to_s
      contents
    end

    def inspect
      "#<#{self.class}:#{object_id} name: #{name || 'nil'}, type: #{type || 'nil'}, excerpt: #{excerpt || 'nil'}>"
    end
  end
end
