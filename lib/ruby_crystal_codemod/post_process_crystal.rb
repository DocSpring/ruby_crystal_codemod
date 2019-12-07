class PostProcessCrystal
  attr_reader :filename, :contents

  def self.file_read_lines(path)
    File.read(path).lines.map(&:chomp)
  end

  def initialize(filename = "")
    @filename = filename
    @contents = ""
  end

  def filename=(filename)
    @filename = filename
    @contents = ""
  end

  def post_process_crystal
    @contents = +""
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

      @contents << line << "\n"
    end
  end
end
