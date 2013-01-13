class Solution::C < Solution
  def attach_code
    o  = "objects/#{problem_id}.o"
    so = "objects/libeuler.#{problem_id}.so.#{Time.now.to_i}"
    Dir.chdir(dir_path) do
      File.delete o rescue nil
      `gcc -c -o #{o} #{file_name} -O2 -fPIC`
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