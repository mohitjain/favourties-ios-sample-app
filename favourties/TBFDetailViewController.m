//
//  TBFDetailViewController.m
//  favourties
//
//  Created by Mohit Jain on 24/07/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import "TBFDetailViewController.h"

@interface TBFDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
- (void)configureView;
@end

@implementation TBFDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.nameTextField.text = [self.detailItem name];
        self.reasonTextView.text = [self.detailItem reason];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.detailItem.name = self.nameTextField.text;
    self.detailItem.reason = self.reasonTextView.text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
