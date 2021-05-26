//
//  Equatify.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>
#import "Extensions/NSMutableArray/NSMutableArray+Cast.h"
#import "Extensions/NSScanner/NSScanner+Scan.h"
#import "Extensions/NSArray/NSArray+Map.h"
#import "Extensions/NSArray/NSArray+Filter.h"
#import "Extensions/NSArray/NSArray+FlatMap.h"
#import "Extensions/NSArray/NSArray+Reduce.h"

NS_ASSUME_NONNULL_BEGIN

@interface Equatify : NSObject

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer;
- (void)equatify;

@end

NS_ASSUME_NONNULL_END
