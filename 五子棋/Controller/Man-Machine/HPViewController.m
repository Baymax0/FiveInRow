//
//  HPViewViewController.m
//  五子棋
//
//  Created by Baymax on 16/6/5.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "HPViewController.h"
#import "AgainstView.h"
#import "GBI.h"

@interface HPViewController (){
    //下一步的颜色
    ChessManType nextType;
    //计算机落子算法
    GBI *gbi;
    //开始动画
    AgainstView *againstView;
    
}
//当前是否可落子
@property (assign , nonatomic) BOOL touchAvailable;

@property (weak, nonatomic) IBOutlet ChessboardView *chessBoardView;
@property (weak, nonatomic) IBOutlet UIView *blackFlag;
@property (weak, nonatomic) IBOutlet UIView *whiteFlag;

@property (weak, nonatomic) IBOutlet UILabel *score1;
@property (weak, nonatomic) IBOutlet UILabel *score2;

@end

@implementation HPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nextType = ChessMan_Blcak;
    //开场动画
    againstView = [AgainstView getAgainstView];
    [self.view addSubview:againstView];
    self.touchAvailable = NO;
    //记录谁先下的棋
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(nextType) forKey:@"FirstStepTeam"];
    
    gbi = [[GBI alloc] init];
    self.chessBoardView.degelate = self;
    int radius = _blackFlag.frame.size.width/2;
    
    _blackFlag.backgroundColor = kBLACK;
    _blackFlag.layer.cornerRadius = radius;
    _whiteFlag.backgroundColor = kWHITE;
    _whiteFlag.layer.cornerRadius = radius;
    
    _score1.text = @"0";
    _score2.text = @"0";
}

-(void)viewDidAppear:(BOOL)animated{
    [againstView run:^{
        self.touchAvailable = YES;
    }];
}


//落子
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //当前是否可点击
    if (!self.touchAvailable) {
        return;
    }
    UITouch *touch     = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.chessBoardView];
    //判断范围
    if (touchPoint.y < -5 || touchPoint.y>kWindowW+5) {
        return;
    }
    
    int space = (boardWidth-15.0)/14+1;
    //获得落子点在棋盘上的坐标
    int x = (touchPoint.x-5+space/2)/space;
    int y = (touchPoint.y-5+space/2)/space;
    //获得落子模型
    MoveModel *moveModel = [[MoveModel alloc] init];
    moveModel.x = x;
    moveModel.y = y;
    moveModel.value = nextType;
    //落子
    if ([self.chessBoardView move:moveModel]) {
        self.touchAvailable = NO;
        nextType = ChessMan_White;
        [self computerStep];
    };
}
//电脑下棋
-(void)computerStep{
    gbi.chessArr = self.chessBoardView.boardModel.arr;
    NSInteger i = [gbi computerReturnBestIndexPath];
    //获得落子模型
    MoveModel *moveModel = [[MoveModel alloc] init];
    moveModel.x = i%15;
    moveModel.y = i/15;
    moveModel.value = nextType;
    //落子
    if ([self.chessBoardView move:moveModel]) {
        nextType = ChessMan_Blcak;
        self.touchAvailable = YES;
    };
}
#pragma mark --按钮事件--
//退出
- (IBAction)quit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
//悔棋
- (IBAction)Undo:(id)sender {
    //当前是否可点击(等电脑下完那一步)
    if (!self.touchAvailable) {
        return;
    }
    if (self.chessBoardView.piecesArray.count==0) {
        return;
    }
    //撤销两步棋（一黑一白）
    [self.chessBoardView undoTwoStep];
}
//认输
- (IBAction)giveUp:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要放弃比赛？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 1;
    [alert show];
}
#pragma mark --ChessboardDelegate--
//获胜响应方法
-(void)successBy:(ChessManType)chessManType{
    [self winnerIs:chessManType];
    NSString*str = chessManType==ChessMan_Blcak?@"黑棋获胜":@"白棋获胜";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 2;
    [alert show];
}
#pragma mark --UIAlertViewDelegate--
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self winnerIs:[self getOtherType:nextType]];
        }else{
            return;
        }
    }
    nextType = ChessMan_Blcak;
    [self.chessBoardView reStart];
}

-(void)winnerIs:(ChessManType) player{
    if (player == ChessMan_Blcak) {
        NSInteger i = _score1.text.integerValue+1;
        _score1.text = [NSString stringWithFormat:@"%li",(long)i];
    }else{
        NSInteger i = _score2.text.integerValue+1;
        _score2.text = [NSString stringWithFormat:@"%li",(long)i];
    }
    _score1.textColor = kLowScoreColor;
    _score2.textColor = kLowScoreColor;
    //分数高的红色表示
    if (_score1.text.integerValue>_score2.text.integerValue) {
        _score1.textColor = kHighScoreColor;
    }
    if (_score2.text.integerValue>_score1.text.integerValue) {
        _score2.textColor = kHighScoreColor;
    }
}

//获得另一方的棋子
-(ChessManType)getOtherType:(ChessManType)type{
    if (type==ChessMan_Blcak) {
        return  ChessMan_White;
    }else{
        return  ChessMan_Blcak;
    }
}

@end
