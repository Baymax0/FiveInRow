//
//  API.m
//  五子棋
//
//  Created by Baymax on 16/6/1.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "GBI.h"

#define WIDTH_CHESSBOARD 15

@implementation GBI

//返回当前最好的位置
-(NSInteger)computerReturnBestIndexPath{
    // pc 子颜色
    //ChessManType tag_pc = self.nowIsWho;
    // 算分数
    NSInteger bestIndexPC       = 0;
    NSInteger bestScorePC       = -10000;
    
    NSInteger bestIndexMan      = 0;
    NSInteger bestScoreMan      = -10000;
    
    for (MoveModel *btnChess in self.chessArr){
        if (btnChess.value == ChessMan_Null){
            // 计算计算机分值
            NSInteger scorePCTmp = [self calScoreAtIndex:btnChess.tag withType:ChessMan_Blcak];
            if (scorePCTmp > bestScorePC){
                bestScorePC = scorePCTmp;
                bestIndexPC = btnChess.tag;
            }
            // 计算人分值
            NSInteger scoreManTmp = [self calScoreAtIndex:btnChess.tag withType:ChessMan_White];
            //            if (DEBUG){
            //                NSLog(@"%ld:pc%ld     man:%ld",btnChess.tag,scorePCTmp,scoreManTmp);
            //            }
            if (scoreManTmp > bestScoreMan){
                bestScoreMan = scoreManTmp;
                bestIndexMan = btnChess.tag;
            }
        }
    }
    return (bestScorePC >= bestScoreMan ? bestIndexPC : bestIndexMan);
}

/**
 *  计算分数
 *
 *  @param index 空子所在位置
 *  @param tag   棋色
 *
 *  @return 返回分数
 */
