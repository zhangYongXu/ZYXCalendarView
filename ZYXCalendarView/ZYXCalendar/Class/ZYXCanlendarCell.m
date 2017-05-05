//
//  YXCanlendarCell.m
//  GW
//
//  Created by 拓之林 on 16/6/16.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import "ZYXCanlendarCell.h"
@interface ZYXCanlendarCell()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong,nonatomic) NSDate * model;
@end
@implementation ZYXCanlendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)initData{
    self.canlendarCellType = CanlendarCellTypeUnSelectedDate;
}
-(void)initUI{
    self.dateLabel.layer.masksToBounds = YES;
    self.dateLabel.layer.cornerRadius = self.dateLabel.height/2.0;
    
}
-(void)refreshUI{
    if(self.model){
        NSInteger day = [[self.model stringWithFormat:@"dd"] integerValue];
        self.dateLabel.text = [NSString stringWithFormat:@"%@",@(day)];
        self.dateLabel.hidden = NO;
    }else{
        self.dateLabel.hidden = YES;
    }
    
}

-(void)setCellWithModel:(id)model{
    self.model = model;
    [self refreshUI];
}
-(NSDate *)cellModel{
    return self.model;
}
-(void)setTitleColor:(UIColor *)titleColor{
    self.dateLabel.textColor = titleColor;
}
-(UIColor *)titleColor{
    return self.dateLabel.tintColor;
}


-(void)setSelectedDateAsStartDate{
    self.leftView.backgroundColor = [UIColor whiteColor];
    self.rightView.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateView.backgroundColor = [UIColor clearColor];
    self.dateLabel.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.canlendarCellType = CanlendarCellTypeSelectedDateAsStartDate;
}
-(void)setSelectedDateAsNormalDate{
    self.leftView.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.rightView.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateView.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateLabel.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.canlendarCellType = CanlendarCellTypeSelectedDateAsNormalDate;
}
-(void)setSelectedDateAsEndDate{
    self.leftView.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.rightView.backgroundColor = [UIColor whiteColor];
    self.dateView.backgroundColor = [UIColor clearColor];
    self.dateLabel.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateLabel.textColor = [UIColor whiteColor];
    self.canlendarCellType = CanlendarCellTypeSelectedDateAsEndDate;
}
-(void)setUnSelectedDate{
    self.leftView.backgroundColor = [UIColor whiteColor];
    self.rightView.backgroundColor = [UIColor whiteColor];
    self.dateView.backgroundColor = [UIColor clearColor];
    self.dateLabel.backgroundColor = [UIColor whiteColor];
    self.dateLabel.textColor = [UIColor colorWithHex:0x464b4d];
    self.canlendarCellType = CanlendarCellTypeUnSelectedDate;
}

-(void)showTipToday{
    self.dateLabel.backgroundColor = [UIColor colorWithHex:0xff5d55];
    self.dateLabel.textColor = [UIColor whiteColor];
}
@end
