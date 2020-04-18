math.randomseed(os.time())
require("room")
roommax = 20
gameOver = false
room_list = {}

function create_room(wall, floor, i)  --CLASS MODIFIED
  room_list[i] = room:new(math.random(3,roommax), math.random(3,roommax), 0, 0)
  room_list[i]:insert_tiles(wall, floor)
end


function add_room(wall, floor)
  create_room()

  xlen = table.getn(matrix) --len of room 
  ylen = table.getn(matrix[0])
  
  randx = math.random(0, boardx - xlen)  --rand int from 1 to boardlen
  randy = math.random(0, boardy - ylen)
  
  xxlen = xlen + randx
  yylen = ylen + randy
  
  isEmpty = true
  for i = randx, xxlen do       --check for empty space on the board
    for j = randy, yylen do -- somewhere on the board
      if board[i][j] ~= " " then
        isEmpty = false
        break
      end
    end
  end
  if isEmpty then
    for i = 0, xlen do
      for j = 0, ylen do
        board[randx + i][randy + j] = matrix[i][j]
      end
    end
  else
    print("isEmpty is false")
  end
end

function create_board(rows, columns, a) --creates a (big) matrix filled with the a parameter
  for i = 0,rows do
    board[i]={}
    for j = 0,columns do
      board[i][j] = tostring(a)
    end
  end
  return board
end

function update_board(board, rows, columns)         --prints the current board
  --board[position_x][position_y] = "@"   -- player position
  for i = 0,rows do
    for j = 0,columns do
      io.write(board[i][j], " ")
    end
    io.write("\n")
  end
end

function player_start_position()
  startx = math.random(0, boardx)
  starty = math.random(0, boardy)
  
  if board[startx][starty] == "." then
    position_x = startx
    position_y = starty
    placement = true
    print("floor found, placing player at", position_x, position_y)
  else
    print("placement not found")
  end
end


function move_player(matrix, step)
  key_press = io.read()
  current_position = matrix[position_x][position_y]
  if key_press == "a" then
    matrix[position_x][position_y] = tostring(step)
    position_y = position_y -1
    
  elseif key_press == "d" then
    matrix[position_x][position_y] = tostring(step)
    position_y = position_y +1
      
  elseif key_press == "w" then
    matrix[position_x][position_y] = tostring(step)
    position_x = position_x -1
      
  elseif key_press == "s" then
    matrix[position_x][position_y] = tostring(step)
    position_x = position_x +1
  elseif key_press == "z" then
    gameOver = true
  else
    print("incorrect input: ", key_press, "\n")
  end
  return matrix[position_x][position_y]
end


function main()
  board = {}
  boardx = 50
  boardy = 100
  position_y = 0
  position_x = 0
  --room_list = {}
  placement = false
  
  create_board(boardx, boardy, " ")
  for p = 0, 200 do
    add_room("#", ".")
  end
  
  while placement == false do   -- placement of player
    player_start_position()
  end
  
  while gameOver == false do
    update_board(board, boardx,boardy)
    move_player(board, ".")
  end
end

function main2()
  for i = 0, 5 do
    create_room("#", ".", i)
    update_board(room_list[i].matrix, room_list[i].rows, room_list[i].columns)
  end
end
main2()