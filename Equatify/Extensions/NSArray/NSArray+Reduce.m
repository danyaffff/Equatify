//
//  NSArray+Reduce.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "NSArray+Reduce.h"

@implementation NSArray (Reduce)

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2))block {
    __block id obj = initial;
    [self enumerateObjectsUsingBlock:^(id _obj, NSUInteger idx, BOOL *stop) {
        obj = block(obj, _obj);
    }];
    return obj;
}

@end
