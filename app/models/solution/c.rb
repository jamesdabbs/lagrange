class Solution::C < Solution
  extension :c

  def attach_code
     c = "#{problem_id}.c"
     o = "objects/#{problem_id}.o"
    so = "objects/libeuler.#{problem_id}.so.#{Time.now.to_i}"
    Dir.chdir(dir_path) do
      raise "No solution found (in `#{path}`)" unless File.exists? c
      File.delete o rescue nil
      `gcc -c -o #{o} #{c} -O2 -fPIC`
      `gcc -shared -W1,-soname,#{so} -o #{so} #{o}`
    end

    lib_path = "#{dir_path}/#{so}"
    Module.new do
      extend FFI::Library
      ffi_lib lib_path
      attach_function :solution, [], :int
    end
  end
end