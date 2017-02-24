//
//  JSHTWeek.m
//  输入日期获取星期几
//
//  Created by jshtmhy on 16/9/22.
//  Copyright © 2016年 jshtmhy. All rights reserved.
//

#import "JSHTWeek.h"

@implementation JSHTWeek
NSMutableArray *_weekArray;
+ (NSArray *)getDate {
    
    // 获取系统时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    // 设置显示格式
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *now = [NSDate date];
    
    // 日历
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // 全局数组，使用tableview展示数据
    
    _weekArray = [NSMutableArray array];
    
    // for 循环获取各7天的数据
    
    for (int i = 0; i <7; i ++) {
        
        NSDate *date = [now dateByAddingTimeInterval:i*3600*24];
        
        NSString *dateStr = [formatter stringFromDate:date];
        
        // 日期组件
        
        NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
        
        //        NSLog(@"comps==%@",comps);
        
        NSInteger intweek = [comps weekday];
        
        // 获取日期，拼接日期字符串
        
        NSString *stringDate = [NSString stringWithFormat:@"%@;%@", dateStr, [self week:intweek]];
        
        //        NSLog(@"dateStr===%@",dateStr);
        
        [_weekArray addObject:stringDate];

    }
    return _weekArray;
}

//2.获取星期几


// 判断星期

+ (NSString*)week:(NSInteger)week {
    
    
    
    NSString*weekStr=nil;
    
    
    
    if(week==1) {
        
        weekStr=@"日";
        
        
        
    } else if(week==2) {
        
        weekStr=@"一";
        
        
        
    } else if(week==3) {
        
        weekStr=@"二";
        
        
        
    } else if(week==4) {
        
        weekStr=@"三";
        
        
        
    } else if(week==5) {
        
        weekStr=@"四";
        
        
        
    } else if(week==6) {
        
        weekStr=@"五";
        
        
        
    } else if(week==7) {
        
        weekStr=@"六";
        
        
        
    }
    
    return weekStr;
    
}
@end
