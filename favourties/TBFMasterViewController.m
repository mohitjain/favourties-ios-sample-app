//
//  TBFMasterViewController.m
//  favourties
//
//  Created by Mohit Jain on 24/07/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import "TBFMasterViewController.h"

#import "TBFDetailViewController.h"
#import "TBFFavoriteItem.h"

@interface TBFMasterViewController ()

@property (strong, nonatomic) NSMutableArray *favorities;

@end


@implementation TBFMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //  self.favorities = [@[@"Puppies", @"Guitar", @"iPhone"] mutableCopy];
    
    NSString *filePath = [self filepath];
    
    id contents = [NSMutableArray arrayWithContentsOfFile:filePath];
    //id contents = [NSKeyedArchiver unarchiveObjectWithFile: filePath];
    if(contents){
        self.favorities = contents;
    }else{
        self.favorities = [NSMutableArray array];
    }
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    [self saveChanges];
}

- (void)addItem:(id)sender{
    TBFFavoriteItem *newItem = [[TBFFavoriteItem alloc] init];
    [self.favorities insertObject:newItem atIndex:0];
    NSIndexPath *rowZero = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[rowZero] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView selectRowAtIndexPath:rowZero animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self performSegueWithIdentifier:@"ChosenItemShowDetails" sender:self];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    [self.favorities removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self saveChanges];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favorities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    TBFFavoriteItem *favorite = self.favorities[row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StandardCell" forIndexPath:indexPath];
    cell.textLabel.text = [favorite name];
    cell.detailTextLabel.text = [favorite reason];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ChosenItemShowDetails"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        id favorite = self.favorities[path.row];
        TBFDetailViewController *detail = segue.destinationViewController;
        detail.detailItem = favorite;
    }
}

- (void) saveChanges{
    NSString *filepath = [self filepath];
    
    if([NSKeyedArchiver archiveRootObject:self.favorities toFile:filepath]){
        NSLog(@"Success");
    }else{
        NSLog(@"Failed");
    }
    
}

- (NSString *)filepath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSString *filepath = [path stringByAppendingPathComponent:@"FavoritesStorage"];
    return filepath;
}

@end

//
//@interface TBFMasterViewController () {
//    NSMutableArray *_objects;
//}
//@end
//
//@implementation TBFMasterViewController
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}
//
//#pragma mark - Table View
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return _objects.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDate *object = _objects[indexPath.row];
//    cell.textLabel.text = [object description];
//    return cell;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}
//
//@end
