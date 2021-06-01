//
//  Hashify.h
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "Internal/Bridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hashify : NSObject <EquatifyProtocol>

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer;
- (void)perform;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
