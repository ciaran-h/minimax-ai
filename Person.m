classdef Person < Player

    properties
        name;
        playerNumber
    end
    
    methods
        
        function obj = Person(name)

            obj.name = name;
        end
        
        function Initialize (obj,TTT,player)
            
            obj.playerNumber = player;
        end
        
        function move = GetMove(obj,board)
           
            while (1)
                
                x = round(str2double(input('Enter x:','s')));
                y = round(str2double(input('Enter y:','s')));
                
                fprintf('\n');
                
                move = struct('x',x,'y',y);
                
                if ~isnumeric(x) || ~isnumeric(y)
                    fprintf('Input must be a number.\n\n');
                elseif board.IsValidMove(move) == 0
                    fprintf('Invalid move.\n\n');
                else
                    break;
                end
            end
        end
    end
end

