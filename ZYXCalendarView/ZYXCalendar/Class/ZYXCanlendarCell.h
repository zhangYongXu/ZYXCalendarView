//
//  YXCanlendarCell.h
//  GW
//
//  Created by 拓之林 on 16/6/16.
//  Copyright © 2016年 拓之林. All rights reserved.
//

typedef NS_ENUM(NSInteger,CanlendarCellTypes) {
    CanlendarCellTypeSelectedDateAsStartDate = 0,
    CanlendarCellTypeSelectedDateAsNormalDate = 1,
    CanlendarCellTypeSelectedDateAsEndDate = 2,
    CanlendarCellTypeUnSelectedDate = 3
};

@interface ZYXCanlendarCell :GWRootCollectionViewCell
@property (strong,nonatomic) UIColor * titleColor;
@property (strong,nonatomic,readonly) NSDate * cellModel;
@property (assign,nonatomic)CanlendarCellTypes canlendarCellType;
-(void)setSelectedDateAsStartDate;
-(void)setSelectedDateAsEndDate;
-(void)setSelectedDateAsNormalDate;
-(void)setUnSelectedDate;

-(void)showTipToday;
@end
