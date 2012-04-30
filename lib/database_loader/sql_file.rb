module DatabaseLoader
  class SqlFile
    attr_accessor :path, :username

    def initialize(path)
      self.path = path
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

    def dependencies(files = [])
      @dependencies = []
      # check for dependencies to files
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
