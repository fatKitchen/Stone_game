class Agent
  def initialize(max_stone)
    @max_stone = max_stone
  end

  def put_stone(stone_num)
    if(stone_num == 1)
      take_stone = 1
    else
      take_stone = Random.rand([@max_stone, stone_num - 1].min) + 1
      if(Random.rand(100) < 80)
        for i in 1..@max_stone
          if((stone_num - 1 - i) % (@max_stone + 1) == 0)
            take_stone = i
            break
          end
        end
      end
    end

    return take_stone
  end
end

max_stone = Random.rand(5) + 2
stone_num = Random.rand(20) + 11
turn = Random.rand(2) * 2 - 1 # +1 is player and -1 is CPU

puts("The number you and CPU can take is #{max_stone}.")
puts("The numebr of stone is #{stone_num}")

agent = Agent.new(max_stone)

while(true)
  if(turn == 1) # player's turn
    puts("Your turn. Please input the number of stone you want to take.")
    print("Input here[1..#{max_stone}]:")
    
    while(true)
      begin
        # take_stone is the number you take
        take_stone = $stdin.gets.to_i
        if(1 <= take_stone && take_stone <= max_stone)
          break
        else
          puts("Your input is not in 1 to #{max_stone}.")
          print("Input here[1..#{max_stone}]:")
        end
      rescue
        puts("Your input is not integer.")
        print("Input here[1..#{max_stone}]:")
      end
    end

    stone_num += -take_stone

  else # CPU's turn
    take_stone = agent.put_stone(stone_num)
    sleep(1)
    puts("CPU take #{take_stone} stone.")
    stone_num += -take_stone
  end

  puts("\n#{stone_num} stone remain")
  if(stone_num <= 0)
    if(turn == 1)
      puts("You Lose!")
    else
      puts("You Win!")
    end
    break
  end

  turn = -turn
end
