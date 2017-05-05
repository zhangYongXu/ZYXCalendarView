//
//  YXCalendarView.h
//  GW
//
//  Created by 拓之林 on 16/6/16.
//  Copyright © 2016年 拓之林. All rights reserved.
//
@class ZYXCalendarView;
typedef void (^DidSelectedEndDateBlock)(ZYXCalendarView * view,NSDate * selectedStartDate,NSDate * selectedEndDate);
@interface ZYXCalendarView : GWRootCustomView<GWRootCustomViewProtocol>


@property (copy,nonatomic)DidSelectedEndDateBlock didSelectedEndDateBlock;
-(void)setDidSelectedEndDateBlock:(DidSelectedEndDateBlock)didSelectedEndDateBlock;


-(void)initViewWithStartDate:(NSDate *)startDate ShowMonthCount:(NSInteger)monthCount;

-(void)showCalendarViewWithAnimation:(BOOL)isAnimation;
-(void)hiddenCalendarViewWithAnimation:(BOOL)isAnimation;




@end
