//
//  WSFlipsideViewController.h
//  music
//
//  Created by tatsuya fujii on 2013/11/11.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSFlipsideViewController;

@protocol WSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(WSFlipsideViewController *)controller;
@end

@interface WSFlipsideViewController : UIViewController

@property (weak, nonatomic) id <WSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
