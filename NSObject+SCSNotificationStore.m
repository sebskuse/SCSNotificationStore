//
//  NSObject+SCSNotificationStore.m
//
//  Created by Seb Skuse on 20/02/2013.
//  Copyright (c) 2013 Seb Skuse. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+SCSNotificationStore.h"

static void *SCSNotificationStoreObject = &SCSNotificationStoreObject;

@implementation NSObject (SCSNotificationStore)

- (SCSNotificationStore *)SCSNotificationStore {
    @synchronized(self) {
        SCSNotificationStore *store = objc_getAssociatedObject(self, SCSNotificationStoreObject);
        
        if (store == nil) {
            store = [[SCSNotificationStore alloc] init];
            objc_setAssociatedObject(self, SCSNotificationStoreObject, store, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        return store;
    }
}

@end