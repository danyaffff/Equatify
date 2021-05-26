//
//  Equatify.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "Internal/Bridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface Equatify : NSObject

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer;
- (void)equatify;

@end

NS_ASSUME_NONNULL_END
