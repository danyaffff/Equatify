//
//  NSString+Checker.m
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "NSString+Checker.h"
#import "NSScanner+Scan.h"

@implementation NSString (Checker)

- (BOOL)isCorrectString {
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@" *\n" options:0 error:nil];
    NSRange range = NSMakeRange(0, [self length]);
    NSString *replaced = [expression stringByReplacingMatchesInString:self options:0 range:range withTemplate:@""];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSString *stringWithoutComments = [scanner scanUpToString:@"//"];
    [stringWithoutComments stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    return replaced.length != 0 && [stringWithoutComments isNotEqualTo:NULL] && ![stringWithoutComments containsString:@"func "] && ![stringWithoutComments containsString:@"{"] && ![stringWithoutComments containsString:@"}"] && ![stringWithoutComments containsString:@"print"] && ([stringWithoutComments containsString:@"var "] || [stringWithoutComments containsString:@"let "]);
}

@end
