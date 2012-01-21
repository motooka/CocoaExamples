//
//  ViewController.m
//  MediaTest20120121-2
//
//  Created by 本岡 忠久 on 12/01/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize getAll;
@synthesize getApple;

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
	[self setGetAll:nil];
	[self setGetApple:nil];
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
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

# pragma mark -
- (void)logTune:(MPMediaItem *)item prefix:(NSString *)logPrefix {
	// 渡された曲の情報をログに出力する。
	
	// ログに表示する項目の配列
	NSArray* propertyArray = [NSArray arrayWithObjects:MPMediaItemPropertyArtist, MPMediaItemPropertyAssetURL, MPMediaItemPropertyBeatsPerMinute, MPMediaItemPropertyGenre, MPMediaItemPropertyLyrics, MPMediaItemPropertyPlayCount, MPMediaItemPropertyRating, MPMediaItemPropertySkipCount, nil];
	
	// ログ出力
	NSLog(@"=========================");
	NSLog(@"%@ title : %@", logPrefix, [item valueForProperty:MPMediaItemPropertyTitle]);
	for(int i=0; i<[propertyArray count]; i++) {
		NSString* propertyKey = [propertyArray objectAtIndex:i];
		NSLog(@"%@ %@ : %@", logPrefix, propertyKey, [item valueForProperty:propertyKey]);
	}

}

- (IBAction)getAllTunes:(id)sender {
	// 「Get All Tunes!!!」ボタン
	
	// クエリの作成
	NSLog(@"will instantiate MPMediaQuery");
	MPMediaQuery* query = [[MPMediaQuery alloc] init];
	NSLog(@"did instantiate MPMediaQuery");
	
	// 抽出結果の取得
	NSArray* array = [query items];
	NSLog(@"found %d items.", [array count]);
	
	// 抽出結果をログに出力（最大10件）
	MPMediaItem* item = nil;
	for(int i=0; i<MIN(10, [array count]); i++) {
		item = (MPMediaItem *)[array objectAtIndex:i];
		// 曲名をログに出してみたり
		[self logTune:item prefix:[NSString stringWithFormat:@"#%d",i]];
	}
}

- (IBAction)getAppleTunes:(id)sender {
	// 「Get Tunes contains 'Apple'」ボタン
	
	// 抽出条件の作成
	// comparisonType : MPMediaPredicateComparisonEqualTo (default) or MPMediaPredicateComparisonContains
	MPMediaPropertyPredicate* tuneNamePredicate =
		[MPMediaPropertyPredicate predicateWithValue:@"Apple"
										 forProperty:MPMediaItemPropertyTitle
									  comparisonType:MPMediaPredicateComparisonContains];
	
	// クエリの作成
	NSLog(@"will instantiate MPMediaQuery");
	MPMediaQuery* query = [[MPMediaQuery alloc] init];
	NSLog(@"did instantiate MPMediaQuery");
	
	// 作成した抽出条件の適用
	[query addFilterPredicate:tuneNamePredicate];
	
	// 抽出結果の取得
	NSArray* array = [query items];
	NSLog(@"found %d items.", [array count]);
	
	// 抽出結果をログに出力（最大10件）
	MPMediaItem* item = nil;
	for(int i=0; i<MIN(10, [array count]); i++) {
		item = (MPMediaItem *)[array objectAtIndex:i];
		// 曲名をログに出してみたり
		[self logTune:item prefix:[NSString stringWithFormat:@"#%d",i]];
	}
}
@end