- (NSInteger)calScoreAtIndex:(NSInteger)index withType:(ChessManType)tag{
    // 落子位置
    NSInteger x = index / WIDTH_CHESSBOARD;
    NSInteger y = index % WIDTH_CHESSBOARD;
    
    NSInteger score = 0;
    NSInteger numSame = 0;      // 相同子个数
    NSInteger numSeperator = 0; // 边缘截断
    //top
    for (NSInteger i = 1; i<= x; i ++){
        MoveModel *btnTmp = self.chessArr[(x - i) * WIDTH_CHESSBOARD + y];
        if (btnTmp.value == tag){
            numSame ++;
            // 边缘检测
            if (x - i == 0){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        // 不同色
        else{
            numSeperator ++;
            break;
        }
    }
    
    // bottom
    for (NSInteger i = 1; i <= WIDTH_CHESSBOARD - 1 - x; i ++){
        MoveModel *btnTmp = self.chessArr[(x + i) * WIDTH_CHESSBOARD + y];
        if (btnTmp.value == tag){
            numSame ++;
            if (x + i == WIDTH_CHESSBOARD - 1){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else{
            numSeperator ++;
            break;
        }
    }
    
    // 自己就是边缘
    if (x == 0 || x == WIDTH_CHESSBOARD - 1){
        numSeperator ++;
    }
    score += [self GetScoreChessOfNumber:numSame withSeperatorOfNumber:numSeperator];
    
    // 斜上
    numSeperator = 0;
    numSame      = 0;
    for (NSInteger i = 1; i <= x && i <= y; i ++){
        MoveModel *btnTmp = self.chessArr[(x - i) *WIDTH_CHESSBOARD + (y - i)];
        
        if (btnTmp.value == tag){
            numSame ++;
            if ((x - i) == 0 || (y - i) == 0){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else{
            numSeperator ++;
            break;
        }
    }
    // 斜下
    for (NSInteger i = 1; i <= (WIDTH_CHESSBOARD-1-x) && i <= (WIDTH_CHESSBOARD-1 -y); i ++){
        MoveModel *btnTmp = self.chessArr[(x + i) * WIDTH_CHESSBOARD + (y + i)];
        
        if (btnTmp.value == tag){
            numSame ++ ;
            if ((x + i) == (WIDTH_CHESSBOARD - 1) || (y + i) == (WIDTH_CHESSBOARD - 1)){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else{
            numSeperator ++;
            break;
        }
    }
    
    if (x == 0 || y == 0 || x == (WIDTH_CHESSBOARD - 1) || y == (WIDTH_CHESSBOARD - 1)){
        numSeperator ++;
    }
    score += [self GetScoreChessOfNumber:numSame withSeperatorOfNumber:numSeperator];
    
    ////// "一"
    // left
    numSame      = 0;
    numSeperator = 0;
    for (NSInteger i = 1 ; i <= y; i ++){
        MoveModel *btnTmp = self.chessArr[x * WIDTH_CHESSBOARD + (y - i)];
        
        if (btnTmp.value == tag){
            numSame ++;
            if (y - i == 0){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else{
            numSeperator ++;
            break;
        }
    }
    
    // right
    for (NSInteger i = 1 ; i <= WIDTH_CHESSBOARD - 1 - y; i ++){
        MoveModel *btnTmp = self.chessArr[x * WIDTH_CHESSBOARD + y + i];
        
        if (btnTmp.value == tag){
            numSame ++;
            if (y + i == WIDTH_CHESSBOARD - 1){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else{
            numSeperator ++;
            break;
        }
    }
    
    if (y == 0 || y == WIDTH_CHESSBOARD - 1){
        numSeperator ++;
    }
    score += [self GetScoreChessOfNumber:numSame withSeperatorOfNumber:numSeperator];
    
    ////// "/"
    numSame      = 0;
    numSeperator = 0;
    // 斜下
    for (NSInteger i = 1; (i <= WIDTH_CHESSBOARD - 1 - x) && (i <= y); i ++){
        MoveModel *btnTmp = self.chessArr[(x + i) * WIDTH_CHESSBOARD + y - i];
        
        if (btnTmp.value == tag){
            numSame ++;
            if ((x + i == WIDTH_CHESSBOARD - 1) || (y - i) == 0){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else
        {
            numSeperator ++;
            break;
        }
    }
    
    // 斜上
    for (NSInteger i = 1; (i <= x) && (i <= WIDTH_CHESSBOARD - 1 - y); i ++){
        MoveModel *btnTmp = self.chessArr[(x - i) * WIDTH_CHESSBOARD + (y + i)];
        
        if (btnTmp.value == tag){
            numSame ++;
            if ((x - i) == 0 || (y + i) == WIDTH_CHESSBOARD - 1){
                numSeperator ++;
            }
        }
        else if (btnTmp.value == ChessMan_Null){
            break;
        }
        else{
            numSeperator ++;
            break;
        }
    }
    
    if (x == 0 || x == WIDTH_CHESSBOARD - 1 || y == 0 || y == WIDTH_CHESSBOARD - 1){
        numSeperator ++;
    }
    score += [self GetScoreChessOfNumber:numSame withSeperatorOfNumber:numSeperator];
    return score;
}

/**
 *  根据棋子数计算分值
 *
 *  @param number          连子数量
 *  @param seperatorNumber 被分割情况
 *
 *  @return 返回分数
 */
- (NSInteger)GetScoreChessOfNumber:(NSInteger)number withSeperatorOfNumber:(NSInteger)seperatorNumber{
    NSInteger score = 0;
    // 五子
    if (number >= 4){
        score = 10000;
    }
    // 四子
    else if (number == 3){
        switch (seperatorNumber){
            case 0:
                // 活四
                score = 3000;
                break;
            case 1:
                // 冲四
                score = 900;
                break;
            case 2:
                // 死四 不做操作
            default:
                break;
        }
    }
    // 三子
    else if (number == 2){
        switch (seperatorNumber){
            case 0:
                // 活三
                score = 460;
                break;
            case 1:
                // 冲三
                score = 30;
                break;
            default:
                break;
        }
    }
    
    // 二子
    else if (number == 1){
        switch (seperatorNumber){
            case 0:
                // 活二
                score = 45;
                break;
            case 1:
                // 冲二
                score = 5;
            default:
                break;
        }
    }
    // 单子
    else{
        switch (seperatorNumber) {
            case 0:
                score = 3;
                break;
            case 1:
                score = 1;
                break;
            default:
                break;
        }
    }
    return score;
}

@end
