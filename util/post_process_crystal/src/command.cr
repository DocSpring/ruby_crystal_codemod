require "./post_process_crystal"

if ARGV.size == 0
  STDERR.puts "Usage: #{PROGRAM_NAME} <files>"
  exit 1
end

ppc = PostProcessCrystal.new
puts "Processing #~# BEGIN and #~# END comments..."

ARGV.each_with_index do |arg, i|
  puts "=> Processing file: #{arg}"
  ppc.filename = arg
  ppc.post_process_crystal
  File.write(arg, ppc.contents)
end
