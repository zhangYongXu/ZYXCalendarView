//
//  YXCalendarView.m
//  BoBo
//
//  Created by 拓之林 on 15/9/16.
//  Copyright © 2015年 海浪. All rights reserved.
//

#import "ZYXCalendarView.h"

#import "ZYXCanlendarCell.h"
#import "ZYXCalendarHeaderView.h"
#import "ZYXCalendarFooterView.h"

@interface ZYXCalendarView()<UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) NSDate * startDate;
@property (assign,nonatomic) NSInteger showMonthCount;

@property (strong,nonatomic) NSMutableArray * yearMonthArray;

@property (strong,nonatomic) NSDate * today;


@property (strong,nonatomic) UIView * mySuperView;

@property (strong,nonatomic) NSDate* selectedStartDate;
@property (strong,nonatomic) NSDate* selectedEndDate;


@property (strong,nonatomic) NSNumber * showHeight;

@end
@implementation ZYXCalendarView
-(NSDate *)today{
    if(nil == _today){
        _today = [[NSDate alloc] init];
    }
    return _today;
}

-(NSMutableArray *)yearMonthArray{
    if(nil  == _yearMonthArray){
        _yearMonthArray = [[NSMutableArray alloc] init];
    }
    return _yearMonthArray;
}
-(void)awakeFromNib{
    [super awakeFromNib];

}


-(void)showCalendarViewWithAnimation:(BOOL)isAnimation{
    if(nil == self.mySuperView || (nil != self.superview && self.mySuperView != self.superview)){
        self.mySuperView = self.superview;
    }
    
    if(!self.hidden){
        return;
    }
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    for(UIView * view in self.mySuperView.subviews){
        if([view isKindOfClass:[GWRootCustomView<GWRootCustomViewProtocol> class]]){
            if([view respondsToSelector:@selector(hiddenViewWithAnimation:)]){
                GWRootCustomView<GWRootCustomViewProtocol> * dropView = (GWRootCustomView<GWRootCustomViewProtocol> *)view;
                [dropView hiddenViewWithAnimation:NO];
            }
        }
    }
    
    if(nil == self.showHeight){
        self.showHeight = [NSNumber numberWithFloat:self.height];
    }
    
    self.height = 0;
    
    
    [self.mySuperView addSubview:self];
    if(isAnimation){
        self.hidden = NO;
        [UIView animateWithDuration:0.15 animations:^{
            self.height = [self.showHeight floatValue];
            //self.alpha = 1;
        }completion:^(BOOL finished) {
            self.collectionView.height = self.height - self.topView.height;
        }];
    }else{
        self.hidden = NO;
        //self.alpha = 1;
    }
    
}
-(void)hiddenViewWithAnimation:(BOOL)animation{
    [self hiddenCalendarViewWithAnimation:YES];
}
-(void)hiddenCalendarViewWithAnimation:(BOOL)isAnimation{
    if(self.hidden){
        return;
    }

    
    if(isAnimation){
        [UIView animateWithDuration:0.15 animations:^{
            self.height = 0;
            //self.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            [self removeFromSuperview];
        }];
    }else{
        self.hidden = YES;
        //self.alpha = 0;
        [self removeFromSuperview];
    }
}


-(void)initData{
    self.startDate = self.today;
    self.showMonthCount = 3;
    
    
}

-(void)reloadData{
    [self.yearMonthArray removeAllObjects];
    
    NSInteger totalMonths = self.showMonthCount;
    
    [self.yearMonthArray addObject:self.startDate];
    for(NSUInteger i = 0;i<totalMonths-1;i++){
        [self.yearMonthArray addObject:[self.yearMonthArray.lastObject nextMonth]];
    }
}


-(void)initUI{

    
    [self.collectionView registerNib:[ZYXCanlendarCell cellNib] forCellWithReuseIdentifier:[ZYXCanlendarCell reuseIdentifier]];
    [self.collectionView registerNib:[ZYXCalendarHeaderView viewNib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ZYXCalendarHeaderView reuseIdentifier]];
    [self.collectionView registerNib:[ZYXCalendarFooterView viewNib] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[ZYXCalendarFooterView reuseIdentifier]];
    
}

-(void)initViewWithStartDate:(NSDate *)startDate ShowMonthCount:(NSInteger)monthCount{
    self.hidden = YES;
    //view.alpha = 0;
    
    self.startDate = startDate;
    self.showMonthCount = monthCount;
    
    [self reloadData];
    
}
#pragma mark collectionView 数据源与代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger count = self.yearMonthArray.count;
    return count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDate * ymDate = self.yearMonthArray[section];
    NSInteger monthTotalDays = [self cancultatorCountWithYMDate:ymDate];
    return monthTotalDays;
}

