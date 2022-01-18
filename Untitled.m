clear
clc

board = TTTBoard.Empty();

move = AI.GetMoveNegamax(board,9,GameOutcomes());
board = board.MakeMove(move);

board.PrintBoard();