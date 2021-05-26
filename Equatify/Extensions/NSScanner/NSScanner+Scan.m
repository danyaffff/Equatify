//
//  NSScanner+Scan.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "NSScanner+Scan.h"

@implementation NSScanner (Scan)

+ (NSString *)scanTypeNameInString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSArray <NSString *> *accessModifiers = [NSArray arrayWithObjects:@"open", @"internal", @"private", @"fileprivate", nil];
    
    [accessModifiers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *_ = [scanner scanString:obj];
        #pragma unused(_)
    }];
    
    if (![scanner scanString:@"class" intoString:nil] && ![scanner scanString:@"struct" intoString:nil]) {
        @throw [NSException exceptionWithName:@"Wrong selection" reason:@"\"class\" or \"structure\" not found!" userInfo:nil];
    }
    
    NSString *typeName = [scanner scanUpToString:@"{"];
    
    if (typeName == nil) {
        @throw [NSException exceptionWithName:@"Wrong selection" reason:@"\"{\" wasn't found!" userInfo:nil];
    }
    
    if ([[NSScanner scannerWithString:typeName] scanUpToString:@":"]) {
        typeName = [[NSScanner scannerWithString:typeName] scanUpToString:@":"];
    }
    
    return [typeName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
}

+ (NSString *)scanVariablesInString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSArray <NSString *> *accessModifiers = [NSArray arrayWithObjects:@"open", @"internal", @"private", @"fileprivate", nil];
    BOOL isWeak = [scanner scanString:@"weak" intoString:nil]; // weak private let...
    
    for (NSString *modifier in accessModifiers) {
        if ([scanner scanString:modifier intoString:nil]) {
            break;
        }
    }
    
    isWeak = isWeak || [scanner scanString:@"weak" intoString:nil];  // private weak let...
    
    if (![scanner scanString:@"let" intoString:nil] && ![scanner scanString:@"var" intoString:nil]) {
        NSLog(@"%@", [scanner string]);
        return nil;
    }
    
    NSString *variable = [scanner scanUpToString:@":"];
    
    if ([variable containsString:@"="]) {
        variable = [[variable componentsSeparatedByString:@"="] firstObject];
        variable = [variable stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    }
    
    return variable;
}

- (NSString *)scanString:(NSString *)string {
    NSString *value = @"";
    
    if ([self scanString:string intoString:&value]) {
        return value;
    }
    
    return nil;
}

- (NSString *)scanUpToString:(NSString *)string {
    NSString *value = @"";
    
    if ([self scanUpToString:string intoString:&value]) {
        return value;
    }
    
    return nil;
}

@end
