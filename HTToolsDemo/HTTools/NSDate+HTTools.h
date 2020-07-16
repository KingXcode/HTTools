//
//  NSDate+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HTTools)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)ht_day;
- (NSUInteger)ht_month;
- (NSUInteger)ht_year;
- (NSUInteger)ht_hour;
- (NSUInteger)ht_minute;
- (NSUInteger)ht_second;
+ (NSUInteger)ht_day:(NSDate *)date;
+ (NSUInteger)ht_month:(NSDate *)date;
+ (NSUInteger)ht_year:(NSDate *)date;
+ (NSUInteger)ht_hour:(NSDate *)date;
+ (NSUInteger)ht_minute:(NSDate *)date;
+ (NSUInteger)ht_second:(NSDate *)date;



/**
 * 获取一年中的总天数
 */
- (NSUInteger)ht_daysInYear;
+ (NSUInteger)ht_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)ht_isLeapYear;
+ (BOOL)ht_isLeapYear:(NSDate *)date;


/**
 * 获取该月的第一天的日期
 */
- (NSDate *)ht_begindayOfMonth;
+ (NSDate *)ht_begindayOfMonth:(NSDate *)date;


/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)ht_lastdayOfMonth;
+ (NSDate *)ht_lastdayOfMonth:(NSDate *)date;


/**
 * 返回day月后的日期(若day为负数,则为|day|月前的日期)
 */
- (NSDate *)ht_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)ht_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)ht_dateAfterDay:(NSUInteger)day;
+ (NSDate *)ht_dateAfterDate:(NSDate *)date day:(NSInteger)day;




/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)ht_isSameDay:(NSDate *)anotherDate;



/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)ht_isToday;



/**
 * 根据日期返回字符串
 */
+ (NSString *)ht_stringWithDate:(NSDate *)date format:(NSString *_Nullable)format;
- (NSString *)ht_stringWithFormat:(NSString * _Nullable)format;


/**
 * 根据字符串返回日期
 * format:"yyyy-MM-dd HH:mm"
 * string 的格式 与format 对应
 */
+ (NSDate *)ht_dateWithString:(NSString *)string format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
