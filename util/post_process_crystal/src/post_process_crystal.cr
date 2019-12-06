class PostProcessCrystal
  getter :filename, :contents
  @filename : String
  @contents : String

  def self.file_read_lines(path)
    File.read_lines(path)
  end

  def initialize(filename : String = "")
    @filename = filename
    @contents = ""
  end

  def filename=(filename)
    self.initialize(filename)
  end

  def post_process_crystal
    @contents = String.build do |io|
      lines = self.class.file_read_lines(@filename)

      current_lang = nil
      regex = /^\s*# ?~# (?<action>(BEGIN|END)) (?<lang>(ruby|crystal))/
      uncomment_regex = /^(?<indent>\s*)# ?/
      lines.each do |line|
        matches = regex.match(line)
        if matches
          case matches["action"]
          when "BEGIN"
            current_lang = matches["lang"]
          when "END"
            current_lang = nil
          end
          next
        end
        case current_lang
        when "ruby"
          next
        when "crystal"
          line = line.sub(uncomment_regex, "\\k<indent>")
        end

        io << line << "\n"
      end
    end
  end
end
