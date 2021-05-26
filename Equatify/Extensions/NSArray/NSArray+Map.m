//
//  NSArray+Map.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)
- (NSArray *)map:(id (^)(id obj))block {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mutableArray addObject:block(obj)];
    }];
    
    return [mutableArray copy];
}
@end
