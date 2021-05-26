//
//  Hashify.h
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import <XcodeKit/XcodeKit.h>
#import "Extensions/NSMutableArray/NSMutableArray+Cast.h"
#import "Extensions/NSScanner/NSScanner+Scan.h"
#import "Extensions/NSArray/NSArray+Map.h"
#import "Extensions/NSArray/NSArray+Filter.h"
#import "Extensions/NSArray/NSArray+FlatMap.h"
#import "Extensions/NSArray/NSArray+Reduce.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hashify : NSObject

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer;
- (void)hashify;

@end

NS_ASSUME_NONNULL_END
