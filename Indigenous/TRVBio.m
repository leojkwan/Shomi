//
//  TRVBio.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBio.h"

@implementation TRVBio


-(instancetype)initTouristWithUserName:(NSString*)username
                             firstName:(NSString*)firstName
                              lastName:(NSString*)lastName
                                 email:(NSString*)email
                           phoneNumber:(NSString*)phoneNumber
                          profileImage:(UIImage*)profileImage
                        bioDescription:(NSString*)bioDescription
                             interests:(NSMutableArray*)interests
                              language:(NSString*)language
{
    self = [super init];
    if (self){
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phoneNumber = phoneNumber;
        _profileImage = profileImage;
        _bioDescription = bioDescription;
        _interests = interests;
        _language = language;
    }
    return self;
}

-(instancetype)initGuideWithUserName:(NSString*)username
                           firstName:(NSString*)firstName
                            lastName:(NSString*)lastName
                               email:(NSString*)email
                         phoneNumber:(NSString*)phoneNumber
                        profileImage:(UIImage*)profileImage
                      bioDescription:(NSString*)bioDescription
                           interests:(NSMutableArray*)interests
                            language:(NSString*)language
                                 age:(NSUInteger)age
                              gender:(NSString*)gender
                              region:(NSString*)region
                      oneLineSummary:(NSString*)oneLineSummary
                     profileImageURL:(NSString*)URL
                          nonFacebookImage:(UIImage *)nonFacebookImage
{
    
    self = [super init];
    if (self){
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phoneNumber = phoneNumber;
        _profileImage = profileImage;
        _bioDescription = bioDescription;
        _interests = interests;
        _language = language;
        _age = age;
        _userTagline = oneLineSummary;
        _gender = gender;
        _region = region;
        _profileImageURL = URL;
        _nonFacebookImage = nonFacebookImage;
    }
    return self;
    
    
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [encoder encodeObject:self.profileImage forKey:@"profileImage"];
    [encoder encodeObject:self.nonFacebookImage forKey:@"nonFacebookImage"];
    [encoder encodeObject:self.bioDescription forKey:@"bioDescription"];
    [encoder encodeObject:self.interests forKey:@"interests"];
    [encoder encodeObject:self.language forKey:@"language"];
    [encoder encodeObject:self.homeCountry forKey:@"homeCountry"];
    [encoder encodeObject:self.userTagline forKey:@"userTagline"];
    [encoder encodeObject:self.birthday forKey:@"birthday"];
    [encoder encodeBool:self.isGuide forKey:@"isGuide"];
    [encoder encodeInt64:self.age forKey:@"age"];
    [encoder encodeObject:self.gender forKey:@"gender"];
    [encoder encodeObject:self.region forKey:@"region"];
    [encoder encodeObject:self.homeCity forKey:@"homeCity"];
    [encoder encodeObject:self.profileImageURL forKey:@"profileImageURL"];

    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.firstName = [decoder decodeObjectOfClass:[NSString class] forKey:@"firstName"];
        self.lastName = [decoder decodeObjectOfClass:[NSString class] forKey:@"lastName"];
        self.email =[decoder decodeObjectOfClass:[NSString class] forKey:@"email"];
        self.phoneNumber =[decoder decodeObjectOfClass:[NSString class] forKey:@"phoneNumber"];
        self.profileImage =[decoder decodeObjectOfClass:[UIImage class] forKey:@"profileImage"];
        self.bioDescription =[decoder decodeObjectOfClass:[NSString class] forKey:@"bioDescription"];
        self.interests = [decoder decodeObjectOfClass:[NSMutableArray class] forKey:@"interests"];
        self.language = [decoder decodeObjectOfClass:[NSString class] forKey:@"language"];
        self.homeCountry = [decoder decodeObjectOfClass:[NSString class] forKey:@"homeCountry"];
        self.userTagline = [decoder decodeObjectOfClass:[NSString class] forKey:@"userTagline"];
        self.birthday = [decoder decodeObjectOfClass:[NSString class] forKey:@"birthday"];
        self.homeCity = [decoder decodeObjectOfClass:[NSString class] forKey:@"homeCity"];
        self.age = [decoder decodeInt64ForKey:@"age"];
        self.isGuide = [decoder decodeBoolForKey:@"isGuide"];
        self.gender = [decoder decodeObjectOfClass:[NSString class] forKey:@"gender"];
        self.region = [decoder decodeObjectOfClass:[NSString class] forKey:@"region"];
        self.profileImageURL = [decoder decodeObjectOfClass:[NSString class] forKey:@"profileImageURL"];
        self.nonFacebookImage = [decoder decodeObjectOfClass:[UIImage class] forKey:@"nonFacebookImage"];
    }
    return self;
}





@end
