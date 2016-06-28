//
//  MainViewController.m
//  五子棋
//
//  Created by Baymax on 16/5/19.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "MainViewController.h"
#import "HHViewController.h"
#import "HPViewController.h"

#define ChessWidth 35

@interface MainViewController (){
    NSArray *position;
    
    NSMutableArray *chessesArr;
    
    BOOL needAnimation;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constant1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constant2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constant3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constant4;

@end

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    chessesArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self createChesses];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(chessesAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

-(void)viewWillAppear:(BOOL)animated{
    needAnimation = YES;
    
    [super viewWillAppear:animated];
    _constant1.constant = (kWindowW-186)/2;
    _constant2.constant = -120;
    _constant3.constant = -120;
    _constant4.constant = -120;

    [self.view layoutIfNeeded];
}

//关闭动画
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    needAnimation = NO;
}

-(void)createChesses{
    position = [[NSArray alloc] initWithObjects:@(0),@(11),@(21),@(30),@(10),@(20),@(1),@(2),@(3),@(4),@(12),@(13),@(14),@(22),@(23),@(31),@(32),@(33),@(40),@(41),@(42),@(43),@(51),@(52), nil];
    for (int i = 0; i<8; i++) {
        NSNumber *num = [position objectAtIndex:i];
        int x = 302-num.intValue/10*48;
        int y = 592-num.intValue%10*48;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, ChessWidth, ChessWidth)];
        view.layer.cornerRadius = ChessWidth/2;
        view.backgroundColor = RGBColor(238, 242, 225);
        if (i<4) {
            view.backgroundColor = RGBColor(42, 42, 42);
        }
        [chessesArr addObject:view];
        [self.view addSubview:view];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _constant2.constant = (kWindowW-120)/2;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _constant3.constant = (kWindowW-120)/2;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _constant4.constant = (kWindowW-120)/2;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];

}
//单人游戏
- (IBAction)singlePlayer:(id)sender {
    HPViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"hp"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:^{
    }];
}
//双人游戏
- (IBAction)twoPlayer:(id)sender {
    HHViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"hh"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:^{
    }];
}
//棋子动画
-(void)chessesAnimation{
    if (needAnimation == NO) {
        return;
    }
    NSArray *tempArr = [position sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (arc4random() % 3) - 1;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        for (int i = 0; i<8; i++) {
            UIView *view = [chessesArr objectAtIndex:i];
            NSNumber *num = [tempArr objectAtIndex:i];
            int x = 302-num.intValue/10*48;
            int y = 592-num.intValue%10*48;
            view.frame = CGRectMake(x, y, ChessWidth, ChessWidth);
        }
    }];
}

@end
