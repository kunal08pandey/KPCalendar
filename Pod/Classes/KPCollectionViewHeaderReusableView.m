//
//  KPCollectionViewHeaderReusableView.m
//  KPCalendar
//
//  Created by Kunal Pandey on 22/05/15.
//  Copyright (c) 2015 kunalpandey2014. All rights reserved.
//

#import "KPCollectionViewHeaderReusableView.h"

@implementation KPCollectionViewHeaderReusableView

-(id)init{
  if(self =[super init]) {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
}

@end
