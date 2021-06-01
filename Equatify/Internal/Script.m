//
//  Script.m
//  Equatify
//
//  Created by Даниил Храповицкий on 01.06.2021.
//

#import "Script.h"
#import <Carbon/Carbon.h>
#define scriptToString(x) (x == 0 ? "openDerivedDataFolder" : "It will be the reason of the error")

@interface Script ()

+ (NSAppleEventDescriptor *)eventDescriptor:(ScriptType)script;

@end

@implementation Script

+ (void)run:(ScriptType)script {
    NSError *error;
    
    switch (script) {
        case 0: {
            NSURL *sourceScriptFileURL = [[NSBundle mainBundle] URLForResource:@"EquatifyScript" withExtension:@"scpt"];
            NSURL *destinationScriptFileURL = [[[[NSFileManager defaultManager] URLForDirectory:NSApplicationScriptsDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error] URLByAppendingPathComponent:@"EquatifyScript"] URLByAppendingPathExtension:@"scpt"];
            
            if (error) {
                NSLog(@"error with destination: %@", error.localizedDescription);
            }
            
            if (![destinationScriptFileURL checkResourceIsReachableAndReturnError:&error]) {
                if (error) {
                    NSLog(@"file was unreacheable: %@", error.localizedDescription);
                }
                [[NSFileManager defaultManager] copyItemAtURL:sourceScriptFileURL toURL:destinationScriptFileURL error:&error];
                
                if (error) {
                    NSLog(@"error with copy: %@", error.localizedDescription);
                }
            }
            
            NSUserAppleScriptTask *task = [[NSUserAppleScriptTask new] initWithURL:destinationScriptFileURL error:&error];
            
            if (error) {
                NSLog(@"error with creating task: %@", error.localizedDescription);
            }
            
            NSAppleEventDescriptor *event = [Script eventDescriptor:script];
            [task executeWithAppleEvent:event completionHandler:^(NSAppleEventDescriptor * _Nullable result, NSError * _Nullable error) {
                NSLog(@"Completion");
                if (error) {
                    NSLog(@"!!!SOS!!! %@", [error localizedDescription]);
                }
            }];
            
            break;
        }
            
        default:
            break;
    }
}

+ (NSAppleEventDescriptor *)eventDescriptor:(ScriptType)script {
    ProcessSerialNumber processSerialNumber = { (UInt32)0, (UInt32)kCurrentProcess };
    NSAppleEventDescriptor *target = [[NSAppleEventDescriptor new] initWithDescriptorType:(DescType)typeProcessSerialNumber bytes:&processSerialNumber length:sizeof(ProcessSerialNumber)];
    NSAppleEventDescriptor *event = [[NSAppleEventDescriptor new] initWithEventClass:(AEEventClass)kASAppleScriptSuite eventID:(AEEventID)kASSubroutineEvent targetDescriptor:target returnID:(AEReturnID)kAutoGenerateReturnID transactionID:(AETransactionID)kAnyTransactionID];
    NSAppleEventDescriptor *function = [NSAppleEventDescriptor descriptorWithString:@scriptToString(script)];
    [event setParamDescriptor:function forKeyword:(AEKeyword)(keyASSubroutineName)];
    return event;
}

@end
