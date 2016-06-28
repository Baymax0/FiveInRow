//
//  Constant.h
//  五子棋
//
//  Created by Baymax on 16/5/19.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//通过RGB设置颜色
#define RGBColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
//应用程序的屏幕高度
#define kWindowH   [UIScreen mainScreen].bounds.size.height
//应用程序的屏幕宽度
#define kWindowW    [UIScreen mainScreen].bounds.size.width
//将定时器加到子线程中
#define AddTimerToSubThread(NSTimer) 


#pragma mark ===棋盘样式===
//棋盘大小
#define boardWidth [UIScreen mainScreen].bounds.size.width-10
//黑棋颜色
#define kBLACK [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1.0]
//白色棋颜色
#define kWHITE [UIColor colorWithRed:233/255.0 green:233/255.0 blue:223/255.0 alpha:1.0]
//棋子小红匡
#define kRED [UIColor colorWithRed:203/255.0 green:90/255.0 blue:94/255.0 alpha:1.0]

//高分数颜色
#define kHighScoreColor [UIColor colorWithRed:238/255.0 green:67/255.0 blue:67/255.0 alpha:1.0]
//低分数颜色
#define kLowScoreColor [UIColor colorWithRed:205/255.0 green:208/255.0 blue:193/255.0 alpha:1.0]


//根据x（第几根线0~14）获得棋盘横坐标（纵坐标）
#define coordinate(x) ((boardWidth-15.0)/14+1)*x+1+5
//棋盘上初始参考点的边长的一半
#define pointW 3
//关于某个点的落子情况的枚举
typedef NS_ENUM(NSInteger,ChessManType){
    ChessMan_Blcak = 1,//黑子
    ChessMan_White = -1,//白子
    ChessMan_Null = 0 //无子
};




#endif /* Constant_h */




