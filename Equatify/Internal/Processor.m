//
//  Processor.m
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "Processor.h"

@implementation Processor

+ (NSString *)getTypeFromBuffer:(XCSourceTextBuffer *)buffer {
    if ([[buffer selections] firstObject] == nil) {
        @throw [NSException exceptionWithName:@"No selection!" reason:@"There is no selected area!" userInfo:nil];
    }
    
    XCSourceTextRange *selection = [[buffer selections] firstObject];
    NSInteger line = [selection start].line;
    NSString *firstLine = [[buffer lines] castAtIndexToNSString](line);
    
    return [NSScanner scanTypeNameInString:firstLine];
}


+ (NSArray<NSString *> *)getVariablesFromBuffer:(XCSourceTextBuffer *)buffer {
    if ([[buffer selections] firstObject] == nil) {
        @throw [NSException exceptionWithName:@"No selection!" reason:@"There is no selected area!" userInfo:nil];
    }
    
    XCSourceTextRange *selection = [[buffer selections] firstObject];
    NSInteger startLineIndex = [selection start].line + 1;
    NSInteger endLineIndex = [selection end].line;
    
    
    NSMutableArray *selectionRange = [NSMutableArray array];
    for (NSInteger i = startLineIndex; i < endLineIndex; i++) {
        [selectionRange addObject:@(i)];
    }
    
    return [[[selectionRange map:^id _Nonnull(id  _Nonnull obj) {
        return [[buffer lines] castAtIndexToNSString]([obj integerValue]);
    }] filter:^BOOL(id  _Nonnull obj) {
        return [obj isCorrectString];
    }] flatMap:^id _Nonnull(id  _Nonnull obj) {
        return [NSScanner scanVariablesInString:obj];
    }];
}

@end
