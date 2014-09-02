//
//  SCSNotificationStore.m
//
//  Created by Seb Skuse on 20/02/2013.
//  Copyright (c) 2013 Seb Skuse. All rights reserved.
//

#import "SCSNotificationStore.h"

@interface SCSNotificationStore ()
@property (atomic, strong) NSMutableDictionary *observers;
@end

@implementation SCSNotificationStore

- (id)init {
    if (self = [super init]) {
        _observers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)addObserverForName:(NSString *)name usingBlock:(SCSNotificationStoreBlock)block {
    return [self addObserverForName:name object:nil queue:NSOperationQueue.mainQueue usingBlock:block];
}

- (id)addObserverForName:(NSString *)name queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block {
    return [self addObserverForName:name object:nil queue:queue usingBlock:block];
}

- (id)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block {
    id notification = [[NSNotificationCenter defaultCenter] addObserverForName:name object:obj queue:queue usingBlock:block];
    
    NSMutableArray *observers = self.observers[name];
    
    if (observers == nil) {
        observers = [[NSMutableArray alloc] init];
    }
    
    [observers addObject:notification];
    
    self.observers[name] = observers;
    
    return notification;
}

- (NSArray *)addObserversForNames:(NSArray *)names usingBlock:(SCSNotificationStoreBlock)block {
    return [self addObserversForNames:names object:nil queue:NSOperationQueue.mainQueue usingBlock:block];
}

- (NSArray *)addObserversForNames:(NSArray *)names queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block {
    return [self addObserversForNames:names object:nil queue:queue usingBlock:block];
}

- (NSArray *)addObserversForNames:(NSArray *)names object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(SCSNotificationStoreBlock)block {
    NSMutableArray *observers = [NSMutableArray arrayWithCapacity:names.count];
    [names enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        [observers addObject:[self addObserverForName:name object:obj queue:queue usingBlock:block]];
    }];
    return observers;
}

- (id)objectForKeyedSubscript:(id)aKey {
    return self.observers[aKey];
}

- (void)removeObserver:(id)observer {
    @synchronized(self.observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
        
        for (NSString *observerName in self.observers) {
            [self.observers[observerName] removeObject:observer];
        }
    }
}

- (void)removeObserversForName:(NSString *)name {
    @synchronized(self.observers) {
        if ([self.observers.allKeys containsObject:name]) {
            [self.observers[name] enumerateObjectsUsingBlock:^(id observer, NSUInteger idx, BOOL *stop) {
                [[NSNotificationCenter defaultCenter] removeObserver:observer];
            }];
            
            [self.observers[name] removeAllObjects];
        }
    }
}

- (void)dealloc {
    NSArray *allObservers = [_observers.allValues valueForKeyPath:@"@unionOfArrays.self"];
    for (id observer in allObservers) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
}

@end
