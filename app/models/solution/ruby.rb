class Solution::Ruby < Solution
  def attach_code
    source = code
    m = Module.new do
      instance_eval source
    end
    raise "#{path} did not define `solution`" unless m.respond_to?(:solution)
    m
  end
end