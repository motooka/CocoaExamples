//
//  ViewController.h
//  MediaTest20120121-2
//
//  Created by 本岡 忠久 on 12/01/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController {
	
}
@property (weak, nonatomic) IBOutlet UIButton *getAll;
@property (weak, nonatomic) IBOutlet UIButton *getApple;
- (IBAction)getAllTunes:(id)sender;
- (IBAction)getAppleTunes:(id)sender;

@end
