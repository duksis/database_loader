module DatabaseLoader
  class SqlFile
    attr_accessor :path, :username

    include Comparable

    def initialize(path)
      self.path = path
    end

    def <=>(other)
      if self.object_id == other.object_id then 0
      elsif self.dependencies.size > 1 && self.dependencies.include?(other) then -1
      else 1
      end
    end

    def type
      path.split(/[\/\\]/)[-2].to_sym
    end

    def name
      File.basename(path)
    end

    def read
      File.read(path)
    end

    def render
      Template.new(read).render("username" => username)
    end
    alias_method :to_s, :render

    def dependencies(files = nil)
      return @dependencies || [] unless files.present?
      # check for dependencies to files
      @dependencies = []
      files.each do |file|
        unless self == file
          file.statements.each do |statment|
            (@dependencies.append(file); break) if self.render.include?(statment.name)
          end
        end
      end
      @dependencies
    end

    def statements
      render.split(/\r?\n\/\r?\n/).reject(&:blank?).map do |str|
        SqlStatement.new(str)
      end
    end
  end
end
