classdef AI
    
    methods (Static)
        
        function score = NegamaxAB(board,depth,alpha,beta,player,outcomes)
            
            gameOverState = board.IsGameOver(player);
            
            if gameOverState ~= 0 || depth == 0
                outcomes.RegisterOutcome(gameOverState);
                score = -board.Heuristic(gameOverState);
                return;
            end
            
            score = -10;

            moves = board.GetMoves();

            for i=1:1:size(moves,2)
                
                newBoard = board.MakeMove(moves(i));
                value = -AI.NegamaxAB(newBoard,depth - 1,-beta,-alpha,player,outcomes);
                
                if value > score
                    score = value;
                end
                
                if value > alpha
                    alpha = value;
                end
                
                if alpha >= beta
                    break;
                end
            end
        end
        
        function score = Negamax(board,depth,player,outcomes)
            
            gameOverState = board.IsGameOver(player);
            
            if gameOverState ~= 0 || depth == 0
                outcomes.RegisterOutcome(gameOverState);
                score = -board.Heuristic(gameOverState);
                return;
            end
            
            score = -10;

            moves = board.GetMoves();

            for i=1:1:size(moves,2)
                
                newBoard = board.MakeMove(moves(i));
                value = -AI.NegamaxAB(newBoard,depth - 1,-10,10,player,outcomes);
                
                if value > score
                    score = value;
                end
            end
        end
        
        function move = GetMoveNegamax (board,depth,outcomes)
            
            bestValue = -10;
            
            player = board.CurrentPlayer();
            moves = board.GetMoves();
                
            for i=1:1:size(moves,2)
                
                newBoard = board.MakeMove(moves(i));
                value = -AI.Negamax(newBoard,depth,player,outcomes);
                
                if value >= bestValue
                    bestValue = value;
                    move = moves(i);
                end
            end
        end
    end
end

