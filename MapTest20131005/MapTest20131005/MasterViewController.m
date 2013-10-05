//
//  MasterViewController.m
//  MapTest20131005
//
//  Created by 本岡 忠久 on 5/10/13.
//  Copyright (c) 2013 本岡 忠久. All rights reserved.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	NSDate *object = _objects[indexPath.row];
	cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
	NSString* identifier = [segue identifier];
	CLLocation* location = [[CLLocation alloc] initWithLatitude:0.0 longitude:0.0];
	CLLocation* secondaryLocation = nil;
	
    if ([identifier isEqualToString:@"showDetail-hatena"]) {
		location = [[CLLocation alloc] initWithLatitude:35.011105 longitude:135.761992];
    }
    else if ([identifier isEqualToString:@"showDetail-minamitorishima"]) {
		location = [[CLLocation alloc] initWithLatitude:24.287359 longitude:153.981028];
    }
    else if ([identifier isEqualToString:@"showDetail-cape-byron"]) {
		location = [[CLLocation alloc] initWithLatitude:-28.636203 longitude:153.638746];
    }
    else if ([identifier isEqualToString:@"showDetail-singleton"]) {
		location = [[CLLocation alloc] initWithLatitude:-32.563235 longitude:151.170931];
    }
    else if ([identifier isEqualToString:@"showDetail-fiji"]) {
		location = [[CLLocation alloc] initWithLatitude:-18.143242 longitude:178.442688];
    }
    else if ([identifier isEqualToString:@"showDetail-honolulu"]) {
		location = [[CLLocation alloc] initWithLatitude:21.307927 longitude:-157.858429];
    }
    else if ([identifier isEqualToString:@"showDetail-hatena-honolulu"]) {
		location = [[CLLocation alloc] initWithLatitude:35.011105 longitude:135.761992];
		secondaryLocation = [[CLLocation alloc] initWithLatitude:21.307927 longitude:-157.858429];
    }
	
	[[segue destinationViewController] setLocation:location];
	[[segue destinationViewController] setSecondaryLocation:secondaryLocation];
}

@end
