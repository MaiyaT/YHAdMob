//
//  BBXImgAndTitleCell.m
//  SuoShi
//
//  Created by 林宁宁 on 16/1/30.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BBXImgAndTitleCell.h"
#import "Masonry.h"
#import "UIColor+BBXApp.h"
#import "UIFont+BBX.h"


@implementation BBXImgAndTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.cellImageV = [UIImageView new];
        self.cellImageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.cellImageV];
        
        self.cellLab = [UILabel new];
        self.cellLab.textAlignment = NSTextAlignmentLeft;
        self.cellLab.font = [UIFont bbxSystemFont:14];
        self.cellLab.textColor = [UIColor bbxTextHeadTitleColor];
        [self.contentView addSubview:self.cellLab];
        
        self.cellSubTitle = [UILabel new];
        self.cellSubTitle.textAlignment = NSTextAlignmentRight;
        self.cellSubTitle.font = [UIFont bbxSystemFont:14];
        self.cellSubTitle.textColor = [UIColor bbxTextHeadSubTitleColor];
        [self.contentView addSubview:self.cellSubTitle];
        
        
        int offset = 10;
        
        __weak typeof(&*self)weakSelf = self;
        [self.cellImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset(offset);
            make.top.equalTo(weakSelf.contentView).offset(offset);
            make.bottom.equalTo(weakSelf.contentView).offset(-offset);
            make.width.equalTo(weakSelf.cellImageV.mas_height);
        }];
        
        [self.cellLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.cellImageV.mas_right).offset(offset);
        }];
        
        [self.cellSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(weakSelf.contentView);
        }];
    }
    return self;
}

@end
