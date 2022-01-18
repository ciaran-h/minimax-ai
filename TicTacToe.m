classdef TicTacToe < handle
    
    properties
        board;
        playerX;
        playerO;
    end
    
    events
        OnStart;
        OnMoveStart;
        OnMoveFinish;
        OnGameOver;
    end
    
    methods
        
        function obj = TicTacToe(playerX,playerO)
            
            addlistener(obj,'OnMoveStart',@obj.PrintPlayerTurn);
            addlistener(obj,'OnGameOver',@obj.PrintWinner);
            
            obj.NewGame(playerX,playerO);
        end
        
        function NewGame (obj,playerX,playerO)
            
            obj.board = TTTBoard.Empty();
            
            obj.playerX = playerX;
            obj.playerO = playerO;
            
            playerX.Initialize(obj,1);
            playerO.Initialize(obj,2);
        end
        
        function Play (obj)
            
            notify(obj,'OnStart');
            
            while obj.board.IsGameOver(1) == 0
                
                notify(obj,'OnMoveStart');
                
                currentPlayer = obj.GetCurrentPlayer();
                move = currentPlayer.GetMove(obj.board);
                obj.board = obj.board.MakeMove(move);
                    
                obj.board.PrintBoard();

                notify(obj,'OnMoveFinish');
            end
            
            notify(obj,'OnGameOver');
        end
        
        function PrintPlayerTurn (obj,obj2,~)
            
            currentPlayer = obj.GetCurrentPlayer();
            fprintf('%s''s turn.\n\n',currentPlayer.name);
        end
        
        function PrintWinner (obj,obj2,~)
            
            if obj.board.IsWinner(obj.playerX.playerNumber) == 1
                fprintf('%s wins!\n\n',obj.playerX.name);
            elseif obj.board.IsWinner(obj.playerO.playerNumber) == 1
                fprintf('%s wins!\n\n',obj.playerO.name);
            else
                fprintf('It''s a draw!\n\n');
            end
        end
        
        function player = GetCurrentPlayer(obj)
            
            playerNumber = obj.board.CurrentPlayer();
            
            if playerNumber == 1
                player = obj.playerX;
            else
                player = obj.playerO;
            end
        end
        
        function Say (obj,name,text)
            
            fprintf('%s: %s\n\n',name,text);
        end
    end
    
end

