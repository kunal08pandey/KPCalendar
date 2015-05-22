//  Created by Santosh on 3/7/13.
//  Copyright (c) 2013 Fareportal. All rights reserved.

@interface NSString (Extensions)
+(BOOL) isEmpty: (NSString *) str;
+(NSString *) generateUUID;


-(NSString *) search:(NSString *) regex replace:(NSString *) s;
-(BOOL) containsString: (NSString *) str;
-(NSString *) removeAllSpecialCharacter;
-(NSString *) removeMatchedCharacters:(NSString *) s;
-(BOOL) containStringArray:(NSArray *) array;
-(BOOL) isMatch:(NSString *) regex;
-(NSString *) htmlEncode;
-(NSString *) stripHtml;
-(BOOL) isEmailAddress;
-(NSString *) trim;
-(BOOL)insensitiveCompare:(NSString *)str;
-(NSString *) encryptWithKey:(NSString *) key;
+(NSString *) formatDateDifference:(NSDate *) fDate lDate:(NSDate *) lDate;
-(CGSize) calculateSize:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;
-(CGSize) calculateSize:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height lineBreakMode:(NSInteger) linebreakMode;
-(NSString *) stringFromMD5;
-(NSString *)getSubStringTillString:(NSString *)tillString;

@end
