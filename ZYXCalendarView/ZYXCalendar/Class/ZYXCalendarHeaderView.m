//
//  YXCalendarHeaderView.m
//  GW
//
//  Created by 拓之林 on 16/6/16.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import "ZYXCalendarHeaderView.h"
@interface ZYXCalendarHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *weekLabelArray;

@property (strong,nonatomic) NSDate * model;

@end
@implementation ZYXCalendarHeaderView
-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)initData{

}

-(void)initUI{
    CGFloat w = SCREEN_WIDTH/7.0;
    for(NSInteger i = 0;i<self.weekLabelArray.count;i++){
        UILabel * label = self.weekLabelArray[i];
        label.width = w;
        label.left = i*w;
    }
}

-(void)refrshUI{
    self.titleLabel.text = [self.model stringWithFormat:@"yyyy年MM月"];
}
-(void)setViewWithModel:(NSDate*)model{
    self.model = model;
    [self refrshUI];
}

@end
