//
//  KPCalendarLayout.m
//  Pods
//
//  Created by Kunal Pandey on 25/05/15.
//
//

#import "KPCalendarLayout.h"

@interface KPCalendarLayout ()

@end
static NSString * const KPLayoutCellKind = @"LayoutCell";

@implementation KPCalendarLayout
@synthesize numberOfColumns=_numberOfColumns;
@synthesize numberOfRows=_numberOfRows;





- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
  if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
  
  _itemInsets = itemInsets;
  
  [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize
{
  if (CGSizeEqualToSize(itemSize, itemSize)) return;
  
  itemSize = itemSize;
  
  [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
  if (_interItemSpacingY == interItemSpacingY) return;
  
  _interItemSpacingY = interItemSpacingY;
  
  [self invalidateLayout];
}



//- (void)prepareLayout
//{
//  [super prepareLayout];
//  
//  _layoutAttributes = [NSMutableDictionary dictionary]; // 1
//  
//  NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
//  
//  UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:path];
//  attributes.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.itemHeight / 4.0f);
//  
//  NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:path];
//  _layoutAttributes[headerKey] = attributes; // 2
//  
//  NSUInteger numberOfSections = [self.collectionView numberOfSections]; // 3
//  
//  CGFloat yOffset = self.itemHeight / 4.0f;
//  
//  for (int section = 0; section < numberOfSections; section++)
//  {
//    NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section]; // 3
//    
//    CGFloat xOffset = self.horizontalInset;
//    
//    for (int item = 0; item < numberOfItems; item++)
//    {
//      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
//      UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]; // 4
//      
//      CGSize itemSize = CGSizeZero;
//      
//      BOOL increaseRow = NO;
//      
//      if (self.collectionView.frame.size.width - xOffset > self.maximumItemWidth * 1.5f)
//      {
//        itemSize = [self randomItemSize]; // 5
//      }
//      else
//      {
//        itemSize.width = self.collectionView.frame.size.width - xOffset - self.horizontalInset;
//        itemSize.height = self.itemHeight;
//        increaseRow = YES; // 6
//      }
//      
//      attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
//      NSString *key = [self layoutKeyForIndexPath:indexPath];
//      _layoutAttributes[key] = attributes; // 7
//      
//      xOffset += itemSize.width;
//      xOffset += self.horizontalInset; // 8
//      
//      if (increaseRow
//          && !(item == numberOfItems-1 && section == numberOfSections-1)) // 9
//      {
//        yOffset += self.verticalInset;
//        yOffset += self.itemHeight;
//        xOffset = self.horizontalInset;
//      }
//    }
//  }
//  
//  yOffset += self.itemHeight; // 10
//  
//  _contentSize = CGSizeMake(self.collectionView.frame.size.width, yOffset + self.verticalInset); // 11
//}


-(void)prepareLayout {
  NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
  NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];

  NSInteger sectionCount = [self.collectionView numberOfSections];
  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
  
  for (NSInteger section = 0; section < sectionCount; section++) {
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
    
    for (NSInteger item = 0; item < itemCount; item++) {
      indexPath = [NSIndexPath indexPathForItem:item inSection:section];
      
      UICollectionViewLayoutAttributes *itemAttributes =
      [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
      itemAttributes.frame = [self frameForCellAtIndexPath:indexPath];
      //[self frameForCellAtIndexPath:indexPath frame:itemAttributes.frame];
          cellLayoutInfo[indexPath] = itemAttributes;
    }
  }
  newLayoutInfo[KPLayoutCellKind] = cellLayoutInfo;
//  self.layoutInfo = newLayoutInfo;
  self.layoutInfo = newLayoutInfo;
}



//-(void)prepareLayout
//{
//  //don't forget to call super here
//  [super prepareLayout];
//  
//  /* pre-calculate and cache whatever you need here */
//  
//  //maybe you would want to loop over each cell like this?
//  for(NSUInteger i = 0; i < [self.collectionView numberOfSections]; i++)
//  {
//    for(NSUInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++)
//    {
//      /* calculate something for the cell at row j in section i */
//    }
//  }
//}

//- (CGSize)collectionViewContentSize
//{
//  return CGSizeMake(/* calculate your width */,
//                    /* calculate your height */);
//}

//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
//{
//  NSMutableArray* elementsInRect = [NSMutableArray array];
//  
//  //iterate over all cells in this collection
//  for(NSUInteger i = 0; i < [self.collectionView numberOfSections]; i++)
//  {
//    for(NSUInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++)
//    {
//      //this is the cell at row j in section i
//      CGRect cellFrame = CGRectMake(/* calculate your origin x */,
//                                    /* calculate your origin y */,
//                                    /* calculate your width */,
//                                    /* calculate your height */);
//      
//      //see if the collection view needs this cell
//      if(CGRectIntersectsRect(cellFrame, rect))
//      {
//        //create the attributes object
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
//        UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        
//        //set the frame for this attributes object
//        attr.frame = cellFrame;
//        [elementsInRect addObject:attr];
//      }
//    }
//  }
//  
//  return elementsInRect;
//}


//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//  UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//  
//  CGRect cellFrame = CGRectMake(/* calculate your origin x */,
//                                /* calculate your origin y */,
//                                /* calculate your width */,
//                                /* calculate your height */);
//  attr.frame = cellFrame;
//  
//  return attr;
//}

//-(CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath frame:(CGRect)frame {
//  CGRect newFrame = frame;
//  self.startingColumnNumber = [self.delegate respondsToSelector:@selector(startingColumnNumberAtSection:)] ? [self.delegate startingColumnNumberAtSection:indexPath.section] : self.startingColumnNumber;
//  if(indexPath.item == 0) {
//    frame.origin.x = self.startingColumnNumber*self.itemSize.width + self.itemSize.width + self.itemInsets.left;
//  }
//  frame.size.width = self.itemSize.width;
//  frame.size.height = self.itemSize.height;
//  return frame;
//}



- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath
{
  self.startingColumnNumber = ([self.delegate respondsToSelector:@selector(startingColumnNumberAtSection:)]) ? [self.delegate startingColumnNumberAtSection:indexPath.section] : self.startingColumnNumber;
  self.numberOfColumns = ([self.delegate respondsToSelector:@selector(numberOfColumnsAtSection:)]) ? [self.delegate numberOfColumnsAtSection:indexPath.section] : self.numberOfColumns;
  self.numberOfRows =  ([self.delegate respondsToSelector:@selector(numberOfRowsAtSection:)]) ? [self.delegate numberOfRowsAtSection:indexPath.section] : self.numberOfColumns;
  self.itemInsets =([self.delegate respondsToSelector:@selector(insetForRowAtIndexPath:)]) ? [self.delegate insetForRowAtIndexPath:indexPath] : self.itemInsets;
  self.itemSize = ([self.delegate respondsToSelector:@selector(sizeOfItemAtindexPath:)]) ? [self.delegate sizeOfItemAtindexPath:indexPath] : self.itemSize;
  self.interItemSpacingY =([self.delegate respondsToSelector:@selector(interSpacingBetweenOfRowAtIndexPath:)]) ? [self.delegate respondsToSelector:@selector(interSpacingBetweenOfRowAtIndexPath:)] :self.interItemSpacingY;

  NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:self.startingColumnNumber+indexPath.item-1 inSection:indexPath.section];
    NSInteger row = ceill(newIndexPath.item / self.numberOfColumns);
  NSInteger column = /*(row == 0) ? (self.startingColumnNumber - 1)+ceill(indexPath.item % self.numberOfColumns) :*/ ceill(newIndexPath.item % self.numberOfColumns);
  
  CGFloat spacingX = self.collectionView.bounds.size.width -
  self.itemInsets.left -
  self.itemInsets.right -
  (self.numberOfColumns * self.itemSize.width);
  
  if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
  
  CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
  
  CGFloat originY = floor(self.headerReferenceSize.height + self.itemInsets.top +
                          (self.itemSize.height + self.interItemSpacingY) * row);
  
  return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
  
  NSMutableArray *allAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];// [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
  
  [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                       NSDictionary *elementsInfo,
                                                       BOOL *stop) {
    [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                      UICollectionViewLayoutAttributes *attributes,
                                                      BOOL *innerStop) {
      if (CGRectIntersectsRect(rect, attributes.frame)) {
        [allAttributes addObject:attributes];
      }
    }];
  }];
  
  return allAttributes;
}

- (CGSize)collectionViewContentSize
{
//  NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
//  // make sure we count another row if one is only partially filled
//  if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
//  
//  CGFloat height = self.itemInsets.top +
//  rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
//  self.itemInsets.bottom;
  
  return [super collectionViewContentSize];
}



- (NSInteger)numberOfRows {
    return _numberOfRows;
}

- (void)setNumberOfRows:(NSInteger)newValue {
    _numberOfRows = newValue;
}

- (NSInteger)numberOfColumns {
    return _numberOfColumns;
}

- (void)setNumberOfColumns:(NSInteger)newValue {
    _numberOfColumns = newValue;
}


@end
