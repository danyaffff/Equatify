//
//  Derivify.m
//  Equatify
//
//  Created by Даниил Храповицкий on 01.06.2021.
//

#import "Derivify.h"

@implementation Derivify

- (void)perform {
    [Script run:OpenDerivedData];
}

+ (NSString *)identifier {
    return @"Derivify";
}

@end
