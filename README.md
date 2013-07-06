SCSNotificationStore
====================
SCSNotificationStore is a tiny library that provides a mechanism for any Objective-C object to register as a listener for notifications using a block callback.

Why not just use the usingBlock method on NSNotificationCenter?
------------------------
Registering for notifications using ```addObserverForName:object:queue:usingBlock:``` under ARC requires you to keep a reference to every notification registered so you can remove it later on. Not removing it before the listener is deallocated causes a leak. SCSNotificationStore automatically handles removing observers when the target gets deallocated.

Okay, i'm interested. What else?
------------------------
The method on ```NSNotificationCenter``` is fairly verbose. You don't always want to provide an object. You don't always want to specify a queue. SCSNotificationStore has shortcut methods allowing you to omit these arguments, defaulting to a nil object and the main queue.

You sometimes may want to register for multiple notifications with the same callback. SCSNotificationStore provides this with its ```addObserversForNames:object:queue:usingBlock:``` method. As above there are shortened methods that omit the object and queue paramater, too.

Can I remove an observer on an object before its deallocated?
------------------------
SCSNotificationStore provides ```removeObserver:``` and ```removeObserversForName:``` methods which will either remove observers returned from the ```addObserver..``` methods or remove observers for a particular notification name.

Additionally, SCSNotificationStore supports subscripting, so you can always get listeners registered for a particular event name using: 
```objective-c
self.SCSNotificationStore[SCSMyEventName]
```

How do I use it?
------------------------

1. Add all the .h and .m files to your project.
2. In your project .pch file ```#import "NSObject+SCSNotificationStore.h"```
3. High-five the nearest colleague.

**Important:** Remember to never reference self inside the block. Use a weak reference (see example below). 


```objective-c
__weak __typeof(&*self)weakSelf = self;
    [self.SCSNotificationStore addObserverForName:SCSExampleNotification usingBlock:^(NSNotification *notification) {
        if ([notification.userInfo[@"something"] isEqualToString:@"someText"]) {
            [weakSelf updateSomething];
        }
    }];
```
