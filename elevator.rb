require_relative 'person'
require_relative 'floor'

class Elevator
	attr_reader :location, :persons, :direction, :ELEV_MAX_PERSONS

	@@ELEV_MAX_PERSONS = 8

	def initialize(args={})
		@location		= args[:location]	|| default_location
		@persons		= args[:persons]	|| default_persons
		@direction		= default_direction
		@name			= args[:name]
		@@ELEV_MAX_PERSONS = 8
	end

	def default_location
		raise NotImplementedError
	end

	def self.ELEV_MAX_PERSONS
		@@ELEV_MAX_PERSONS
	end

	def default_direction
		"still"
	end

	def set_location(floor)
		@location = floor
	end

	def default_persons
		Array.new
	end

	def remove_person(person)
		if @location.persons.size < Floor.FLOOR_MAX_PERSONS
			@persons.delete(person)
			@location.add_person(person)
			person.update_location(@location)
		end
	end

	def add_person(person)
		if @@ELEV_MAX_PERSONS > @persons.size
			@persons.push(person)
			@location.remove_person(person)
			person.update_location(self)
		end
	end

	def set_direction_up
		@direction = "up"
	end

	def set_direction_down
		@direction = "down"
	end

	def set_direction_still
		@direction = "still"
	end

	def to_s
		"\t\t[#{@name} : #{@persons.size} passengers : #{@direction}]\n"
	end

	def tick
		people_to_remove = Array.new
		@persons.each do |person|
			if person.desire == "stay"
				people_to_remove.push(person)
			end
		end
		people_to_remove.each do |person|
			remove_person(person)
		end

		people_to_add = Array.new
		@location.persons.each do |person|
			if person.desire == @direction || (@direction == "still" && person.desire == "up")
				people_to_add.push(person)
			end
		end
		people_to_add.each do |person|
			add_person(person)
		end
	end
end