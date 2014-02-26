//
//  WSAppDelegate.m
//  music
//
//  Created by tatsuya fujii on 2013/11/11.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import "WSAppDelegate.h"

@implementation WSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   // [[UIApplication sharedApplication] setKeepAliveTimeout:600.0 handler:^{[self checkServer];}];
#warning あとでみる
    //[self upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if ([timer isValid]) {
        [timer invalidate];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)upload {
    UIApplication  *app = [UIApplication sharedApplication];
    
    // ここから「アプリがバックグラウンドに入っても実行し続けたい処理」が始まると通知
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        // このブロック内は一定時間内 (10分程度)に処理が完了しなかった場合に実行される。
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    MPMusicPlayerController *Player = [MPMusicPlayerController iPodMusicPlayer];
    NSString *songTitle = [Player.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    NSString *songArtist = [Player.nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    NSLog(@"%@ %@", songTitle, songArtist);
    if (Player.playbackState == MPMusicPlaybackStatePlaying) {
        NSLog(@"MPMusicPlaybackStatePlaying");
    }else{
        NSLog(@"MPMusicPlaybackStateNotPlaying");
    }

    timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                              target:self
                                            selector:@selector(upload)
                                            userInfo:nil
                                             repeats:NO];
    
    // アップロード処理を適当に書く
    // アップロード中にアプリがバックグラウンドに入ってもアップロードは継続
}


// アップロード完了後に呼ばれるdelegateメソッド
- (void)uploadFinished {
    // 「アプリがバックグラウンドに入っても実行し続けたい処理」が終わったと通知
    [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
    
    [self upload];
}

@end

//NSNull Crash対策
@implementation NSNull(IgnoreMessages)

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig=[[NSNull class] instanceMethodSignatureForSelector:aSelector];
    // Just return some meaningless signature
    if (sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    
    return sig;
}
@end
