//
//  KPViewController.m
//  KPCalendar
//
//  Created by kunalpandey2014 on 05/22/2015.
//  Copyright (c) 2014 kunalpandey2014. All rights reserved.
//

#import "KPCalendarController.h"
#import "KPCollectionViewCell.h"
#import "KPCalendarLayout.h"
#import "KPCollectionViewHeaderReusableView.h"
#import <NSDate-Extensions/NSDate-Utilities.h>
#import <KPCalendar/NSDate+Extensions.h>

#define pi 3.1425
#define DEGREE_TO_RADIAN(degree) pi*degree/180;

@interface KPCalendarController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,KPCalendarLayoutDelegate>
@property (nonatomic,strong) NSDate *date,*currentDate,*firstDate;
@end
KPCalendarController *controller;
@implementation KPCalendarController

+(instancetype)calendarWithCurrentDate {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    controller = [[KPCalendarController alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
  });
  return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  [NSDate initCalendar];
  _currentDate = [NSDate currentDateWithoutTime];
  _firstDate = [_currentDate firstDayOfMonth];
  
  UINib *nib  = [UINib nibWithNibName:@"KPCollectionViewCell" bundle:nil];
  [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"KPCollectionViewCell"];
  nib = [UINib nibWithNibName:@"KPCollectionViewHeaderReusableView" bundle:nil];
  [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
  KPCalendarLayout *layout = (KPCalendarLayout*)self.collectionView.collectionViewLayout;
  [layout setHeaderReferenceSize:CGSizeMake(320, 58)];
  [layout setDelegate:self];
  
  
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
 
 _date = [_firstDate dateByAddingDays:indexPath.item];
//  UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//  attributes.frame = CGRectMake(10, 10 ,200, 200);
//  CGFloat radian= DEGREE_TO_RADIAN(indexPath.row);
//  attributes.transform = CGAffineTransformMakeRotation(radian);
//  cell.
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
    
    [reusableView.monthText setText:[[_firstDate dateByAddingMonths:indexPath.section] monthName]];
//  [reusableView setBackgroundColor:[UIColor whiteColor]];
     return reusableView;
  }
  return nil;
}


#pragma mark - KPCalendarLayoutDelegate

-(NSInteger)startingColumnNumberAtSection:(NSInteger)section {
  return  [_date weekday];
}

-(NSInteger)numberOfColumnsAtSection:(NSInteger)section {
  return 7;
}

-(NSInteger)numberOfRowsAtSection:(NSInteger)section {
  return ceill([_firstDate numDaysInMonth]/7);
}

-(CGSize)sizeOfItemAtindexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(50, 50);
}

-(UIEdgeInsets)insetForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UIEdgeInsetsZero;
}

#pragma mark - UICollectionViewDelegate Method


@end
