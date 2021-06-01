//
//  SourceEditorCommand.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "EquatifyCommand.h"
#import "Equatify.h"
#import "Hashify.h"

@implementation EquatifyCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    id <EquatifyProtocol> equatify;
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    
    if ([[invocation commandIdentifier] isEqualToString:[bundleID stringByAppendingString:[@"." stringByAppendingString:[Equatify identifier]]]]) {
        equatify = [[Equatify new] initWithBuffer:[invocation buffer]];
    } else if ([[invocation commandIdentifier] isEqualToString:[bundleID stringByAppendingString:[@"." stringByAppendingString:[Hashify identifier]]]]) {
        equatify = [[Hashify new] initWithBuffer:[invocation buffer]];
    } else {
        @throw [NSException exceptionWithName:@"Command not found" reason:[NSString stringWithFormat:@"Command with identifier %@ not found, expected %@ or %@", [invocation commandIdentifier], [bundleID stringByAppendingString:[Equatify identifier]], [bundleID stringByAppendingString:[Hashify identifier]]] userInfo:nil];
    }
    
    @try {
        [equatify perform];
        completionHandler(nil);
    } @catch (NSException *exception) {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        [info setValue:exception.reason forKey:@"reason"];
        NSError *error = [[NSError new] initWithDomain:@"danyaffff.Equatify" code:42 userInfo:info];
        completionHandler(error);
    }
}

@end
