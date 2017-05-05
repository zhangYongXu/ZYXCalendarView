//
//  ViewController.m
//  ZYXCalendarView
//
//  Created by 极客天地 on 2017/5/5.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ViewController.h"
#import "ZYXCalendarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic) ZYXCalendarView * calendarView;
@end

@implementation ViewController
- (ZYXCalendarView *)calendarView{
    if(nil == _calendarView){
        _calendarView = [ZYXCalendarView loadFromXib];
        _calendarView.height = SCREEN_HEIGHT - 20;
        _calendarView.top = 20;
        [APPDelegate.window.rootViewController.view addSubview:_calendarView];
        
        [_calendarView initViewWithStartDate:[[NSDate alloc] init] ShowMonthCount:3];
        __weak typeof(self) weakSelf = self;
        [_calendarView setDidSelectedEndDateBlock:^(ZYXCalendarView *view, NSDate *selectedStartDate, NSDate *selectedEndDate) {
            [view hiddenCalendarViewWithAnimation:YES];
            //weakSelf.holidayViewModel.startDate = selectedStartDate;
            //weakSelf.holidayViewModel.endDate = selectedEndDate;
            NSString * dateStr = [NSString stringWithFormat:@"%@ ~ %@",[selectedStartDate stringWithFormat:@"yyyy-MM-dd"],[selectedEndDate stringWithFormat:@"yyyy-MM-dd"]];
            weakSelf.label.text = dateStr;

        }];
    }
    return _calendarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectDatePeriodClicked:(id)sender {
    if(self.calendarView.hidden){
        [self.calendarView showCalendarViewWithAnimation:YES];
    }else{
        [self.calendarView hiddenCalendarViewWithAnimation:YES];
    }
}

@end
