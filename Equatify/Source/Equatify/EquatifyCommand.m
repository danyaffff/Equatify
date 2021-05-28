//
//  SourceEditorCommand.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "EquatifyCommand.h"
#import "Equatify.h"

@implementation EquatifyCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    
    Equatify *equatify = [[Equatify new] initWithBuffer:[invocation buffer]];
    
    @try {
        [equatify equatify];
        completionHandler(nil);
    } @catch (NSException *exception) {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        [info setValue:exception.reason forKey:@"reason"];
        NSError *error = [[NSError new] initWithDomain:@"danyaffff.Equatify" code:42 userInfo:info];
        completionHandler(error);
    }
}
@end
