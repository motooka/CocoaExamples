//
//  ViewController.m
//  MediaTest20120121-1
//
//  Created by 本岡 忠久 on 12/01/15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - custom methods

- (IBAction)launchPicker:(id)sender {
	// 「Launch the Picker」ボタン
	
	// MPMediaPickerControllerの初期化：オーディオを全て取得するように設定
	NSLog(@"will instantiate MPMediaPickerController");
	MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
	NSLog(@"did instantiate MPMediaPickerController");
	
	// ピッカー上で選択／キャンセルされたときに呼び出されるDelegate
	[picker setDelegate:self];
	
	// 選択可能な個数を単数とするか複数とするか
	[picker setAllowsPickingMultipleItems:YES];
	//[picker setAllowsPickingMultipleItems:NO];
	
	// ピッカーの上部に表示するプロンプト
	picker.prompt = @"select a tune";
	
	// ピッカーの表示
	// ※実機じゃなくてシミュレータの場合はここで死ぬ
	NSLog(@"will show MPMediaPickerController");
	[self presentModalViewController:picker animated:YES];
	NSLog(@"did show MPMediaPickerController");
}


#pragma mark - MPMediaPickerControllerDelegate

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
	// ピッカー上で実際に曲が選択された際に呼び出される。
	
	// ログに出力する項目のリスト
	NSArray* propertyArray = [NSArray arrayWithObjects:MPMediaItemPropertyArtist, MPMediaItemPropertyAssetURL, MPMediaItemPropertyBeatsPerMinute, MPMediaItemPropertyGenre, MPMediaItemPropertyLyrics, MPMediaItemPropertyPlayCount, MPMediaItemPropertyRating, MPMediaItemPropertySkipCount, nil];
	
	// ピッカーを閉じる
	[self dismissModalViewControllerAnimated: YES];
	NSLog(@"selected %d item(s).", [mediaItemCollection count]);
	
	// 選択された曲の数だけループ
	for(int i=0; i<[mediaItemCollection count]; i++) {
		// n個目の曲を取得
		MPMediaItem* item = (MPMediaItem *)[[mediaItemCollection items] objectAtIndex:i]; 
		
		// ログ出力
		NSLog(@"=========================");
		NSLog(@"item #%d", i);
		NSLog(@"#%d title : %@", i, [item valueForProperty:MPMediaItemPropertyTitle]);
		for(int j=0; j<[propertyArray count]; j++) {
			NSString* propertyKey = [propertyArray objectAtIndex:j];
			NSLog(@"#%d %@ : %@", i, propertyKey, [item valueForProperty:propertyKey]);
		}
	}
}

- (void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
	// ピッカー上でキャンセルされた際に呼び出される。
	
	// ピッカーを閉じる
	[self dismissModalViewControllerAnimated: YES];
}

@end
