//
//  WSTimeLineViewController.m
//  music
//
//  Created by tatsuya fujii on 2013/11/11.
//  Copyright (c) 2013年 Wondershake. All rights reserved.
//

#import "WSTimeLineViewController.h"

@interface WSTimeLineViewController ()

@end

@implementation WSTimeLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
