//
//  MoveRecord.m
//  五子棋
//
//  Created by Baymax on 16/5/22.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "BoardModel.h"
#import "MoveModel.h"

@implementation BoardModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.arr = [[NSMutableArray alloc] init];
        for (int i = 0; i<15; i++) {
            for (int j = 0; j<15; j++) {
                MoveModel *model = [[MoveModel alloc] init];
                [model setX:i];
                [model setY:j];
                [model setTag:(i * 15 + j)];
                [self.arr addObject:model];
            }
        }
    }
    return self;
}

//落子
-(bool)addChessMan:(MoveModel *)model{
    NSInteger value = [self valueWithX:model.x Y:model.y];
    if (value==ChessMan_Null) {
        NSInteger tag = model.x+model.y*15;
        [self.arr replaceObjectAtIndex:tag withObject:model];
        return YES;
    }else{
        return NO;
    }
}
//悔棋
-(void)undo:(MoveModel *)model{
    NSInteger tag = model.x+model.y*15;
    model.value = ChessMan_Null;
    [self.arr replaceObjectAtIndex:tag withObject:model];
}
//读某个坐标值
-(ChessManType)valueWithX:(NSInteger)x Y:(NSInteger)y{
    NSInteger tag = x+y*15;
    MoveModel *model = [self.arr objectAtIndex:tag];
    return (ChessManType)model.value;
}
@end
