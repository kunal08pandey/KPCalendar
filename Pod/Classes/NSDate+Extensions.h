//  Created by Santosh on 3/7/13.
//  Copyright (c) 2013 Fareportal. All rights reserved.

@interface NSDate (Extensions)
+ (void)initCalendar;
+ (NSCalendar *) calendar;
+ (NSDate *) dateForMinute:(uint)minute hour:(uint)hour day:(uint) day month:(uint)month year:(uint)year;
+ (NSDate *) dateForDay: (uint) day month: (uint) month year: (uint) year;
+ (NSInteger) yearsBetween: (NSDate *) from to: (NSDate *) to;
+ (NSInteger) monthsBetween: (NSDate *) from to: (NSDate *) to; //DK month count based on total number of days
+ (NSInteger) monthsDifference: (NSDate *) from to: (NSDate *) to; //DK month count based on month value under both dates
+ (NSDate *) currentDateWithoutTime;
+ (NSDateFormatter *) buildDateFormatter;
+ (NSString *) convertStringFromString:(NSString *) date fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;
+ (NSDate *) dateFromStringWithFormatting:(NSString *) strDate dateFormat:(NSString *) dateFormat;
+ (NSDate *) dateWithoutTime;
+(void) clearFormatters;
+(NSString *)isoFormatDate:(NSDate *)localDate;
+(NSString *)isoReformatDate:(NSString *)strDate;
+(NSDate *)getFlyNowCurrentDate;
+(NSDate *)getFlyNowEndDate;
+(NSString *)getFlyNowCurrentDay;


- (NSDate *) dateByAddingDays: (NSInteger) days;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingYear: (NSInteger) year; //Sumitk
- (NSDate *) firstDayOfMonth;
- (NSDate *) nextDay;
- (NSDate *) prevDay;
- (NSDate *) prevMonth;
- (NSDate *) nextMonth;
- (NSDate *) nextWeek;
- (NSDate *) nextYear;
- (NSInteger) numDaysInMonth;
- (NSInteger) daysUntil: (NSDate *) date;
- (NSInteger) hoursUntil: (NSDate *) date;
- (NSInteger) minutesUntil: (NSDate *) date;
- (NSInteger) dayOfWeek;
- (NSInteger) timeOfDay;

- (NSDateComponents *) dateComponents;
- (BOOL) isAfterMonth: (NSDate *) date;
- (BOOL) isSameMonth: (NSDate *) date;
- (BOOL) isSameDay: (NSDate *) date;
- (BOOL) isBefore: (NSDate *) date;
- (BOOL) isAfter: (NSDate *) date;
- (NSString *) convertToUTCFormat;
- (NSString *) convertToExactUTC;
- (NSString *) hashKey;
- (NSString *) format: (NSString *) format;
- (NSString *) format:(NSDateFormatterStyle) dateStyle time:(NSDateFormatterStyle) timeStyle;
- (NSString *) convertToCustomeDateFormat:(NSString*) dateFormat;
- (NSString *) convertToDefaultDateFormat; //Sumitk
- (NSDate *) dateWithOutTime; //Sumit K
- (NSString *) dayName;

- (NSString *)timeFormat;
- (NSString *)dateTimeFormat;
- (NSString *) crdeitCardExpiryDateFormat;
- (NSString *)passportDateFormat;
- (NSInteger)daysSinceDate:(NSDate*)toDateTime;
@end
