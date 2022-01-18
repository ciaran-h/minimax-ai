classdef (Abstract) Player < handle
    
    properties (Abstract)
        name
        playerNumber
    end
    
    methods (Abstract)
        
        Initialize(obj,TTT,player)
        move = GetMove(obj,board)
    end
end

