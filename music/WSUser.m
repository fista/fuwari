//
//  WSUser.m
//  music
//
//  Created by tatsuya fujii on 2013/11/12.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import "WSUser.h"


@implementation WSUser

-(void)loginByFacebook
{
    NSArray *permissions = @[@"read_friendlists", @"email"];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            [[NSUserDefaults standardUserDefaults] setObject:session.accessTokenData.accessToken
                                                      forKey:FACEBOOK_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"%@ %@", session.accessTokenData.accessToken, session.accessTokenData.expirationDate);
        }
            break;
        case FBSessionStateClosed:
            CCLOG(@"FBSessionStateClosed");
            
            break;
        case FBSessionStateClosedLoginFailed:
            CCLOG(@"FBSessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        [[Loading loading] removeLodingView];
        //念のため破棄する
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"facebook_token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


-(void)login
{
    NSString *url = [NSString stringWithFormat:@"http://tc2013-wondershake.sqale.jp/auth"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *myRequestData = [[NSString stringWithFormat:@"facebook_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_token"]] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody: myRequestData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                               if (error) {
                                   NSLog(@"%@", [error description]);
                                   return;
                               }
                               
                               
                           }];
}
@end
