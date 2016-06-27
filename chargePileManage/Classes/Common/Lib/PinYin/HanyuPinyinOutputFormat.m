//
//  
//
//  Created by kimziv on 13-9-14.
//

#include "HanyuPinyinOutputFormat.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
@implementation HanyuPinyinOutputFormat
@synthesize vCharType=_vCharType;
@synthesize caseType=_caseType;
@synthesize toneType=_toneType;

- (id)init {
  if (self = [super init]) {
    [self restoreDefault];
  }
  return self;
}

- (void)restoreDefault {
    _vCharType = VCharTypeWithUAndColon;
    _caseType = CaseTypeLowercase;
    _toneType = ToneTypeWithToneNumber;
}

@end
