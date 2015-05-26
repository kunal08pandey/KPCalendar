//
//  KPCalendarLayout.m
//  Pods
//
//  Created by Kunal Pandey on 25/05/15.
//
//

#import "KPCalendarLayout.h"

@implementation KPCalendarLayout


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

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
  if (_numberOfColumns == numberOfColumns) return;
  
  _numberOfColumns = numberOfColumns;
  
  [self invalidateLayout];
}





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
      itemAttributes.frame = [self frameForCellAtIndexPath:indexPath frame:itemAttributes.frame];
          cellLayoutInfo[indexPath] = itemAttributes;
    }
  }
  
//  newLayoutInfo[KPLayoutCellKind] = cellLayoutInfo;
  
//  self.layoutInfo = newLayoutInfo;
}

-(CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath frame:(CGRect)frame {
  CGRect newFrame = frame;
  if(indexPath.item == 0) {
    frame.origin.x = self.startingColumnNumber*frame.size.width + self.itemSize.width + self.itemInsets.left;
  }
  return frame;
}



@end
