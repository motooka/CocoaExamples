//
//  ViewController.h
//  AtomicityDemo01
//
//  Created by 本岡 忠久 on 12/02/14.
//  Copyright (c) 2014 本岡 忠久.
//
//  MIT License
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;

- (IBAction)initializeData:(id)sender;
- (IBAction)giveA500yen:(id)sender;
- (IBAction)giveB500yen:(id)sender;
- (IBAction)transferAtoB:(id)sender;
- (IBAction)transferAtoB_withError:(id)sender;

@end
