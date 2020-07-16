//
//  NSDate+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "NSDate+HTTools.h"

@implementation NSDate (HTTools)


- (NSUInteger)ht_day {
    return [NSDate ht_day:self];
}

- (NSUInteger)ht_month {
    return [NSDate ht_month:self];
}

- (NSUInteger)ht_year {
    return [NSDate ht_year:self];
}

- (NSUInteger)ht_hour {
    return [NSDate ht_hour:self];
}

- (NSUInteger)ht_minute {
    return [NSDate ht_minute:self];
}

- (NSUInteger)ht_second {
    return [NSDate ht_second:self];
}


+ (NSUInteger)ht_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)ht_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)ht_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)ht_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)ht_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)ht_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}


//获取一年中的总天数
- (NSUInteger)ht_daysInYear {
    return [NSDate ht_daysInYear:self];
}
//获取一年中的总天数
+ (NSUInteger)ht_daysInYear:(NSDate *)date {
    return [self ht_isLeapYear:date] ? 366 : 365;
}

//判断是否是润年
- (BOOL)ht_isLeapYear {
    return [NSDate ht_isLeapYear:self];
}
//判断是否是润年
+ (BOOL)ht_isLeapYear:(NSDate *)date {
    NSUInteger year = [date ht_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}


//获取该月的最后一天的日期
- (NSDate *)ht_lastdayOfMonth {
    return [NSDate ht_lastdayOfMonth:self];
}

//获取该月的最后一天的日期
+ (NSDate *)ht_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self ht_begindayOfMonth:date];
    return [[lastDate ht_dateAfterMonth:1] ht_dateAfterDay:-1];
}

//获取该月的第一天的日期
- (NSDate *)ht_begindayOfMonth {
    return [NSDate ht_begindayOfMonth:self];
}
//获取该月的第一天的日期
+ (NSDate *)ht_begindayOfMonth:(NSDate *)date {
    return [self ht_dateAfterDate:date day:-[date ht_day] + 1];
}

//返回day月后的日期(若day为负数,则为|day|月前的日期)
- (NSDate *)ht_dateAfterMonth:(NSUInteger)month {
    return [NSDate ht_dateAfterDate:self month:month];
}
//返回day月后的日期(若day为负数,则为|day|月前的日期)
+ (NSDate *)ht_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    return dateAfterMonth;
}

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)ht_dateAfterDay:(NSUInteger)day {
    return [NSDate ht_dateAfterDate:self day:day];
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
+ (NSDate *)ht_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    return dateAfterDay;
}


//日期是否相等
- (BOOL)ht_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}


- (BOOL)ht_isToday {
    return [self ht_isSameDay:[NSDate date]];
}

//根据日期返回字符串
+ (NSString *)ht_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date ht_stringWithFormat:format];
}

//根据日期返回字符串
- (NSString *)ht_stringWithFormat:(NSString * _Nullable)format {
    if (![format isKindOfClass:NSString.class] || format.length <= 0) {
        format = @"yyyy:MM:dd HH:mm:ss";
    }
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *retStr = [outputFormatter stringFromDate:self];
    return retStr;
}


+ (NSDate *)ht_dateWithString:(NSString *)string format:(NSString *)format {
    
    if (![format isKindOfClass:NSString.class] || format.length <= 0) {
        format = @"yyyy:MM:dd HH:mm:ss";
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

@end
