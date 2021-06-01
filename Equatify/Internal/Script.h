//
//  Script.h
//  Equatify
//
//  Created by Даниил Храповицкий on 01.06.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum ScriptType : NSInteger {
    OpenDerivedData = 0
} ScriptType;

@interface Script : NSObject

+ (void)run:(ScriptType)script;

@end

NS_ASSUME_NONNULL_END
