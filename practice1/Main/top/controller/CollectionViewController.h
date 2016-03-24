//
//  CollectionViewController.h
//  practice1
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ViewController.h"

@interface CollectionViewController : ViewController
{
//    NSMutableArray *_dataArray;

}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
