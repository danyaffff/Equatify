//
//  NSMutableArray+Cast.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "NSMutableArray+Cast.h"

@implementation NSMutableArray (Cast)

- (NSString * _Nonnull (^)(NSInteger))castAtIndexToNSString {
    return ^ (NSInteger index) {
        if ([self[index] isKindOfClass:[NSString class]]) {
            return (NSString *)self[index];
        }
        @throw [NSException exceptionWithName:@"Cast error" reason:@"Can't cast to NSString" userInfo:nil];
    };
}

@end
