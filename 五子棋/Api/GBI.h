//
//  API.h
//  五子棋
//
//  Created by Baymax on 16/6/1.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBI : NSObject

@property (nonatomic, strong) NSMutableArray *chessArr;

-(NSInteger)computerReturnBestIndexPath;

@end
