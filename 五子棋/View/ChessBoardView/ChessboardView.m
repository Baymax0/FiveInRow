//
//  ChessboardView.m
//  五子棋
//
//  Created by Baymax on 16/5/19.
//  Copyright © 2016年 Baymax. All rights reserved.
//  棋盘

#import "ChessboardView.h"

@implementation ChessboardView{
    //当前的落子点
    MoveModel *lastMoveMod;
}
//初始化
-(void)awakeFromNib{
    [super awakeFromNib];
    self.piecesArray = [[NSMutableArray alloc] init];
    self.boardModel = [[BoardModel alloc] init];
}
//落子
-(BOOL)move:(MoveModel*)model{
    //将棋子写入棋盘模型
    BOOL result = [self.boardModel addChessMan:model];
    if (!result) {
        return NO;
    }
    //将落子写进记录中
    [self.piecesArray addObject:model];
    [self setNeedsDisplay];
    lastMoveMod = model;
    [self judge];
    return YES;
}
//悔棋
-(void)undo{
    if (self.piecesArray.count) {
        MoveModel *model = self.piecesArray.lastObject;
        [self.boardModel undo:model];
        [self.piecesArray removeLastObject];
        [self setNeedsDisplay];
    }
}

//悔棋
-(void)undoTwoStep{
    if (self.piecesArray.count>=2) {
        //撤销电脑的一步
        MoveModel *model1 = self.piecesArray.lastObject;
        [self.boardModel undo:model1];
        [self.piecesArray removeLastObject];
        //撤销自己的一步
        MoveModel *model2 = self.piecesArray.lastObject;
        [self.boardModel undo:model2];
        [self.piecesArray removeLastObject];
        [self setNeedsDisplay];
    }
}
//从新开始
-(void)reStart{
    self.piecesArray = [[NSMutableArray alloc] init];
    self.boardModel = [[BoardModel alloc] init];
    
    [self setNeedsDisplay];
}

//根据新落子点判断胜负
-(void)judge{
    BOOL win = NO;
    NSInteger sum1 = [self numInRowByX:0 Y:-1]+[self numInRowByX:0 Y:1];
    if (sum1==4)
        win = YES;
    NSInteger sum2 = [self numInRowByX:-1 Y:0]+[self numInRowByX:1 Y:0];
    if (sum2==4)
        win = YES;
    NSInteger sum3 = [self numInRowByX:-1 Y:-1]+[self numInRowByX:1 Y:1];
    if (sum3==4)
        win = YES;
    NSInteger sum4 = [self numInRowByX:-1 Y:1]+[self numInRowByX:1 Y:-1];
    if (sum4==4)
        win = YES;
    if (win==YES) {
        [self.degelate successBy:lastMoveMod.value];
    }
}
//判断落子为中心某个方向上同颜色棋子的个数
-(NSInteger)numInRowByX:(NSInteger)x Y:(NSInteger)y{
    int num = 0;
    for(int i=1;i<15;i++){
        NSInteger tempX = lastMoveMod.x+x*i;
        NSInteger tempY = lastMoveMod.y+y*i;
        if (tempX>=0&&tempX<=14) {
            if (tempY>=0&&tempY<=14) {
                int value = [self.boardModel valueWithX:tempX Y:tempY];
                if (value==lastMoveMod.value) {
                    num++;
                    continue;
                }
            }
        }
        return num;
    }
    return num;
}


- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置路径宽度
    path.lineWidth = 1;
    // 设置颜色
    [[UIColor blackColor] set];
    float a,b;
    //棋盘
    for (int i = 0; i < 15; i++) {
        a = coordinate(i);
        b = boardWidth;
        //竖线
        [path moveToPoint:CGPointMake(a, 1+5)];
        [path addLineToPoint:CGPointMake(a, b+5)];
        //横线
        [path moveToPoint:CGPointMake(1+5, a)];
        [path addLineToPoint:CGPointMake(b+5, a)];
        //渲染路径
        [path stroke]; //stroke为空心
    }
    
    //棋盘的5个参考点
    path = [UIBezierPath bezierPathWithRect:CGRectMake(coordinate(2)-pointW, coordinate(2)-pointW, pointW*2, pointW*2)];
    [path fill];
    path = [UIBezierPath bezierPathWithRect:CGRectMake(coordinate(12)-pointW, coordinate(2)-pointW, pointW*2, pointW*2)];
    [path fill];
    path = [UIBezierPath bezierPathWithRect:CGRectMake(coordinate(7)-pointW, coordinate(7)-pointW, pointW*2, pointW*2)];
    [path fill];
    path = [UIBezierPath bezierPathWithRect:CGRectMake(coordinate(2)-pointW, coordinate(12)-pointW, pointW*2, pointW*2)];
    [path fill];
    path = [UIBezierPath bezierPathWithRect:CGRectMake(coordinate(12)-pointW, coordinate(12)-pointW, pointW*2, pointW*2)];
    [path fill];
    
    //画点
    if (self.piecesArray) {
        if (self.piecesArray.count==0) {
            return;
        }
        __block CGPoint point;
        [self.piecesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                UIBezierPath *path1 = [UIBezierPath bezierPath];
                MoveModel *mod = obj;
                if (mod.value==1) {
                    [kBLACK set];
                }else{
                    [kWHITE set];
                }
                CGFloat radius = (boardWidth-15.0)/28-2;
                point = CGPointMake(coordinate(mod.x), coordinate(mod.y));
                [path1 moveToPoint:CGPointMake(point.x+radius, 9)];
                [path1 addArcWithCenter:point radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
                //渲染路径
                [path1 fill];
            }
        }];
        //最后一个棋子周围画框
        MoveModel *mod = [self.piecesArray lastObject];
        CGRect rect = CGRectMake(coordinate(mod.x)-12, coordinate(mod.y)-12, 24, 24);
        UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:rect];
        path.lineWidth = 3;
        [kRED set];
        [path2 stroke];

    }
}


@end
