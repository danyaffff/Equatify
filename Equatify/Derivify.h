//
//  Derivify.h
//  Equatify
//
//  Created by Даниил Храповицкий on 01.06.2021.
//

#import "Internal/Bridge.h"
#import "Internal/Script.h"

NS_ASSUME_NONNULL_BEGIN

@interface Derivify : NSObject <EquatifyProtocol>

- (void)perform;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
