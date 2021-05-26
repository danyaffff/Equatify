//
//  NSArray+Cast.h
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Cast)

- (NSString * _Nonnull (^)(NSInteger))castAtIndexToClass:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
