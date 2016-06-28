//
//  AgainstView.m
//  五子棋
//
//  Created by Baymax on 16/6/8.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "AgainstView.h"

@implementation AgainstView{
    UIImageView *imgView1;//左侧头像
    UIImageView *imgView2;//右侧头像
    CGRect rect1;//左侧头像停留的位置
    CGRect rect2;//右侧头像停留的位置
    __weak IBOutlet UIView *bgView;
}
//获得对象
+(AgainstView *)getAgainstView{
    AgainstView *againstView = [[[NSBundle mainBundle]loadNibNamed:@"AgainstView" owner:self options:nil] lastObject];
    againstView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    againstView.userInteractionEnabled = YES;
    return againstView;
}
//初始化
-(void)awakeFromNib{
    [super awakeFromNib];
    bgView.alpha = 0;
    rect1 = CGRectMake(38, 14, 80, 80);
    rect2 = CGRectMake(bgView.frame.size.width-38-80, bgView.frame.size.height-14-80, 80, 80);
    
    imgView1 = [[UIImageView alloc] initWithFrame:[self moveCGRect:rect1 X:-120]];
    [imgView1 setImage:[UIImage imageNamed:@"human"]];
    [bgView addSubview:imgView1];
    imgView2 = [[UIImageView alloc] initWithFrame:[self moveCGRect:rect2 X:+120]];
    [imgView2 setImage:[UIImage imageNamed:@"pc"]];
    [bgView addSubview:imgView2];
}

-(void)changeAvatar{
    [imgView1 setImage:[UIImage imageNamed:@"human2"]];
    [imgView2 setImage:[UIImage imageNamed:@"human3"]];
}

//显示
-(void)run:(void (^)())completion{
    [UIView animateWithDuration:0.2 animations:^{
        bgView.alpha = 1;
    }];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imgView1.frame = rect1;
        imgView2.frame = rect2;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imgView1.frame = [self moveCGRect:rect1 X:+350];
            imgView2.frame = [self moveCGRect:rect2 X:-350];
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (completion) {
                completion();
            }
        }];
    }];
}
//将CGRect水平平移一段距离
-(CGRect)moveCGRect:(CGRect)rect X:(CGFloat) x {
    CGRect rectTemp = rect;
    rectTemp.origin.x = rectTemp.origin.x+x;
    return rectTemp;
}

@end
