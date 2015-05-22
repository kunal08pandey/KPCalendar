//  Created by Santosh on 3/7/13.
//  Copyright (c) 2013 Fareportal. All rights reserved.

#import <CommonCrypto/CommonCrypto.h>

#import "NSString+Extensions.h"
#import "NSData+Extensions.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@implementation NSString (Extensions)

+ (BOOL) isEmpty: (NSString *) str {
    return [[str trim] length] == 0;
}

+ (NSString *) generateUUID {

    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease (theUUID);
    return (__bridge NSString *)string ;
}

-(NSString *) search:(NSString *)regex replace:(NSString *)s {
    NSRegularExpression *r = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
    NSString *output = [r stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:s];
    return output;
}

-(BOOL) containsString: (NSString *) str {
    NSRange range = [self rangeOfString: str];
    return range.location != NSNotFound;
}

-(NSString *) removeAllSpecialCharacter {
  return [self removeMatchedCharacters:@"-/:;()$&@\".,?!\\\'[]{}#%^*+=_|~<>€£¥•."];
}

-(NSString *) removeMatchedCharacters:(NSString *) s{
  NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:s];
  return [self stringByTrimmingCharactersInSet:chs];
}


-(BOOL) containStringArray:(NSArray *) array {
    if(self == nil || [array count]<=0)
        return FALSE;
    
    BOOL hasFound = NO;

    for(int i=0; i<[array count]; i++) {
        if([self rangeOfString:[array objectAtIndex:i] options:NSCaseInsensitiveSearch].location == NSNotFound) {
            return false;
        }
        else {
            hasFound = YES;
        }
    }
    
    if(hasFound) return true;
    
    return false;
}


-(BOOL) isMatch:(NSString *) regex {
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regex];
    return [test evaluateWithObject: self];
}

-(NSString *) htmlEncode {
    NSString *output = [self search:@"\\&" replace:@"&amp"];
    output = [output search:@"<" replace:@"&lt;"];
    output = [output search:@">" replace:@"&gt;"];
    output = [output search:@"'" replace:@"&apos;"];
    output = [output search:@"\"" replace:@"&quot;"];
    return output;
}

-(NSString *) stripHtml {
  NSRange range;
  NSString *string = [self copy];
  while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    string = [string stringByReplacingCharactersInRange:range withString:@""];
  return string;
}

-(BOOL) isEmailAddress {
    return [self isMatch:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

-(NSString *) trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(BOOL) insensitiveCompare:(NSString *)str{
    if ([self caseInsensitiveCompare:str] == NSOrderedSame)
        return YES;
    else
        return NO;
}

+(NSString *) formatDateDifference:(NSDate *) fDate lDate:(NSDate *) lDate {

    NSInteger layover = [fDate timeIntervalSinceDate: lDate] / 60;
    NSInteger minutes = layover % 60;
    NSInteger hours = layover / 60;
    NSString *hoursStr = [NSString stringWithFormat:@"%02dh", hours];
    NSString *minutesStr = [NSString stringWithFormat:@"%02dm", minutes];
    return [NSString stringWithFormat:@"%@ %@",hoursStr,minutesStr];
}

-(NSString *) encryptWithKey:(NSString *) key {

    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero (keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)

    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [self length];

    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted] encodeBase64WithData];
    }

    free(buffer); //free the buffer;
    return nil;
}

-(CGSize) calculateSize:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    return [self calculateSize:font maxWidth:width maxHeight:height lineBreakMode:NSLineBreakByWordWrapping];
}

-(CGSize) calculateSize: (UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height lineBreakMode:(NSInteger) linebreakMode {

    if(width == 0) {
        width = MAXFLOAT;
    }
    if(height == 0) {
        height = MAXFLOAT;
    }

    CGSize maximumLabelSize = CGSizeMake(width,height);

    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font}];
        CGSize boundingBox = [attributedText boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        //CGSize boundingBox = [txtToCalculate sizeWithAttributes: @{NSFontAttributeName:font}];
        return CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));

    }
    else{
        return [self sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:linebreakMode];
    }
}

-(NSString *)getSubStringTillString:(NSString *)tillString
{
  NSString *string=self;
  if ([self rangeOfString:tillString].location!=NSNotFound) {
    string   = [self substringWithRange:NSMakeRange(0, [self rangeOfString:tillString].location)];
  }
  return string;
}



-(NSString *) stringFromMD5 {
    
    if(self == nil || [self length] == 0)
        return nil;

    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString ;
}
@end
