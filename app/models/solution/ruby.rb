class Solution::Ruby < Solution
  extension :rb
  
  def attach_code
    code = File.open(path, 'r').read

    m = Module.new do
      instance_eval code
    end
    raise "#{path} did not define `solution`" unless m.respond_to?(:solution)
    m
  end
end