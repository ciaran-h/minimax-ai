classdef TTTBoard < Board
    
    properties
        board;
        turn;
    end
    
    methods (Static)
        
        function enemyPlayer = EnemyPlayer(player)
            
            if (player == 1)
                enemyPlayer = 2;
            else
                enemyPlayer = 1;
            end
        end
        
        function value = Heuristic (gameOverState)
            
            if gameOverState == 0
                value = 0;
            elseif gameOverState == 1
                value = 1;
            elseif gameOverState == 2
                value = 1;
            else
                value = 0;
            end
        end
        
        function newBoard = Empty()
            
            newBoard = TTTBoard([0,0,0;0,0,0;0,0,0],0);
        end
    end
    
    methods
        
        function newBoard = TTTBoard(board,turn)
            
            newBoard.board = board;
            newBoard.turn = turn;
        end
        
        function currentPlayer = CurrentPlayer(obj)
            
            currentPlayer = mod(obj.turn,2) + 1;
        end
        
        function nextPlayer = NextPlayer(obj)
            
            nextPlayer = mod(obj.turn + 1,2) + 1;
        end
        
        function newBoard = MakeMove(obj,move)
            
            newBoard = TTTBoard(obj.board,obj.turn + 1);
            newBoard.board(move.x,move.y) = obj.CurrentPlayer();
        end
        
        function moves = GetMoves(obj)
           
            moves = [];
            
            for x=1:1:3
                for y=1:1:3
                    if obj.board(x,y) == 0
                        moves = [moves,struct('x',x,'y',y)];
                    end
                end
            end
        end

        function isValid = IsValidMove (obj,move)
            
            isValid = 0;
            
            if (0 < move.x && move.x <= 3)
                if (0 < move.y && move.y <= 3)
                    if (obj.board(move.x,move.y) == 0)
                        isValid = 1;
                    end
                end
            end
        end
        
        function isGameOver = IsGameOver (obj,player)
            
            enemy = TTTBoard.EnemyPlayer(player);
            
            if (obj.IsWinner(player))
            	isGameOver = 1;
            elseif (obj.IsWinner(enemy))
            	isGameOver = 2;
            elseif (obj.IsDraw())
            	isGameOver = 3;
            else
                isGameOver = 0;
            end
        end
        
        function isDraw = IsDraw (obj)
            
            if (obj.turn > 8)
                isDraw = true;
            else
                isDraw = false;
            end
        end
        
        function isWin = IsWinner (obj,player)
            
            b = obj.board;            
            isWin = 0;
            
            if (b(1,1) == player && b(1,2) == player && b(1,3) == player)
                isWin = 1;
            elseif (b(2,1) == player && b(2,2) == player && b(2,3) == player)
                isWin = 1;
            elseif (b(3,1) == player && b(3,2) == player && b(3,3) == player)
                isWin = 1;
            elseif (b(1,1) == player && b(2,1) == player && b(3,1) == player)
                isWin = 1;
            elseif (b(1,2) == player && b(2,2) == player && b(3,2) == player)
                isWin = 1;
            elseif (b(1,3) == player && b(2,3) == player && b(3,3) == player)
                isWin = 1;
            elseif (b(1,1) == player && b(2,2) == player && b(3,3) == player)
                isWin = 1;
            elseif (b(1,3) == player && b(2,2) == player && b(3,1) == player)
                isWin = 1;
            end
        end

        function PrintBoard (obj)
            
            for y=1:1:3
               for x=1:1:3
                   if (obj.board(x,y) == 1)
                       fprintf("X ")
                   elseif (obj.board(x,y) == 2)
                       fprintf("O ")
                   else
                       fprintf("- ")
                   end                        
               end
               fprintf("\n")
            end
            fprintf("\n")
        end
        
        function PrintBoardNumbers (obj)
            
            for y=1:1:3
               for x=1:1:3
                   fprintf('%d ',obj.board(x,y));                     
               end
               fprintf("\n")
            end
            fprintf("\n")
        end
        
        function PrintMoves (obj)
            
            moves = obj.GetMoves();
            
            fprintf("\n");
            
            for i=1:1:size(moves,2)
                fprintf('(%d,%d)\n',moves(i).x,moves(i).y); 
            end
            
            fprintf('\n');
        end
    end
end
