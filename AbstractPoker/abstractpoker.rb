def classify_poker_hand(poker_hand)
#  :unexpected_return_value
  state = nil

  # hand is an array
  if !(poker_hand.is_a? Array)
    state = :not_a_ruby_array
    return state
  end

  # out of bounds or not integer
  poker_hand.each do |card| 
    if !(card.is_a? Integer)
      state = :at_least_one_card_is_not_an_integer
      return state
    elsif card > 1000 || card < 1
      state = :at_least_one_card_is_out_of_bounds
      return state
    end
  end

  # should have exactly 5 cards
  if poker_hand.length != 5
    state = :too_many_or_too_few_cards
    return state
  end

  # sorted copy of hand
  poker_hand_sorted = poker_hand.sort

  # high card with 3
  poker_hand_sorted.each_cons(3) do |card|
    if (card[1]-card[0] == 1) && (card[2]-card[1] == 1)
      state = :high_card
    end
  end
  
  # high card with 4
  poker_hand_sorted.each_cons(4) do |card|
    if (card[0]+card[3]) == (card[1]+card[2]) && (card[1]-card[0] == 1)
      state = :high_card
    end
  end
  
  # pairs
  nr = 0
  poker_hand_sorted.each_cons(2) do |card|
    if card[0] == card[1]
      nr+=1
    end
  end

  if nr == 1 
    state = :one_pair
  elsif nr == 2 
    state = :two_pairs
  end

  poker_hand_sorted.each_cons(3) do |card|
    if card[0] == card[1] && card[1] == card[2]
      state = :three_of_a_kind
    end
  end 
 
  # straight
  sum = poker_hand_sorted.inject(0) { |acc, item| acc + item }

  if (sum == (poker_hand_sorted.first + poker_hand_sorted.last)*5/2) &&
                    (poker_hand_sorted[1] - poker_hand_sorted[0] == 1)
    state = :straight
  end

  # full house and four of a kind
  temp = Hash.new(0)
  
  poker_hand.each { |card| temp[card]+=1 }

  if temp.values.include?(2) && temp.values.include?(3)
    state = :full_house
  elsif temp.values.include?(1) && temp.values.include?(4)
    state = :four_of_a_kind
  end

  # ordinary hand
  if temp.values.length == 5 && state != :high_card && state != :straight
    state = :valid_but_nothing_special 
  end

  # cant have 5 identical cards
  if temp.values.length == 1
    state = :impossible_hand
  end 

  state
end
