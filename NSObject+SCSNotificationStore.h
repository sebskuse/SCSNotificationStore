//
//  NSObject+SCSNotificationStore.h
//
//  Created by Seb Skuse on 20/02/2013.
//  Copyright (c) 2013 Seb Skuse. All rights reserved.
//

#import "SCSNotificationStore.h"

@interface NSObject (SCSNotificationStore)

/**
 Return the notification store associated with this object.
 */
@property (atomic, strong, readonly) SCSNotificationStore *SCSNotificationStore;

@end
