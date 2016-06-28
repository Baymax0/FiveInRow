//
//  ChessboardView.h
//  五子棋
//
//  Created by Baymax on 16/5/19.
//  Copyright © 2016年 Baymax. All rights reserved.
//  棋盘

#import <UIKit/UIKit.h>
#import "MoveModel.h"
#import "BoardModel.h"
@protocol ChessboardDelegate <NSObject>
-(void)successBy:(ChessManType)chessManType;
@end

@interface ChessboardView : UIView
//落子顺序记录表
@property (strong , nonatomic) NSMutableArray * piecesArray;
//棋盘2维数组（用于胜负）
@property (strong , nonatomic) BoardModel * boardModel;
//获胜回调
@property (assign , nonatomic) id<ChessboardDelegate> degelate;

//落子
-(BOOL)move:(MoveModel*)model;
//悔棋
-(void)undo;
//悔棋（人机博弈）
-(void)undoTwoStep;
//从新开始
-(void)reStart;

@end
