clear
clc

connect = Connect4Board.Empty();
outcomes = GameOutcomes();

while (connect.IsGameOver(connect.CurrentPlayer()) == 0)
    
    move = AI.GetMoveNegamax(connect,8,outcomes);
    connect = connect.MakeMove(move);
    connect.PrintBoard();
    
    %move = input('Column:');
    %connect = connect.MakeMove(move);
    %connect.PrintBoard();
end

connect.PrintBoard();