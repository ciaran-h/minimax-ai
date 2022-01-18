classdef GameOutcomes < handle
    
    properties
        wins = 0;
        losses = 0;
        draws = 0;
    end
    
    methods
        
        function RegisterOutcome(obj,gameOverState)
            
            switch (gameOverState)
                case 1
                    obj.wins = obj.wins + 1;
                case 2
                    obj.losses = obj.losses + 1;
                case 3
                    obj.draws = obj.draws + 1;
            end
        end
        
        function Print (obj)
            
            %fprintf('Wins:%d\nLosses:%d\nDraws:%d\n\n',obj.wins,obj.losses,obj.draws);
        end
    end
end

