//
//  AgainstView.h
//  五子棋
//
//  Created by Baymax on 16/6/8.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgainstView : UIView

+(AgainstView *)getAgainstView;
//人人博弈头像
-(void)changeAvatar;
//显示
-(void)run:(void (^)())completion;
@end
