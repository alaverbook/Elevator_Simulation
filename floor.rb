require_relative 'person'

class Floor
	attr_reader :floor_number, :persons, :call_buttons, :FLOOR_MAX_PERSONS

	@@FLOOR_MAX_PERSONS = 30	

	def initialize(args={})
		@floor_number	= args[:floor_number]	|| default_floor_number
		@persons		= args[:persons]		|| default_persons
		@call_buttons	= {up: "not pressed", down: "not pressed"}
		@@FLOOR_MAX_PERSONS = 30
	end

	def default_floor_number
		raise NotImplementedError
	end

	def self.FLOOR_MAX_PERSONS
		@@FLOOR_MAX_PERSONS
	end

	def default_persons
		Array.new
	end

	def press_up_call
		@call_buttons["up"] = "pressed"
	end

	def press_down_call
		@call_buttons["down"] = "pressed"
	end

	def up_call_cancel
		@call_buttons["up"] = "not pressed"
	end

	def down_call_cancel
		@call_buttons["down"] = "not pressed"
	end

	def remove_person(person)
		@persons.delete(person)
	end

	def add_person(person)
		@persons.push(person)
	end

	def to_s
		result = "Floor #{@floor_number} : elevator calls? "
		call = false
		if @call_buttons["up"] == "pressed"
			result += "up "
			call = true
		end
		if @call_buttons["down"] == "pressed"
			if call
				result += "& down"
			else
				result += "down"
				call = true
			end
		end
		if !call
			result += "no"
		end
		result += "\n"
		@persons.each do |person|
			result += person.to_s
		end
		return result
	end

	def tick
		up_call_cancel
		down_call_cancel
		@persons.each do |person|
			if person.desire == "up"
				press_up_call
			elsif person.desire == "down"
				press_down_call
			end
		end
	end
end