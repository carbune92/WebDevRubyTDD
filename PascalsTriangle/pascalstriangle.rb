def compute_row(n)
=begin
  trian = []
  trian << [1]
 
  if !n.is_a? Integer
    return nil
  end  

  if n == 1 
    return trian[0]
  end
  
  2.upto(n) do |m|
    row = Array.new(m)
    row[0] = row[m-1] = 1
    for i in (1..m-2)
      row[i] = trian.last[i-1] + trian.last[i]
    end
    trian << row
  end
  
  trian[n-1]
=end

  if !n.is_a? Integer
    return nil
  end

  if n == 1
    return [1]
  end
  
  row = [1]

  2.upto(n) do |m|
    row.unshift(1)
    
    for i in (1..(m-2)/2)
      row[i]+=row[i+1]
      row[m-1-i] = row[i]
    end
    
    if (m-2)%2 != 0
      row[(m-2)/2+1] *= 2         
    end
  end

  row
end
