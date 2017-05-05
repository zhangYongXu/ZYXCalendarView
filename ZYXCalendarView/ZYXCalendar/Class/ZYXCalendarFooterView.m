//
//  YXCalendarFooterView.m
//  GW
//
//  Created by 拓之林 on 16/6/17.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import "ZYXCalendarFooterView.h"

@implementation ZYXCalendarFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)initUI{
    [self drawBorderSolidLineWithPosition:BorderLinePositionBottom Color:[UIColor colorWithHex:AppViewBottomLineColor] Width:AppViewBottomLineWidth];
}

@end
