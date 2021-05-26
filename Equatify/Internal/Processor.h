//
//  Processor.h
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "Bridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface Processor : NSObject

+ (NSString *)getTypeFromBuffer:(XCSourceTextBuffer *)buffer;
+ (NSArray<NSString *> *)getVariablesFromBuffer:(XCSourceTextBuffer *)buffer;

@end

NS_ASSUME_NONNULL_END
