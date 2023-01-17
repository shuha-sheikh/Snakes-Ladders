class SnakesAndLadders #start class
=begin
  sets up variables and arrays
needed for the game
=end
  $play_game = nil
  $next_turn = 'Y'
  $snakes_array = [[54, 19], [90, 48], [99, 77]] #defines what positions there are snakes
  $ladders_array = [[9, 34], [40, 64], [67, 86]] #defines what positions there are ladders

  def welcome_screen #start method welcome_screen
=begin
  responsible for printing game
  instructions to prompt the users
=end
    #prints instructions
    puts "Welcome to Snakes and Ladders! \n \n"
    puts "Instructions:"
    puts "This program will simulate a regular snakes and ladders game, where you will be facing the computer. \n \n"
    puts "You and the computer start at square 1, and the first one to square 100 wins, however, there will be preset squares which will be the snakes or ladders. \n \n"
    puts "Once you land on top of a snake you go down a few squares, and move up if you land on the bottom of a ladder. \n \n"
    puts "Good Luck and Have FUN!!!"
  end #end welcome_screen

  def display_game_board #start method display_game_board
=begin
  responsible for printing game
  board for visual aid for player
=end
    for i in (9).downto(0) do #loops for values of i from 9 down to 0
      for j in 1..10 do #loop for if j is in range of 1 - 10 inclusive
        print "#{i*10 + j}\t" 
  #Ex. if i = 9 and j = 1, 9x10 = 90+1 = 91 prints 91
        #prints values
      end #end inner for loop
      print "\n" #adds new line once the next multiple of 10 is printed
    end #end outer for loop
    puts "\n-----------------------------------------------------------------------" #adds dasshed line after board is printed
  end #end method display_game_board

  def start_game #start start_game method
=begin
  responsible for organizing the game
  and setting the important              
  variables. It will also return a 
  value to the main method, which
  will reset the game so the user can
  play again
=end
    $user_position = 1 
    $comp_position = 1 #sets user and computer position to start

    while ['y', 'Y'].include? $next_turn
      generate_player_rolls
      #while user says yes calls generate_player_rolls method
      
      $user_position = $user_position + $user_roll 
      $comp_position = $comp_position + $comp_roll
#increments positions with dice value
      $user_position = get_position($user_position, 'You', $user_roll)
      $comp_position = get_position($comp_position, 'Computer', $comp_roll)
  #sends data to a function type method called get_position

      puts "****************************************************"
      puts "You are currently on square #{$user_position} "
      puts "The Computer is currently on square #{$comp_position}"
      puts "****************************************************"
#prints user and computer's positions
      if $user_position == 100 || $comp_position == 100 #checks if user or computer won
          $user_position = 1
          $comp_position = 1
          print "\n\nThe game has finished, would you like to play again? Y or N   >  " #asks if user wants to play again
          $play_game = gets.chomp #receives response   
          $next_turn = nil #sets next turn as nothing to restart match
      else
          print "Shall we continue to the next turn? Y or N   >  " #asks user if they want to continue
          $next_turn = gets.chomp #receives response
      end #end if else control flow
    end #end while
  end #end method start game

  def run_main_game_loop #start method run_main_game loop
=begin
  responsible for asking user/player
  if they want to continue to play
  and returns the answer
=end
    print "Do you want to play? Y or N  > " #asks user if they want to play
    $play_game = gets.chomp
    #gets users input (removes line break)
    while ['y', 'Y'].include? $play_game #checks if the answer is yes
      start_game
      #calls start game method
      unless ['y', 'Y'].include? $next_turn #checks if the answer is no
        puts 'Thank you for playing! Goodbye' #prints if user doesn't say yes
        return
      end #ends unless
    end #ends while
  end #ends method run main game loop

  def generate_player_rolls #start generate_player_rolls
=begin
  method generates two random numbers    bewteen 1 and 6, then
  adds them to get a final roll. Next    it returns the value to be
  diplayed on the screen
=end
    
    $user_roll =  rand(1..6) + rand(1..6)
    #generate player roll
    $comp_roll =  rand(1..6) + rand(1..6)
    #generate computer roll
    puts "-----------------------------------"
    puts "-----------------------------------"
    puts "You Rolled a #{$user_roll}" 
    puts "The Computer Rolled a #{$comp_roll}" 
    puts "------------------------------------" 
#prints what user and computer rolled
  end #end generate_player roll

  def check_snakes(position) #start check snakes method
=begin
  responsible for checking if the 
  user or computer is at the top 
  of a snake, and then adjusting the 
  position to match the snake value.
=end
    $snakes_array.each do |top, bottom|
      #filters through array
      if position == top 
        #if the position is equal to   where the snake head lies
        return bottom 
        #return the position as the value of where the bottom of the snake
      end #end if
    end #end do

    return -1 #sets check_snakes to -1 if it is not on a snake
  end # end method check_snakes

  def check_ladders(position)#start check ladders method
=begin
  responsible for checking if the 
  user or computer is at the bottom 
  of a ladder, and then adjusting the 
  position to match the ladder value.
=end
    $ladders_array.each do |bottom, top|#filters through array
      if position == bottom
#if the position is equal to   where the ladder end lies
        return top
#return the position as the value of where the top of the ladder
      end #end if
    end #end do

    return -1 #sets check_ladders to -1 if it is not on a ladder
  end # end method check_snakes

  def get_position(position, player, roll) #start get_position method
=begin
  responsible for checking and altering
  the position of the user and computer
=end
    if check_snakes(position) > 0      
=begin
  if the value of the method is     
  greater than 0 then the player got   
  bit (this is why we set the value of 
  the method to -1 if the position did 
  not equal the snake)
=end
      puts"~~~~~~~~#{player} Got Bit By A Snake, GO DOWN!!!~~~~~~~~" 
      #prints warning
      return check_snakes(position)
      #returns value 
    end #end if

    if check_ladders(position) > 0
=begin
  if the value of the method is     
  greater than 0 then the player 
  climbed up a ladder
  (this is why we set the value of 
  the method to -1 if the position did 
  not equal the ladder)
=end
      puts "~~~~~~~~#{player} Got A Ladder!! GO UP!!!~~~~~~~~"
      #prints what happened
      return check_ladders(position)
      #returns value 
    end #end if

    if position < 0 || position > 112  
#checks if the game went past restrictions
      puts "An error has occured please reset the game!!!!!!"
    elsif position > 100 
#checks if position jumped past 100
      puts "OHHH #{player} cant jump, must land on a 100" 
      position = position - roll
    elsif position == 100
#checks if player won
      if player == 'You'
#declares that the user won
        puts "YOU WON, GOOD JOB!"
      else
#declares that the computer won
        puts "The computer won this one, maybe next time!"
      end #end inner if else
    end #end outer if else
    
    return position #returns value
  end #ends get_position method
end #end class

game_instance = SnakesAndLadders.new # create a new instance of the snakesandladders class
game_instance.welcome_screen # display the welcome screen
game_instance.display_game_board # display the game board
game_instance.run_main_game_loop # run the main game loop