#pragma mark 计算这月的第一天
- (NSDate*)cancultatorFirstDayWithYMDate:(NSDate*)ymDate{
    NSDate * date = ymDate;
    
    NSString * year = [date stringWithFormat:@"yyyy"];
    NSString * month = [date stringWithFormat:@"MM"];
    
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@-01 12:00:00",year,month];
    NSDate* firstDate = [NSDate dateWithString:dateStr formate:@"yyyy-MM-dd HH:mm:ss"];
    
    return firstDate;
}
#pragma mark 计算这个月总共的天数
- (NSInteger)cancultatorTotalDaysWithYMDate:(NSDate*)ymDate{
    
    NSInteger count = [[self cancultatorFirstDayWithYMDate:ymDate] howManyDays];
    
     return count;
}
#pragma mark 计算星期天数差值
- (NSInteger)cancultatorOffDaysWithYMDate:(NSDate*)ymDate{
    
    NSInteger week = [[[self cancultatorFirstDayWithYMDate:ymDate] stringWithFormat:@"c"] integerValue];
    
    NSInteger offDays = week - 1;
    
    return offDays;
}
#pragma mark 计算需要显示cell的个数
- (NSInteger)cancultatorCountWithYMDate:(NSDate*)ymDate{
    NSInteger offDays = [self cancultatorOffDaysWithYMDate:ymDate];
    
    NSInteger count = [self cancultatorTotalDaysWithYMDate:ymDate];
    count = count + offDays;
    NSInteger rows = count%7==0?count/7:count/7+1;
    count = rows * 7;
    
    return count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYXCanlendarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZYXCanlendarCell reuseIdentifier] forIndexPath:indexPath];
    NSDate * ymDate = self.yearMonthArray[indexPath.section];
    NSInteger offDays = [self cancultatorOffDaysWithYMDate:ymDate];
    NSInteger count = [self cancultatorTotalDaysWithYMDate:ymDate];
    
    NSInteger rowIndex = indexPath.row - offDays;
    
    if(rowIndex>=0 && rowIndex<count){
        
        NSString * year = [ymDate stringWithFormat:@"yyyy"];
        NSString * month = [ymDate stringWithFormat:@"MM"];
        
        
        NSString * day = [NSString stringWithFormat:@"%ld",rowIndex+1];
   
        

        NSString* dateStr = [NSString stringWithFormat:@"%@-%@-%@ 12:00:00",year,month,day];
        NSDate * date = [NSDate dateWithString:dateStr formate:@"yyyy-MM-dd HH:mm:ss"];
 
        [cell setCellWithModel:date];
        
        NSInteger dateNum = [[date stringWithFormat:@"yyyyMMdd"] integerValue];
        if(self.selectedStartDate && self.selectedEndDate){
            NSInteger startDateNum = [[self.selectedStartDate stringWithFormat:@"yyyyMMdd"] integerValue];
            NSInteger endDateNum = [[self.selectedEndDate stringWithFormat:@"yyyyMMdd"] integerValue];
            if(dateNum == startDateNum){
                [cell setSelectedDateAsStartDate];
            }else if(dateNum == endDateNum){
                [cell setSelectedDateAsEndDate];
            }else if(dateNum > startDateNum && dateNum < endDateNum){
                [cell setSelectedDateAsNormalDate];
            }else{
                [cell setUnSelectedDate];
            }
            
        }else if(self.selectedStartDate && !self.selectedEndDate){
            NSInteger startDateNum = [[self.selectedStartDate stringWithFormat:@"yyyyMMdd"] integerValue];
            if(dateNum == startDateNum){
                [cell setSelectedDateAsStartDate];
            }else{
                [cell setUnSelectedDate];
            }
        }else {
            [cell setUnSelectedDate];
        }
        
        NSInteger todayNum = [[self.today stringWithFormat:@"yyyyMMdd"] integerValue];
        //选择在今天之前不处理
        if(dateNum < todayNum){
            cell.titleColor = [UIColor colorWithHex:0xd6d6d6];
        }
        
        if(cell.canlendarCellType == CanlendarCellTypeUnSelectedDate && dateNum == todayNum){
            [cell showTipToday];
        }
        
    }else {
        [cell setCellWithModel:nil];
        [cell setUnSelectedDate];
    }
    
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger off = ((NSInteger)SCREEN_WIDTH)%7;
    CGFloat w = (SCREEN_WIDTH-off)/7.0;
    return CGSizeMake(w, 35);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 75);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 1);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    NSInteger off = ((NSInteger)SCREEN_WIDTH)%7;
    CGFloat rl = off/2.0;
    return UIEdgeInsetsMake(5, rl, 5, rl);
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        ZYXCalendarHeaderView  * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[ZYXCalendarHeaderView reuseIdentifier] forIndexPath:indexPath];
        NSDate * ymDate = self.yearMonthArray[indexPath.section];
        [view setViewWithModel:ymDate];
        return view;
    }else{
        
        ZYXCalendarFooterView  * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[ZYXCalendarFooterView reuseIdentifier] forIndexPath:indexPath];
        return view;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ZYXCanlendarCell * cell = (ZYXCanlendarCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSDate * date  = cell.cellModel;
    NSInteger dateNum = [[date stringWithFormat:@"yyyyMMdd"] integerValue];
    NSInteger todayNum = [[self.today stringWithFormat:@"yyyyMMdd"] integerValue];
    
    //选择在今天之前不处理
    if(dateNum < todayNum){
        return;
    }
    
    if(nil == self.selectedStartDate){
        self.selectedStartDate = date;
    }else{
        NSInteger startDateNum = [[self.selectedStartDate stringWithFormat:@"yyyyMMdd"] integerValue];
        if(dateNum < startDateNum){
            self.selectedStartDate = date;
        }else if(dateNum > startDateNum){
            self.selectedEndDate = date;
            if(self.didSelectedEndDateBlock){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.didSelectedEndDateBlock(self,self.selectedStartDate,self.selectedEndDate);
                });
            }
        }
    }
    [self.collectionView reloadData];
}
- (IBAction)resetDateBtnClicked:(id)sender {
    self.selectedStartDate = nil;
    self.selectedEndDate = nil;
    [self.collectionView reloadData];
}


@end
