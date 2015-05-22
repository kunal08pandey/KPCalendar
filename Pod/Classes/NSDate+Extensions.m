//  Created by Santosh on 3/7/13.
//  Copyright (c) 2013 Fareportal. All rights reserved.

#import "NSDate+Extensions.h"
#import "NSString+Extensions.h"
static NSCalendar *calendar;
static NSMutableDictionary *formatters;
@implementation NSDate (Extensions)


+ (void) initCalendar {
  calendar = [NSCalendar currentCalendar];
  calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
  formatters = [[NSMutableDictionary alloc] init];
}

+ (NSCalendar *) calendar {
  return calendar;
}

+ (NSDate *) dateForMinute: (uint)minute hour:(uint)hour day:(uint) day month:(uint)month year:(uint)year {
  NSDateComponents *c = [[NSDateComponents alloc] init];
  c.calendar = calendar;
  c.hour = hour;
  c.minute = minute;
  c.day = day;
  c.month = month;
  c.year = year;
  return [calendar dateFromComponents:c];
}

+ (NSDate *) dateForDay: (uint) day month: (uint) month year: (uint) year {
  NSDateComponents *c = [[NSDateComponents alloc] init];
  c.calendar = calendar;
  c.day = day;
  c.month = month;
  c.year = year;
  return [calendar dateFromComponents:c];
}

+ (NSDate *) currentDateWithoutTime {
  NSDate *output = [NSDate date];
  NSDateComponents *components = output.dateComponents;
  
  [components setHour:0];
  [components setMinute:0];
  [components setSecond:0];
  [components setTimeZone: calendar.timeZone];
  return [calendar dateFromComponents: components];
}

+ (NSInteger) yearsBetween: (NSDate *) from to: (NSDate *) to {
  if(from == nil || to == nil) return 0;
  NSDateComponents *compontent = [calendar components:NSYearCalendarUnit fromDate:from toDate:to options:0];
  return compontent.year;
}

+ (NSInteger) monthsBetween: (NSDate *) from to: (NSDate *) to {
  if(from == nil || to == nil) return 0;
  NSDateComponents *compontent = [calendar components:NSMonthCalendarUnit fromDate:from toDate:to options:0];
  return compontent.month;
}

+ (NSInteger) monthsDifference: (NSDate *) from to: (NSDate *) to {
  NSDate *fromStartDate = [from firstDayOfMonth];
  NSDate *toStartDate = [to firstDayOfMonth];
  return [NSDate monthsBetween:fromStartDate to:toStartDate];
  
}

+ (NSDateFormatter *) buildDateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  //    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
  formatter.timeZone = calendar.timeZone;
  //    if([language isEqualToString:@"en"]) {
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
  //    } else if([language isEqualToString:@"es"]) {
  //        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];
  //    } else if([language isEqualToString:@"fr"]) {
  //        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"fr_CA"]];
  //    } else if([language isEqualToString:@"zh-Hans"]) {
  //        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans_HK"]];
  //    } else {
  //        [formatter setLocale:[NSLocale currentLocale]];
  //    }
  return formatter;
}

