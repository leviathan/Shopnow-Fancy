//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFDefaultDataSource.h"


@implementation SNFDataSourcePackage

- (instancetype)initWith:(id)dataSourceReference error:(NSError *)error {
    self = [super init];
    if (self) {
        self.dataSourceReference = dataSourceReference;
        self.error = error;
    }
    return self;
}

@end


//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFDefaultDataSource ()

@property(nonatomic, strong, readwrite) NSHashTable *delegates;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFDefaultDataSource

#pragma mark - Delegates

- (NSHashTable *)delegates {
    if (_delegates == nil) {
        _delegates = [NSHashTable weakObjectsHashTable]; // new hash table for storing weak references to its contents
    }
    return _delegates;
}

- (void)addDelegate:(id <SNFDefaultDataSourceDelegate>)delegate {
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id <SNFDefaultDataSourceDelegate>)delegate {
    [self.delegates removeObject:delegate];
}

- (void)performSelectorOnDelegates:(SEL)selector {

    [[self.delegates allObjects] enumerateObjectsUsingBlock:^(id <SNFDefaultDataSourceDelegate> delegate, NSUInteger idx, BOOL *stop) {
        if ([delegate respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector];
#pragma clang diagnostic pop

        }
    }];
}

- (void)performSelectorOnDelegates:(SEL)selector object:(id)anObject {

    [[self.delegates allObjects] enumerateObjectsUsingBlock:^(id <SNFDefaultDataSourceDelegate> delegate, NSUInteger idx, BOOL *stop) {
        if ([delegate respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector withObject:anObject];
#pragma clang diagnostic pop
        }
    }];
}

#pragma mark - Updating

- (void)update:(BOOL)forceUpdate {
    // let subclasses handle this
}

#pragma mark - Data

- (id)dataItems {
    NSAssert(NO, @"Method 'forceUpdate' not implemented by TINMasterDataSource - use 'updateMasterDataForType:' instead");
    return @[];
}

@end