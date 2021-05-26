//
//  NSArray+Filter.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Filter)

- (NSArray *)filter:(BOOL (^)(id obj))block;

@end

NS_ASSUME_NONNULL_END
