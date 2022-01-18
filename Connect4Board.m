classdef Connect4Board < Board
    
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
        
        %function value = Heuristic (gameOverState)
        %    
         %   if gameOverState == 0
        %        value = 0;
        %    elseif gameOverState == 1
        %        value = 1;
        %    elseif gameOverState == 2
        %        value = 1;
        %    else
         %       value = 0;
        %    end
        %end
        
        function newBoard = Empty ()
            
            newBoard = Connect4Board(zeros(7,6),0);
        end
    end
    
    methods
        
        function newBoard = Connect4Board(board,turn)
            
            newBoard.board = board;
            newBoard.turn = turn;
        end
        
        function newBoard = Duplicate(obj)
            
            newBoard.board = obj.board;
            newBoard.turn = obj.turn;
        end
        
        function currentPlayer = CurrentPlayer(obj)
            
            currentPlayer = mod(obj.turn,2) + 1;
        end
        
        function nextPlayer = NextPlayer(obj)
            
            nextPlayer = mod(obj.turn + 1,2) + 1;
        end
        
        function moves = GetMoves(obj)
            
            moves = [];
            
            for x=1:1:7
                if obj.ColumnIsFull(x) == 0
                    moves = [moves,x];
                end
            end
        end
        
        function isFull = ColumnIsFull (obj,x)
            
                if obj.board(x,6) == 0
                	isFull = 0;
                else
                	isFull = 1;
                end
        end
        
        function level = GetFirstOpenSpace(obj,x)
            
            for y = 6:-1:1
                if obj.board(x,y) ~= 0
                    level = y + 1;
                    return;
                end
            end
            
            level = 1;
        end
       
        function newBoard = MakeMove(obj,x)
            
            newBoard = Connect4Board(obj.board,obj.turn);
            
            y = obj.GetFirstOpenSpace(x);
            
            newBoard.board(x,y) = obj.CurrentPlayer();
            newBoard.turn = obj.turn + 1;
        end
        
        function isGameOver = IsGameOver (obj,player)
            
            enemy = Connect4Board.EnemyPlayer(player);
            
            if (obj.IsWinner(player))
            	isGameOver = 1;
            elseif (obj.IsWinner(enemy))
            	isGameOver = 2;
            elseif (obj.IsFull())
            	isGameOver = 3;
            else
                isGameOver = 0;
            end
        end
        
        function isWin = IsWinner (obj,player)
            
            b = obj.board;
            
            for y = 1:1:3
                for x = 1:1:4
                   if (Hor() == 1)
                       isWin = 1;
                       return;
                   elseif (Vert() == 1)
                       isWin = 1;
                       return;
                   elseif (PosDiag() == 1)
                       isWin = 1;
                       return;
                   elseif (NegDiag() == 1)
                       isWin = 1;
                       return;
                   end
                end
            end
            
            isWin = 0;
            
            function isTrue = Hor ()
                
                if b(x,y) == player && b(x + 1,y) == player && b(x + 2,y) == player && b(x + 3,y) == player
                    isTrue = 1;
                else
                    isTrue = 0;
                end
            end
            
            function isTrue = Vert ()
                
                if b(x,y) == player && b(x,y + 1) == player && b(x,y + 2) == player && b(x,y + 3) == player
                    isTrue = 1;
                else
                    isTrue = 0;
                end
            end
            
            function isTrue = PosDiag ()
                
                if b(x,y) == player && b(x + 1,y + 1) == player && b(x + 2,y + 2) == player && b(x + 3,y + 3) == player
                    isTrue = 1;
                else
                    isTrue = 0;
                end
            end
            
            function isTrue = NegDiag ()
                
                if b(x,y + 3) == player && b(x + 1,y + 2) == player && b(x + 2,y + 1) == player && b(x + 3,y) == player
                    isTrue = 1;
                else
                    isTrue = 0;
                end
            end
        end
        
        function totalScore = Heuristic (obj,player)
            
            enemy = Connect4Board.EnemyPlayer(player);
            
            totalScore = obj.Evaluate(enemy) - obj.Evaluate(player);
        end
        
        function totalScore = Evaluate (obj,player)
                        
            b = obj.board;
            totalScore = 0;
            
            for y = 1:1:3
                for x = 1:1:4
                    totalScore = totalScore + Score(Hor()) + Score(Vert()) + Score(PosDiag()) + Score(NegDiag());
                end
            end
            
            if (totalScore > 10000)
                totalScore = 10000;
            end
            
            function score = Score(completion)
                
                switch (completion)
                    case 2
                        score = 0;
                    case 3
                        score = 0;
                    case 4
                        score = 10000;
                    otherwise
                        score = 0;
                end
            end
            
            function completion = Hor ()
                
                completion = (b(x,y) == player) + (b(x + 1,y) == player) + (b(x + 2,y) == player) + (b(x + 3,y) == player);
            end
            
            function completion = Vert ()
                
                completion = (b(x,y) == player) + (b(x,y + 1) == player) + (b(x,y + 2) == player) + (b(x,y + 3) == player);
            end
            
            function completion = PosDiag ()
                
                completion = (b(x,y) == player) + (b(x + 1,y + 1) == player) + (b(x + 2,y + 2) == player) + (b(x + 3,y + 3) == player);
            end
            
            function completion = NegDiag ()
                
                completion = (b(x,y + 3) == player) + (b(x + 1,y + 2) == player) + (b(x + 2,y + 1) == player) + (b(x + 3,y) == player);
            end
        end
        
        function isFull = IsFull (obj)
        
            for x = 1:1:7
                if obj.ColumnIsFull(x) == 0
                    isFull = 0;
                    return;
                end
            end
            
            isFull = 1;
        end
        
        function PrintBoard (obj)
            
            for y=6:-1:1
               for x=1:1:7
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
    end
    
end

