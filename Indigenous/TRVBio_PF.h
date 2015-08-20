////
////  TRVBio_PF.h
////  Indigenous
////
////  Created by Amitai Blickstein on 8/10/15.
////  Copyright (c) 2015 Bad Boys 3. All rights reserved.
////
//
//#import "PFObject.h"
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
//#import <Parse.h>
//
//@interface TRVBio_PF : PFObject
//
//    //// Don't need a username really.  We go via Fist and Last name.
//    //@property (nonatomic, strong) NSString *userName;
//
//@property (nonatomic, strong) NSString *firstName;
//@property (nonatomic, strong) NSString *lastName;
//@property (nonatomic, strong) NSString *email;
//@property (nonatomic, strong) NSString *phoneNumber;
//@property (nonatomic, strong) NSString *bioDescription;
//@property (nonatomic, strong) PFFile *profileImage;
//@property (nonatomic, strong) PFFile *nonFacebookImage;
//
//    // Not sure if we need interests
//@property (nonatomic, strong) NSMutableArray *interests;
//@property (nonatomic, strong) NSString *language;
//@property (nonatomic, strong) NSString *homeCountry;
//@property (nonatomic, strong) NSString *userTagline;
//@property (nonatomic, strong) NSString *birthday;
//@property (nonatomic) BOOL isGuide;
//
//    //GUIDE SPECIFIC PROPERTIES
//@property (nonatomic) NSUInteger age;
//@property (nonatomic, strong) NSString *gender;
//@property (nonatomic, strong) NSString *region;
//@property (nonatomic, strong) NSString *homeCity;
//@property (nonatomic, strong) NSString *profileImageURL;
//
//    //INITIALIZERS
//    //-(instancetype)initTourist;
//    //-(instancetype)initGuide;
//
//-(instancetype)initTouristWithUserName:(NSString*)username
//                             firstName:(NSString*)firstName
//                              lastName:(NSString*)lastName
//                                 email:(NSString*)email
//                           phoneNumber:(NSString*)phoneNumber
//                          profileImage:(UIImage*)profileImage
//                        bioDescription:(NSString*)bioDescription
//                             interests:(NSMutableArray*)interests
//                              language:(NSString*)language;
//
//-(instancetype)initGuideWithUserName:(NSString*)username
//                           firstName:(NSString*)firstName
//                            lastName:(NSString*)lastName
//                               email:(NSString*)email
//                         phoneNumber:(NSString*)phoneNumber
//                        profileImage:(UIImage*)profileImage
//                      bioDescription:(NSString*)bioDescription
//                           interests:(NSMutableArray*)interests
//                            language:(NSString*)language
//                                 age:(NSUInteger)age
//                              gender:(NSString*)gender
//                              region:(NSString*)region
//                      oneLineSummary:(NSString*)oneLineSummary
//                     profileImageURL:(NSString*)URL
//                    nonFacebookImage:(UIImage *)nonFacebookImage;
//
//    //-(void)convertTouristToGuideWithAge:(NSUInteger)age
//    //                             gender:(NSString*)gender
//    //                             region:(NSString*)region
//    //                     oneLineSummary:(NSString*)oneLineSummary;
//
//
//
//@end
