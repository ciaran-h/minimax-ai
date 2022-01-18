classdef George < Player
    
    properties
        name = 'George';
        playerNumber
    end
    
    methods
        
        function Initialize (obj,TTT,player)
            
            obj.playerNumber = player;
            
            addlistener(TTT,'OnStart',@obj.OnStart);
            addlistener(TTT,'OnMoveFinish',@obj.OnMoveFinish);
            addlistener(TTT,'OnGameOver',@obj.OnGameOver);
        end
        
        function move = GetMove(obj,board)
            go = GameOutcomes();
            move = AI.GetMoveNegamax(board,9,go);
            go.Print();
        end
        
        function OnStart (obj,TTT,~)
            TTT.Say(obj.name,'Lets all just remember to have fun.');
        end
        
        function OnMoveFinish (obj,TTT,~)
            
            if (TTT.board.CurrentPlayer() ~= obj.playerNumber)
                if (TTT.board.IsGameOver(obj.playerNumber) == 0)
                    TTT.Say(obj.name,'Your turn.');
                end
            end
        end
        
        function OnGameOver (obj,TTT,~)
            
            gameOverState = TTT.board.IsGameOver(obj.playerNumber);
            
            if gameOverState == 1
                TTT.Say(obj.name,'HAH! Suck it.');
            elseif gameOverState == 2
                TTT.Say(obj.name,'WHY YOU LITTLE CHEATING SON OF A GUN!!!');
            else
                TTT.Say(obj.name,'Lets be honest this is the best outcome you could have gotten.');
            end
        end
    end
end

