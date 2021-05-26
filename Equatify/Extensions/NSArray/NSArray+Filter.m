//
//  NSArray+Filter.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "NSArray+Filter.h"

@implementation NSArray (Filter)

- (NSArray *)filter:(BOOL (^)(id obj))block {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj) == YES) {
            [mutableArray addObject:obj];
        }
    }];
    
    return [mutableArray copy];
}

@end
