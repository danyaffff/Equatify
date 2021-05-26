//
//  NSArray+Cast.m
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "NSArray+Cast.h"
@implementation NSArray (Cast)

- (NSString * _Nonnull (^)(NSInteger))castAtIndexToClass:(Class)aClass {
    return ^(NSInteger index) {
        if ([self[index] isKindOfClass:aClass]) {
            return (NSString *)self[index];
        }
        @throw [NSException exceptionWithName:@"Cast error" reason:[NSString stringWithFormat:@"Can't cast to %@", aClass] userInfo:nil];
    };
}

@end
