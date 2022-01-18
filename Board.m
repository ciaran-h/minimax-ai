classdef (Abstract) Board < handle
    
    properties
    end
    
    methods (Abstract)
        
        value = Heuristic (gameOverState);
        currentPlayer = CurrentPlayer(obj)
        newBoard = MakeMove(obj,move)
        moves = GetMoves(obj)
        isGameOver = IsGameOver (obj,player)
    end
    
end

