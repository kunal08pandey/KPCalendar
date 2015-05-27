//
//  KPCalendarLayout.h
//  Pods
//
//  Created by Kunal Pandey on 25/05/15.
//
//

#import <UIKit/UIKit.h>


@protocol KPCalendarLayoutDelegate <UICollectionViewDelegate>

-(NSInteger)startingColumnNumberAtSection:(NSInteger)section;
-(NSInteger)numberOfColumnsAtSection:(NSInteger)section;
-(NSInteger)numberOfRowsAtSection:(NSInteger)section;
-(UIEdgeInsets)insetForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGSize)sizeOfItemAtindexPath:(NSIndexPath *)indexPath;
-(CGFloat)interSpacingBetweenOfRowAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface KPCalendarLayout : UICollectionViewFlowLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic,assign) NSInteger numberOfColumns;
@property (nonatomic,assign) NSInteger numberOfRows;
@property (nonatomic) NSInteger startingColumnNumber;

@property (nonatomic, strong) NSDictionary *layoutInfo;
@property(nonatomic,unsafe_unretained) id <KPCalendarLayoutDelegate> delegate;

//- (CGRect)frameForSeatAtIndexPath : (NSIndexPath *) indexPath;

- (NSInteger)numberOfRows;

- (void)setNumberOfRows:(NSInteger)newValue;

- (NSInteger)numberOfColumns;

- (void)setNumberOfColumns:(NSInteger)newValue;

@end
