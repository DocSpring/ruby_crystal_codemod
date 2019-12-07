require "spec_helper"

RSpec.describe PostProcessCrystal do
  it "mocks the call to File.read_lines" do
    allow(PostProcessCrystal).to receive(:file_read_lines).with("example_file").and_return([
      "hey, world!",
      "how's it hanging",
    ])

    ppc = PostProcessCrystal.new("example_file")
    ppc.post_process_crystal
    expect(ppc.contents).to eq("hey, world!\nhow's it hanging\n")
  end

  it "removes any content between #~# BEGIN ruby and #~# END ruby" do
    allow(PostProcessCrystal).to receive(:file_read_lines)
                                   .with("example_file")
                                   .and_return(
                                     <<-CODE.lines.map(&:chomp)
      def foo
        #~# BEGIN ruby
        return 234
        #~# END ruby
        123
      end
      #~# BEGIN ruby
      puts "Code called from Ruby!"
      # comment should be removed
      #~# END ruby

      puts foo
      CODE

                                   
)

    ppc = PostProcessCrystal.new("example_file")
    ppc.post_process_crystal
    expect(ppc.contents).to eq(
                              <<-CODE
      def foo
        123
      end

      puts foo
      CODE

                            
)
  end

  it "uncomments any content between #~# BEGIN crystal and #~# END crystal" do
    allow(PostProcessCrystal).to receive(:file_read_lines).with("example_file").and_return(
                                   <<-CODE.lines.map(&:chomp)
      def foo
        123
        #~# BEGIN crystal
        # return 456
        #~# END crystal
      end
      #~# BEGIN crystal
      # puts "Code called from Crystal!"
      # # comment should be present
      #~# END crystal
      puts foo
      CODE

                                 
)

    ppc = PostProcessCrystal.new("example_file")
    ppc.post_process_crystal
    expect(ppc.contents).to eq(
                              <<-CODE
      def foo
        123
        return 456
      end
      puts "Code called from Crystal!"
      # comment should be present
      puts foo
      CODE

                            
)
  end

  it "removes all Ruby lines and uncomments all Crystal lines" do
    allow(PostProcessCrystal).to receive(:file_read_lines).with("example_file").and_return(
                                   <<-CODE.lines.map(&:chomp)
      class Foo
        property :foo, :bar

        #~# BEGIN ruby
        def initialize(foo, bar)
          @foo = foo
          @bar = bar
        end
        #~# END ruby
        #~# BEGIN crystal
        # @foo : Int32
        # @bar : Int32
        # def initialize(@foo: Int32, @bar : Int32)
        # end
        #~# END crystal
      end
      CODE

                                 
)

    ppc = PostProcessCrystal.new("example_file")
    ppc.post_process_crystal
    # NOTE: This is a post-processing step. The rufo formatting code
    # must run before this, and will translate attr_accessor into property, etc.
    expect(ppc.contents).to eq(
                              <<-CODE
      class Foo
        property :foo, :bar

        @foo : Int32
        @bar : Int32
        def initialize(@foo: Int32, @bar : Int32)
        end
      end
      CODE

                            
)
  end
end
