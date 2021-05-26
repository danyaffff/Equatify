//
//  NSArray+Reduce.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Reduce)

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2))block;

@end

NS_ASSUME_NONNULL_END
