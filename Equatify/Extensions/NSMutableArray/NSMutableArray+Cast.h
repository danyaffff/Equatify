//
//  NSMutableArray+Cast.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Cast)

- (NSString *(^)(NSInteger))castAtIndexToNSString;

@end

NS_ASSUME_NONNULL_END
