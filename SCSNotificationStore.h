//
//  SCSNotificationStore.h
//
//  Created by Seb Skuse on 20/02/2013.
//  Copyright (c) 2013 Seb Skuse. All rights reserved.
//

@import Foundation;

typedef void(^SCSNotificationStoreBlock)(NSNotification *notification);

/**
 You do not need to store or remove the notification objects
 externally when using this class. This is done automatically.
 Return values are provided to allow you to remove observers
 before the owner of this object gets deallocated using the
 removeObserver: or removeObsersForName: methods on this class.
 */
@interface SCSNotificationStore : NSObject

/**
 Add an observer for the specified notification name on the main queue with
 a nil object with the specified callback block.
 @param name The name of the notification.
 @param block The callback block to use.
 @return The resulting notification object.
 */
- (id)addObserverForName:(NSString *)name usingBlock:(SCSNotificationStoreBlock)block;

/**
 Add an observer for the specified notification name, specified queue
 with a nil object and the specified callback block.
 @param name The name of the notification.
 @param queue The queue to add the notification listener to.
 @param block The callback block to use.
 @return The resulting notification object.
 */
- (id)addObserverForName:(NSString *)name queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block;

/**
 Add an observer for the specified name with the specified object on the specified queue
 and the specified callback block.
 @param name The name of the notification.
 @param obj The object to use.
 @param queue The queue to add the notification listener to.
 @param block The callback block to use.
 @return The resulting notification object.
 */
- (id)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block;

/**
 Add an observer for each of the specified notification names on the main queue with
 a nil object with the specified callback block.
 @param names Array of notification names to observe.
 @param block The callback block to use.
 @return The resulting notification objects.
 */
- (NSArray *)addObserversForNames:(NSArray *)names usingBlock:(SCSNotificationStoreBlock)block;

/**
 Add an observer for each of the specified notification names on the specified queue with
 a nil object and the specified callback block.
 @param names Array of the names of the notifications to observe.
 @param queue The queue to add the notification listener to.
 @param block The callback block to use.
 @return The resulting notification objects.
 */
- (NSArray *)addObserversForNames:(NSArray *)names queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block;

/**
 Add an observer for each of the specified notification names on the specified queue with
 a nil object with the specified callback block.
 @param names Array of the names of the notifications to observe.
 @param obj The object to use.
 @param queue The queue to add the notification listener to.
 @param block The callback block to use.
 @return The resulting notification objects.
 */
- (NSArray *)addObserversForNames:(NSArray *)names object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block;

/**
 Subscript access to the notification dictionary.
 @return Array of notification objects for given key name.
 */
- (id)objectForKeyedSubscript:(id)aKey;

/**
 Remove an observer from NotificationCenter and SCSNotificationStore.
 @param observer The observer object to remove.
 */
- (void)removeObserver:(id)observer;

/**
 Remove all observers from NotificationCenter and SCSNotificationStore
 for a specific notification name.
 @param name Name of the notification.
 */
- (void)removeObserversForName:(NSString *)name;

@end
