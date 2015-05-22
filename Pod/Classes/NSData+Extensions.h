//  Created by Santosh on 3/7/13.
//  Copyright (c) 2013 Fareportal. All rights reserved.

@interface NSData (Extensions)
-(NSData *)AES256EncryptWithKey:(NSString *)key;
-(NSData *)AES256DecryptWithKey:(NSString *)key;
+(NSData *) decodeBase64WithString:(NSString *)strBase64;
-(NSString *) encodeBase64WithData;
@end
