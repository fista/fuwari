//
//  WSAppDelegate.h
//  music
//
//  Created by tatsuya fujii on 2013/11/11.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface WSAppDelegate : UIResponder <UIApplicationDelegate>
{
    UIBackgroundTaskIdentifier bgTask;
    NSTimer *timer;
}

@property (strong, nonatomic) UIWindow *window;

@end
