//
//  HashifyCommand.m
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "HashifyCommand.h"

@implementation HashifyCommand

- (void)performCommandWithInvocation:(nonnull XCSourceEditorCommandInvocation *)invocation completionHandler:(nonnull void (^)(NSError * _Nullable))completionHandler { 
    Hashify *hashify = [[Hashify new] initWithBuffer:[invocation buffer]];
    
    @try {
        [hashify hashify];
        completionHandler(nil);
    } @catch (NSException *exception) {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        [info setValue:exception.reason forKey:@"reason"];
        NSError *error = [[NSError new] initWithDomain:@"danyaffff.Hashify" code:42 userInfo:info];
        completionHandler(error);
    }
}

@end
