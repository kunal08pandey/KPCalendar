//
//  KPCalendarLayout.h
//  Pods
//
//  Created by Kunal Pandey on 25/05/15.
//
//

#import <UIKit/UIKit.h>

@interface KPCalendarLayout : UICollectionViewFlowLayout


- (CGRect)frameForSeatAtIndexPath : (NSIndexPath *) indexPath;

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) NSInteger startingColumnNumber;
@property (nonatomic, strong,readonly) NSDictionary *layoutInfo;

@end
