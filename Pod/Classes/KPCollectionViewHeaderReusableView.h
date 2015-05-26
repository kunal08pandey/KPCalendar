//
//  KPCollectionViewHeaderReusableView.h
//  KPCalendar
//
//  Created by Kunal Pandey on 22/05/15.
//  Copyright (c) 2015 kunalpandey2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPCollectionViewHeaderReusableView : UICollectionReusableView
@property(nonatomic,weak) IBOutlet UIView *monthView;
@property(nonatomic,weak) IBOutlet UIView *weekView;
@property(nonatomic,strong) IBOutlet UILabel *monthText;
@end
