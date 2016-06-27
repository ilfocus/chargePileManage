/**
 *	Created by kimziv on 13-9-14.
 */
#ifndef _HanyuPinyinOutputFormat_H_
#define _HanyuPinyinOutputFormat_H_
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
typedef enum {
  ToneTypeWithToneNumber,
  ToneTypeWithoutTone,
  ToneTypeWithToneMark
}ToneType;

typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;

typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;


@interface HanyuPinyinOutputFormat : NSObject

@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;

- (id)init;
- (void)restoreDefault;
@end

#endif // _HanyuPinyinOutputFormat_H_
