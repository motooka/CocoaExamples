//
//  MasterViewController.m
//  Test20120325-01
//
//  Created by 本岡 忠久 on 12/03/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// StaticCellsを使うので、editButtonは不要。
	//self.navigationItem.leftBarButtonItem = self.editButtonItem;

	// StaticCellsを使うので、addButtonも不要。
	//UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	//self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View
/*
 * StaticCellsのとき、このメソッドは実装しない方が良い。（Storyboardsで定義した通りの値を返しても良いっぽいけど、メソッド丸ごとコメントアウトした方が楽。）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
*/
/*
 * StaticCellsのとき、このメソッドは実装しない方が良い。（Storyboardsで定義した通りの値を返しても良いっぽいけど、メソッド丸ごとコメントアウトした方が楽。）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}
*/
/*
 * StaticCellsのとき、このメソッドは実装しない方が良い。（Storyboardsで定義した通りの値を返しても良いっぽいけど、メソッド丸ごとコメントアウトした方が楽。）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

	NSDate *object = [_objects objectAtIndex:indexPath.row];
	cell.textLabel.text = [object description];
    return cell;
}
*/
/*
 * StaticCellsのとき、セルの構成は固定になるこのメソッドは実装しない方が良い。（常にNOを返すのもアリかも）
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
/*
 * StaticCellsのとき、セルの内容は固定になるのでこのメソッドは実装しない。
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
		// これはプロジェクトテンプレートにて定義されていたsegueに対する動作。一旦消しているので、この部分のコードは実行されないはず。
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    else if ([[segue identifier] isEqualToString:@"showDetail_hogehoge"]) {
		// ほげほげセルが選択されたとき
        [[segue destinationViewController] setDetailItem:@"ほげほげ"];
    }
    else if ([[segue identifier] isEqualToString:@"showDetail_foo"]) {
		// fooセルが選択されたとき
        [[segue destinationViewController] setDetailItem:@"foo"];
    }
    else if ([[segue identifier] isEqualToString:@"showDetail_bar"]) {
		// barセルが選択されたとき
        [[segue destinationViewController] setDetailItem:@"bar"];
    }
}

@end
