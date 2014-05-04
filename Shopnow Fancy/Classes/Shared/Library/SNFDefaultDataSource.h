//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

@interface SNFDataSourcePackage : NSObject

@property(nonatomic, strong) id dataSourceReference;
@property(nonatomic, strong) NSError *error;

- (instancetype)initWith:(id)dataSourceReference error:(NSError *)error;

@end


/**
* The data-source delegate used to handle messaging between data-source and interested parties.
*/
@protocol SNFDefaultDataSourceDelegate <NSObject>

@optional

- (void)didUpdateDataSourceSuccessfully:(SNFDataSourcePackage *)package;

- (void)updateDidFailWith:(SNFDataSourcePackage *)package;

@end


/**
* The base class of all data sources.
*/
@interface SNFDefaultDataSource : NSObject

@property(nonatomic, strong, readonly) NSHashTable *delegates;

/**
* Adds a zeroing-weak referenced delegate to the list of delegates.
*
* Note: when the specified delegate object is dealloc'd, then it will
* be automatically removed from the delegates list.
*/
- (void)addDelegate:(id <SNFDefaultDataSourceDelegate>)delegate;

- (void)removeDelegate:(id <SNFDefaultDataSourceDelegate>)delegate;

- (void)performSelectorOnDelegates:(SEL)selector;

- (void)performSelectorOnDelegates:(SEL)selector object:(id)object;

/**
* Updates the data source's data.
*
* Note: the default implementation does nothing. Subclasses should implement this.
*
* @param forceUpdate YES - no cached data should be used; NO - cached data may be used.
*/
- (void)update:(BOOL)forceUpdate;

/**
* Returns the data items currently managed by this data-source.
*
* The list is empty, if the data-source has not been updated yet.
*
* The default implementation returns an empty array, thus subclasses should overwrite this.
*/
- (NSArray *)dataItems;

@end
