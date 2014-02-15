//
//  ViewController.m
//  AtomicityDemo01
//
//  Created by 本岡 忠久 on 12/02/14.
//  Copyright (c) 2014 本岡 忠久.
//
//  MIT License
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// 必要があれば、Aさんの口座を作成（初期値0円）（中でcontextのsaveが呼ばれる）
	[self prepareAccountForName:@"A"];
	
	// 必要があれば、Bさんの口座を作成（初期値0円）（中でcontextのsaveが呼ばれる）
	[self prepareAccountForName:@"B"];
	
	// ラベル表示内容を更新
	[self refreshLabels];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)initializeData:(id)sender {
	// CoreData作業の準備
	AppDelegate* appD = [UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = appD.managedObjectContext;
	
	// entity "Accounts" から全件取得するリクエストを作成
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Accounts" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// フェッチ（データの取得／リクエストの実行）
	NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
		// Handle the error.
		NSLog(@"[%s] could not fetch : %@", __FUNCTION__, error);
		return;
	}
	
	// フェッチできたデータを全て削除（まだ書き込まれない）
	for(NSManagedObject* obj in fetchedObjects) {
		[context deleteObject:obj];
	}
	
	// 上記の操作を記録
	if(![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
	
	// Aさんの口座を作成（初期値0円）（中でcontextのsaveが呼ばれる）
	[self prepareAccountForName:@"A"];
	
	
	// Bさんの口座を作成（初期値0円）（中でcontextのsaveが呼ばれる）
	[self prepareAccountForName:@"B"];
	
	// 画面表示を更新
	[self refreshLabels];
}

- (IBAction)giveA500yen:(id)sender {
	// Aさんの口座に500円追加
	[self giveMoney:500 to:@"A"];
	[self refreshLabels];
}

- (IBAction)giveB500yen:(id)sender {
	// Bさんの口座に500円追加
	[self giveMoney:500 to:@"B"];
	[self refreshLabels];
}

- (IBAction)transferAtoB:(id)sender {
	[self transferAtoB_inner_withError:NO];
	[self refreshLabels];
}

- (IBAction)transferAtoB_withError:(id)sender {
	[self transferAtoB_inner_withError:YES];
	[self refreshLabels];
}

#pragma mark - private methods

- (void)prepareAccountForName:(NSString*)name {
	// CoreData作業の準備
	AppDelegate* appD = [UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = appD.managedObjectContext;
	
	// entity "Accounts" から対象者の口座を取得するリクエストを作成
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Accounts" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", name];
	[fetchRequest setPredicate:predicate];
	
	// フェッチ（データの取得／リクエストの実行）
	NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
		// Handle the error.
		NSLog(@"[%s] could not fetch. name=%@, error=%@", __FUNCTION__, name, error);
		return;
	}
	if([fetchedObjects count] >= 1) {
		// 口座が見つかった→何もしなくて良い
		return;
	}
	
	// 口座を作成（初期値0円）
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	[newManagedObject setValue:name forKey:@"name"];
	[newManagedObject setValue:[NSNumber numberWithInt:0] forKey:@"balance"];
	
	// 上記の操作を記録
	if(![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
}

- (void)transferAtoB_inner_withError:(bool)withError {
	// CoreData作業の準備
	AppDelegate* appD = [UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = appD.managedObjectContext;
	
	// entity "Accounts" からAさんとBさんの口座を取得するリクエストを作成
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Accounts" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name like 'A') OR (name like 'B')", nil];
	[fetchRequest setPredicate:predicate];
	
	// フェッチ（データの取得／リクエストの実行）
	NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
		// Handle the error.
		NSLog(@"[%s] could not fetch. error=%@", __FUNCTION__, error);
		return;
	}
	
	// AさんとBさんの残高を調べる
	NSManagedObject* accountA = nil;
	NSManagedObject* accountB = nil;
	for(NSManagedObject* obj in fetchedObjects) {
		if([@"A" isEqualToString:[obj valueForKey:@"name"]]) {
			accountA = obj;
		}
		if([@"B" isEqualToString:[obj valueForKey:@"name"]]) {
			accountB = obj;
		}
	}
	
	if(accountA == nil || accountB == nil) {
		// 口座が見つからない
		NSLog(@"[%s] could not find an account", __FUNCTION__);
		return;
	}
	
	// Aさんの残高を500円減らす
	NSNumber* balanceA = [accountA valueForKey:@"balance"];
	[accountA setValue:[NSNumber numberWithInt:([balanceA integerValue]-500)] forKey:@"balance"];
	
#define WITHOUT_ATOMICITY
#ifdef WITHOUT_ATOMICITY
	// 上記の操作を記録
	if(![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
#endif
	
	
	if(withError) {
		// 処理中のエラーをシミュレートする場合
		// ここでは単に例外を投げてるけど、実際はアプリが強制終了されたとか、ネットワークのエラーが起きたとか。。
		@throw @"ごめん、わざとやわ";
	}
	
	// Bさんの残高を500円増やす
	NSNumber* balanceB = [accountB valueForKey:@"balance"];
	[accountB setValue:[NSNumber numberWithInt:([balanceB integerValue]+500)] forKey:@"balance"];
	
	// 上記の操作を記録
	if(![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
}

- (void)giveMoney:(NSInteger)amount to:(NSString*)name {
	// CoreData作業の準備
	AppDelegate* appD = [UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = appD.managedObjectContext;
	
	// entity "Accounts" から対象者の口座を取得するリクエストを作成
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Accounts" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", name];
	[fetchRequest setPredicate:predicate];
	
	// フェッチ（データの取得／リクエストの実行）
	NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
		// Handle the error.
		NSLog(@"[%s] could not fetch. name=%@, error=%@", __FUNCTION__, name, error);
		return;
	}
	if([fetchedObjects count] < 1) {
		// 口座が見つからない
		NSLog(@"[%s] could not find an account of %@", __FUNCTION__, name);
		return;
	}
	NSManagedObject* obj = [fetchedObjects objectAtIndex:0];
	
	// 残高を調べる
	NSNumber* balance = [obj valueForKey:@"balance"];
	
	// 加算した金額で更新（まだ書き込まれない）
	[obj setValue:[NSNumber numberWithInt:([balance integerValue]+amount)] forKey:@"balance"];
	
	
	// 上記の操作を記録
	if(![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
}

- (void)refreshLabels {
	AppDelegate* appD = [UIApplication sharedApplication].delegate;
	NSManagedObjectContext *context = appD.managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Accounts" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
		// Handle the error.
		NSLog(@"[%s] could not fetch : %@", __FUNCTION__, error);
		return;
	}
	
	NSInteger balanceA = 0;
	NSInteger balanceB = 0;
	for(NSManagedObject* obj in fetchedObjects) {
		NSNumber* balance = [obj valueForKey:@"balance"];
		NSString* name = [obj valueForKey:@"name"];
		
		if([name isEqualToString:@"A"]) {
			balanceA = [balance integerValue];
		}
		if([name isEqualToString:@"B"]) {
			balanceB = [balance integerValue];
		}
	}
	
	self.labelA.text = [NSString stringWithFormat:@"%d 円", balanceA];
	self.labelB.text = [NSString stringWithFormat:@"%d 円", balanceB];
}

@end
