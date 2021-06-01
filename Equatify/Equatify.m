//
//  Equatify.m
//  Equatify
//
//  Created by Даниил Храповицкий on 26.05.2021.
//

#import "Equatify.h"

@interface Equatify ()

@property XCSourceTextBuffer *buffer;

- (NSArray<NSString *> *)createNewLines;
- (NSArray<NSString *> *)createBody;
- (NSArray<NSString *> *)createContentWithType:(NSString *)type andBody:(NSArray<NSString *> *)body;

@end

@implementation Equatify

+ (NSString *)identifier {
    return @"Equatify";
}

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer {
    self = [super init];
    
    if (self) {
        _buffer = buffer;
    }
    
    return self;
}

- (void)perform {
    NSArray<NSString *> *newLines = [self createNewLines];
    
    NSLog(@"%@", newLines);
    
    [[[self buffer] lines] addObjectsFromArray:newLines];
}

- (NSArray<NSString *> *)createNewLines {
    NSString *type = [Processor getTypeFromBuffer:[self buffer]];
    NSArray<NSString *> *body = [self createBody];
    
    return [self createContentWithType:type andBody:body];
}

- (NSArray<NSString *> *)createBody {
    NSArray<NSString *> *variables = [Processor getVariablesFromBuffer:[self buffer]];
    NSString *indentation = [@"" stringByPaddingToLength:[[self buffer] indentationWidth] withString:@" " startingAtIndex:0];
    NSString *doubleIndentation = [@"" stringByPaddingToLength:2 * [[self buffer] indentationWidth] withString:@" " startingAtIndex:0];
    
    if ([variables count] == 0) {
        return [NSArray array];
    } else if ([variables count] == 1) {
        return [variables map:^id _Nonnull(id  _Nonnull obj) {
            return [indentation stringByAppendingString:[NSString stringWithFormat:@"return lhs.%@ == rhs.%@", obj, obj]];
        }];
    }
    
    NSMutableArray<NSMutableArray *> *enumerator = [NSMutableArray array];
    [variables enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [enumerator addObject:[NSMutableArray arrayWithObjects:@(idx), obj, nil]];
    }];
    
    return [enumerator map:^id _Nonnull(id  _Nonnull obj) {
        if ([(NSNumber *)[obj objectAtIndex:0] integerValue] == 0) {
            return [doubleIndentation stringByAppendingString:[NSString stringWithFormat:@"return lhs.%@ == rhs.%@ && ", [obj objectAtIndex:1], [obj objectAtIndex:1]]];
        } else if ([(NSNumber *)[obj objectAtIndex:0] integerValue] == [enumerator count] - 1) {
            return [NSString stringWithFormat:@"lhs.%@ == rhs.%@", [obj objectAtIndex:1], [obj objectAtIndex:1]];
        } else {
            return [NSString stringWithFormat:@"lhs.%@ == rhs.%@ && ", [obj objectAtIndex:1], [obj objectAtIndex:1]];
        }
    }];
}

- (NSArray<NSString *> *)createContentWithType:(NSString *)type andBody:(NSArray<NSString *> *)body {
    NSString *indentation = [@"" stringByPaddingToLength:[[self buffer] indentationWidth] withString:@" " startingAtIndex:0];
    NSString *extensionStart = [NSString stringWithFormat:@"extension %@: Equatable {", type];
    NSString *funcStart = [indentation stringByAppendingString:[NSString stringWithFormat:@"static func == (lhs: %@, rhs: %@) -> Bool {", type, type]];
    NSString *funcEnd = [indentation stringByAppendingString:@"}"];
    NSString *extensionEnd = @"}";
    NSString *reducedBody = [body reduce:@"" block:^id _Nonnull(id _Nonnull obj1, id _Nonnull obj2) {
        return [NSString stringWithFormat:@"%@%@", obj1, obj2];
    }];
    
    return [NSArray arrayWithObjects:@"", extensionStart, funcStart, reducedBody, funcEnd, extensionEnd, nil];
}

@end
