//
//  MoveRecord.h
//  五子棋
//
//  Created by Baymax on 16/5/22.
//  Copyright © 2016年 Baymax. All rights reserved.
//  棋盘2维数组 模型

#import <Foundation/Foundation.h>

@interface BoardModel : NSObject
//棋盘模型
@property (strong , nonatomic) NSMutableArray * arr;
//落子
-(bool)addChessMan:(MoveModel *)model;
//悔棋
-(void)undo:(MoveModel *)model;
//查看某个点的子的值
-(ChessManType)valueWithX:(NSInteger)x Y:(NSInteger)y;


@end
