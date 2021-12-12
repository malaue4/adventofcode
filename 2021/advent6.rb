lantern_fish = File.read('advent6input').split(",").map(&:to_i)
#lantern_fish = [3,4,3,1,2].sort
def grow_fish(initial_state, days)
  old_state = initial_state.tally
  days.times do |i|
    spawns = old_state[0]
    old_state.delete(0)
    new_state = old_state.transform_keys{ _1 - 1 }
    if spawns
      new_state[6] = new_state.fetch(6, 0) + spawns
      new_state[8] = new_state.fetch(8, 0) + spawns
    end
    old_state = new_state
  end
  old_state.values.sum
end

puts grow_fish(lantern_fish, 80)
puts grow_fish(lantern_fish, 256)