+ (NSDate *) dateFromStringWithFormatting:(NSString *) strDate dateFormat:(NSString *) dateFormat {
  static NSDateFormatter *parser = nil;
  if(!parser) {
    parser = [[NSDateFormatter alloc] init];
    parser.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [parser setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //[parser setDateFormat:dateFormat];
  }
  [parser setDateFormat:dateFormat];
  
  return [parser dateFromString: strDate];
}

//get formatted string from one format to other
+ (NSString *) convertStringFromString:(NSString *) date fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat {
  NSDateFormatter *fromFormatter = [[NSDateFormatter alloc] init];
  [fromFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [fromFormatter setDateFormat:fromFormat];
  NSDateFormatter *toFormatter = [[NSDateFormatter alloc] init];
  [toFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [toFormatter setDateFormat:toFormat];
  return [toFormatter stringFromDate:[fromFormatter dateFromString:date]];
}

+ (NSDate *) dateWithoutTime {
  NSDate *output = [NSDate date];
  NSDateComponents *components = output.dateComponents;
  
  [components setHour:0];
  [components setMinute:0];
  [components setSecond:0];
  [components setTimeZone: calendar.timeZone];
  return [calendar dateFromComponents: components];
}

+(void) clearFormatters {
  formatters = nil;
}

+ (NSString *)isoFormatDate:(NSDate *)localDate {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  [df setDateFormat:@"YYYY-MM-dd'T'HH:mm:ssZZZZZ"];
  NSString *isoDate = [df stringFromDate:localDate];
  return isoDate;
}

+ (NSString *)isoReformatDate:(NSString *)strDate {
  NSDateFormatter* df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZZZ"];
  NSDate* inDate = [df dateFromString:strDate];
  [df setDateFormat:@"YYYY-MM-dd'T'HH:mm:ssZZZZZ"];
  NSString* reformattedDate = [df stringFromDate:inDate];
  return reformattedDate;
}

///// fly now
+(NSDate *)getFlyNowCurrentDate {
  return [NSDate currentDateWithoutTime];
}

+(NSDate *)getFlyNowEndDate {
  return [[NSDate currentDateWithoutTime] dateByAddingTimeInterval:86400*3];
}

+(NSString *)getFlyNowCurrentDay {
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  [dateFormat setDateFormat:@"EEEE"];
  NSString *day = [[dateFormat stringFromDate:[NSDate date]] uppercaseString];
  return ([day substringToIndex:2]);
}


- (NSDate *) firstDayOfMonth {
  NSDate *d = nil;
  [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&d interval:NULL forDate: self];
  return d;
}

- (NSDate *) nextDay {
  static NSDateComponents *offset = nil;
  if(offset == nil) {
    offset = [[NSDateComponents alloc] init];
    [offset setDay: 1];
    [offset setTimeZone: calendar.timeZone];
  }
  return [calendar dateByAddingComponents: offset toDate: self options: 0];
}

- (NSDate *) prevDay {
  static NSDateComponents *offset = nil;
  if(offset == nil) {
    offset = [[NSDateComponents alloc] init];
    [offset setDay: -1];
    [offset setTimeZone: calendar.timeZone];
  }
  return [calendar dateByAddingComponents: offset toDate: self options: 0];
}

- (NSDate *) dateByAddingDays: (NSInteger) days {
  NSDateComponents *components = self.dateComponents;
  [components setHour:0];
  [components setMinute:0];
  [components setSecond:0];
  
  [components setDay: components.day + days];
  return [calendar dateFromComponents: components];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths{
  NSDateComponents *components = self.dateComponents;
  
  [components setMonth: components.month + dMonths];
  return [calendar dateFromComponents: components];
}

- (NSDate *) dateByAddingYear: (NSInteger) year {
  NSDateComponents *components = self.dateComponents;
  
  [components setYear: components.year + year];
  return [calendar dateFromComponents: components];
}

- (NSDate *) nextMonth {
  NSDateComponents *components = self.dateComponents;
  
  [components setDay:1];
  [components setMonth: components.month + 1];
  return [calendar dateFromComponents: components];
}

- (NSDate *) nextWeek {
  NSDate *date = [self nextDay];
  while([date dayOfWeek] != 0) date = [date nextDay];
  return date;
}

- (NSDate *) prevMonth {
  NSDateComponents *components = self.dateComponents;
  
  [components setDay:1];
  [components setMonth: components.month - 1];
  return [calendar dateFromComponents: components];
}

- (NSDate *) nextYear {
  NSDateComponents *components = self.dateComponents;
  
  [components setDay:1];
  [components setYear: components.year + 1];
  return [calendar dateFromComponents: components];
}

- (NSDate *) dateWithOutTime{
  NSDateComponents *components = self.dateComponents;
  [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  return [NSDate dateForDay:components.day month:components.month year:components.year];
}

- (NSString *) convertToUTCFormat {
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
  [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  
  return [[[dateFormat stringFromDate:self] substringToIndex:10] stringByAppendingString:@"T00:00:00"];
}

- (NSString *) convertToExactUTC{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
  //[dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  return  [dateFormat stringFromDate:self];
}

- (NSString *) convertToCustomeDateFormat:(NSString*) dateFormat{
  NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
  [dateFormater setDateFormat:dateFormat];
  [dateFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  return [dateFormater stringFromDate:self];
}

- (NSString *) convertToDefaultDateFormat{
  NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
  [dateFormater setDateFormat:@"MM-dd-yyyy"];
  [dateFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  return [dateFormater stringFromDate:self];
}


- (NSInteger) daysUntil:(NSDate *) date {
  const float day = 24 * 60 * 60;
  NSTimeInterval end = [date timeIntervalSinceNow];
  NSTimeInterval start = [self timeIntervalSinceNow];
  float a = (end - start) / day;
  return a;
}

- (NSInteger) hoursUntil: (NSDate *) date {
  const int hour = 60 * 60;
  NSTimeInterval end = [date timeIntervalSinceNow];
  NSTimeInterval start = [self timeIntervalSinceNow];
  return (end - start) / hour;
}

- (NSInteger) minutesUntil: (NSDate *) date{
  const int minute = 60;
  NSTimeInterval start = [date timeIntervalSinceNow];
  NSTimeInterval end = [self timeIntervalSinceNow];
  return (end - start) / minute;
}

- (NSInteger) numDaysInMonth; {
  NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
  return days.length;
}

- (NSInteger) dayOfWeek {
  NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate: self];
  NSInteger day = [weekdayComponents weekday] - [calendar firstWeekday];
  return day < 0 ? day + 7 : day;
}

- (NSDateComponents *) dateComponents {
  NSInteger units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
  return [calendar components:units fromDate: self];
}

- (BOOL) isAfterMonth: (NSDate *) date{
  NSInteger units = NSYearCalendarUnit|NSMonthCalendarUnit;
  NSDateComponents *c1 = [calendar components:units fromDate: date];
  NSDateComponents *c2 = [calendar components:units fromDate: self];
  
  if (c1.year > c2.year)
    return YES;
  
  if(c1.year == c2.year){
    if (c1.month >= c2.month)
      return YES;
    else
      return NO;
  }
  
  if (c1.year < c2.year)
    return NO;
  
  return YES;
}

- (BOOL) isSameMonth: (NSDate *) date {
  NSInteger units = NSYearCalendarUnit|NSMonthCalendarUnit;
  NSDateComponents *c1 = [calendar components:units fromDate: date];
  NSDateComponents *c2 = [calendar components:units fromDate: self];
  return c1.month == c2.month && c1.year == c2.year;
}

- (BOOL) isSameDay: (NSDate *) date {
  NSDateComponents *c1 = date.dateComponents;
  NSDateComponents *c2 = self.dateComponents;
  return c1.day == c2.day && c1.month == c2.month && c1.year == c2.year;
}

- (BOOL) isBefore: (NSDate *) date {
  NSTimeInterval timeDifference = [self timeIntervalSinceDate:date];
  return (timeDifference < 0);
  //return [self compare:date] == NSOrderedAscending; //Dk
}

- (BOOL) isAfter: (NSDate *) date {
  NSTimeInterval timeDifference = [self timeIntervalSinceDate:date];
  return (timeDifference > 0);
  //return [self compare:date] == NSOrderedDescending; //Dk
}

- (NSString *) hashKey {
  return [self format:@"yyyyMMdd"];
}

- (NSInteger) timeOfDay {
  NSDateComponents *c = self.dateComponents;
  return c.hour*100 + c.minute;
}

- (NSString *) format:(NSString *)format {
  NSDateFormatter *formatter = [formatters valueForKey:format];
  if(formatter == nil) {
    formatter = [NSDate buildDateFormatter];
    [formatter setDateFormat:format];
    [formatters setValue:formatter forKey:format];
  }
  
  return [formatter stringFromDate: self];
}

- (NSString *) format:(NSDateFormatterStyle) dateStyle time:(NSDateFormatterStyle) timeStyle {
  NSString *key = [[NSNumber numberWithInt: ((int)dateStyle * 100 + (int)timeStyle)] description];
  NSDateFormatter *formatter = [formatters valueForKey:key];
  if(formatter == nil) {
    formatter = [NSDate buildDateFormatter];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];
    [formatters setValue:formatter forKey:key];
  }
  
  return [formatter stringFromDate: self];
}

- (NSString*) dayName{
  switch (self.dayOfWeek) {
    case 0:
    default: {
      return @"SUN";
    }
      
    case 1:
      return @"MON";
      
    case 2:
      return @"TUE";
      
    case 3:
      return @"WED";
      
    case 4:
      return @"THU";
      
    case 5:
      return @"FRI";
      
    case 6:
      return @"SAT";
  }
  
}

- (NSString *)timeFormat{
  return [[self format:@"hh':'mma"] search:@"M$" replace:@""];
}

- (NSString *)dateTimeFormat{
  return [[self format:@"MMM dd',' yyyy',' hh':'mma"] search:@"M$" replace:@""];
}

- (NSString *)passportDateFormat{
  return [[self format:@"yyyy-MM-dd"] search:@"M$" replace:@""];
}


- (NSString *) crdeitCardExpiryDateFormat{
  NSInteger units = NSYearCalendarUnit|NSMonthCalendarUnit;
  NSDateComponents *component = [calendar components:units fromDate: self];
  return [NSString stringWithFormat:@"%02d/%d",(component.month),component.year];
}

- (NSInteger)daysSinceDate:(NSDate*)toDateTime
{
  NSDate *fromDate;
  NSDate *toDate;
  
  [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
               interval:NULL forDate:self];
  [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
               interval:NULL forDate:toDateTime];
  
  NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                             fromDate:fromDate toDate:toDate options:0];
  
  return [difference day];
}


@end
