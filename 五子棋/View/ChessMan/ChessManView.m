//
//  ChessManView.m
//  五子棋
//
//  Created by Baymax on 16/6/8.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "ChessManView.h"

@implementation ChessManView

-(void)awakeFromNib{
    self.layer.cornerRadius = self.frame.size.width/2;
}

@end
