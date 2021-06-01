//
//  Equatify.h
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "Internal/Bridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface Equatify : NSObject <EquatifyProtocol>

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer;
- (void)perform;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
