//
//  NSScanner+Scan.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import <Foundation/Foundation.h>

@interface NSScanner (Scan)

+ (NSString * _Nonnull)scanTypeNameInString:(NSString * _Nonnull)string;
+ (NSString * _Nullable)scanVariablesInString:(NSString * _Nonnull)string;
- (NSString * _Nullable)scanString:(NSString * _Nonnull)string;
- (NSString * _Nullable)scanUpToString:(NSString * _Nonnull)string;
@end
