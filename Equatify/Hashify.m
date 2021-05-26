//
//  Hashify.m
//  Equatify
//
//  Created by Даниил Храповицкий on 27.05.2021.
//

#import "Hashify.h"

@interface Hashify ()

@property XCSourceTextBuffer *buffer;

- (NSArray<NSString *> *)createNewLines;
- (NSArray<NSString *> *)createBody;
- (NSArray<NSString *> *)createContentWithType:(NSString *)type andBody:(NSArray<NSString *> *)body;

@end

@implementation Hashify

- (instancetype)initWithBuffer:(XCSourceTextBuffer *)buffer {
    self = [super init];
    
    if (self) {
        _buffer = buffer;
    }
    
    return self;
}

- (void)hashify {
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
    NSString *doubleIndentation = [@"" stringByPaddingToLength:2 * [[self buffer] indentationWidth] withString:@" " startingAtIndex:0];
    
    if ([variables count] == 0) {
        return [NSArray array];
    }
    
    return [variables map:^id _Nonnull(id  _Nonnull obj) {
        return [doubleIndentation stringByAppendingString:[NSString stringWithFormat:@"hasher.combine(%@)", obj]];
    }];
}

- (NSArray<NSString *> *)createContentWithType:(NSString *)type andBody:(NSArray<NSString *> *)body {
    NSString *indentation = [@"" stringByPaddingToLength:[[self buffer] indentationWidth] withString:@" " startingAtIndex:0];
    NSString *extensionStart = [NSString stringWithFormat:@"extension %@: Hashable {", type];
    NSString *funcStart = [indentation stringByAppendingString:@"func hash(into hasher: inout Hasher) {"];
    NSString *funcEnd = [indentation stringByAppendingString:@"}"];
    NSString *extensionEnd = @"}";
    
    NSMutableArray<NSString *> *extension = [NSMutableArray arrayWithObjects:@"", extensionStart, funcStart, funcEnd, extensionEnd, nil];
    
    [body enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [extension insertObject:obj atIndex:idx + 3];
    }];
    
    return extension;
}

- (BOOL)isCorrectString:(NSString *)string {
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@" *\n" options:0 error:nil];
    NSRange range = NSMakeRange(0, string.length);
    NSString *replaced = [expression stringByReplacingMatchesInString:string options:0 range:range withTemplate:@""];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSString *stringWithoutComments = [scanner scanUpToString:@"//"];
    [stringWithoutComments stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    return replaced.length != 0 && [stringWithoutComments isNotEqualTo:NULL] && ![stringWithoutComments containsString:@"func "] && ![stringWithoutComments containsString:@"{"] && ![stringWithoutComments containsString:@"}"] && ![stringWithoutComments containsString:@"print"] && ([stringWithoutComments containsString:@"var "] || [stringWithoutComments containsString:@"let "]);
}

@end
