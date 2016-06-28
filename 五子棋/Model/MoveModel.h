//
//  MoveModel.h
//  五子棋
//
//  Created by Baymax on 16/5/19.
//  Copyright © 2016年 Baymax. All rights reserved.
//  落子的模型

#import <Foundation/Foundation.h>

@interface MoveModel : NSObject

@property (assign , nonatomic) ChessManType value;
//在棋盘的x坐标
@property (assign , nonatomic) NSInteger x;
//在棋盘的y坐标
@property (assign , nonatomic) NSInteger y;
//在棋盘的坐标(=y*15+x)
@property (assign , nonatomic) NSInteger tag;

@end
