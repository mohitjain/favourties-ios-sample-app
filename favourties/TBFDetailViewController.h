//
//  TBFDetailViewController.h
//  favourties
//
//  Created by Mohit Jain on 24/07/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBFDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
