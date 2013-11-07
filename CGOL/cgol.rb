require 'set'

class Cell < Struct.new(:x,:y)
  
 attr_accessor :status

  def is_neighbour (a)
    err = 0.0001
    if Math.sqrt((x-a.x)**2 + (y-a.y)**2) == 1 ||
        (Math.sqrt((x-a.x)**2 + (y-a.y)**2) - Math.sqrt(2)).abs < err
      return true
    end
    return false
  end

  def neighbours
    res = []
    temp = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[-1,-1]]
    temp.each do |pair|
      x_temp = x
      y_temp = y
      x_temp += pair[0]
      y_temp += pair[1]
      if x_temp >= 0 && y_temp >= 0
        c = Cell.new(x_temp, y_temp)
        c.status = :dead
        res << c
      end
    end
    return res
  end
end

def evolve_universe(seed)
  
  res = []
  neighbours= []
  neighbours_nr = Hash.new(0)
  seed = seed.to_a

  seed.each do |cell|
    cell.status = :alive
    neighbours << cell.neighbours
    neighbours.flatten!
  end

  seed = seed + neighbours
  seed.uniq!

  seed.each do |cell|
    (0..seed.length-1).each do |i|
      if (cell.is_neighbour (seed[i])) && (
          (cell.status == :alive && seed[i].status == :alive) ||
          (cell.status == :dead && seed[i].status == :alive ))
            
        neighbours_nr[cell] += 1
      end
    end
    if (neighbours_nr[cell] == 2 || neighbours_nr[cell] == 3) && cell.status == :alive
        res << cell
    elsif neighbours_nr[cell] == 3 && cell.status == :dead 
        res << cell
    end
  end

  res.to_set
end
