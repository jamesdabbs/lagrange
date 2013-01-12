class Solution::Ruby < Solution
  def attach_code
    source = path
    m = Module.new do
      instance_eval File.open(source, 'r').read
    end
    raise "#{source} did not define `solution`" unless m.respond_to?(:solution)
    m
  end
end