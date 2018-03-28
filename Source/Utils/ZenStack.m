//
//  ZenStack.m
//  Zen
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 Zen. All rights reserved.
//

#import "ZenStack.h"
#import "Singleton.h"

@interface ZenStack ()
{
    NSMutableArray *_stack;
}

@end


@implementation ZenStack

SINGLETON_FOR_CLASS(ZenStack);


- (id)init
{
    if (self = [super init]) {
        _stack = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(UIViewController *)controller
{
    [_stack addObject:controller];
}

- (void)pop:(UIViewController *)controller
{
    NSUInteger index = [_stack indexOfObject:controller];
    if (index != NSNotFound) {
        NSLog(@"index: %lu ", (long)index);
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(index, _stack.count - index)];
        [_stack removeObjectsAtIndexes:indexSet];
    }
}

@end
