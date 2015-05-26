//
//  KPViewController.m
//  KPCalendar
//
//  Created by kunalpandey2014 on 05/22/2015.
//  Copyright (c) 2014 kunalpandey2014. All rights reserved.
//

#import "KPCalendarController.h"
#import "KPCollectionViewCell.h"
#import "KPCollectionViewHeaderReusableView.h"
#import <NSDate-Extensions/NSDate-Utilities.h>
#import <KPCalendar/NSDate+Extensions.h>
@interface KPCalendarController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSDate *date,*currentDate,*firstDate;
@end

@implementation KPCalendarController

- (void)viewDidLoad
{
    [super viewDidLoad];
  [NSDate initCalendar];
  _currentDate = [NSDate currentDateWithoutTime];
  _firstDate = [_currentDate firstDayOfMonth];
  
  UINib *nib  = [UINib nibWithNibName:@"KPCollectionViewCell" bundle:nil];
  [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"KPCollectionViewCell"];
  nib = [UINib nibWithNibName:@"KPCollectionViewHeaderReusableView" bundle:nil];
  [self.collectionView registerClass:[KPCollectionViewHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
  UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
  [layout setHeaderReferenceSize:CGSizeMake(320, 58)];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource Method

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 12;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  _date = [_firstDate dateByAddingMonths:section];
  return [_date numDaysInMonth];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellIdentifier = @"KPCollectionViewCell";
  KPCollectionViewCell *cell = (KPCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
  if(cell == nil) {
    cell = [[KPCollectionViewCell alloc] init];
  }
  NSLog(@"%d",[_date weekday]);
 _date = [_firstDate dateByAddingDays:indexPath.item];
  NSString *dateString = [NSString stringWithFormat:@"%ld",(long)[_date dateComponents].day];
  [cell.dateLabel setText:dateString];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  static NSString *headerIdentifier = @"HeaderView";
  if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
  KPCollectionViewHeaderReusableView *reusableView = (KPCollectionViewHeaderReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
  if(reusableView == nil) {
    reusableView = [[KPCollectionViewHeaderReusableView alloc] init];
  }
    [_date month]
    reusableView.monthText setText:<#(NSString *)#>
//  [reusableView setBackgroundColor:[UIColor whiteColor]];
     return reusableView;
  }
  return nil;
}



#pragma mark - UICollectionViewDelegate Method


@end
