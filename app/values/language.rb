class Language
	attr_reader :name, :extension

	def initialize(name, extension)
		@name      = name
		@extension = extension
	end

	def to_s
		@name
	end

	def solution_class
		Solution.const_get name
	end

	class << self
		include Enumerable

		def each(&block)
			[ Language.new('C', :c), Language.new('Ruby', :rb) ].each(&block)
		end

		def by_name(name)
			Language.find { |l| l.name == name }
		end

		def by_extension(extension)
			Language.find { |l| l.extension == extension }
		end
	end
end