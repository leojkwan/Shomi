//
//  NSMutableArray+TRVMutableArray_extraMethods.m
//  Indigenous
//
//  Created by Leo Kwan on 8/8/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVTour.h"
#import "TRVTourStop.h"
#import "TRVTourCategory.h"
#import "TRVItinerary.h"
#import <Parse/Parse.h>
#import <malloc/malloc.h>

@implementation NSMutableArray (TRVMutableArray_extraMethods)


-(NSMutableArray *) returnDummyAllTripsArrayForGuide:(TRVUser *)guide {

    NSMutableArray *allTripsArray = [[NSMutableArray alloc] init];
    
   
   // [self createParseDummyTour];
    
//    TRVTourStop *dummyTourStop1 = [[TRVTourStop alloc] initWithCoordinates:CLLocationCoordinate2DMake(10.0, 10.0)];
//    dummyTourStop1.image = [UIImage imageNamed:@"madrid.jpg"];
//    dummyTourStop1.nameOfPlace = @"Ippudo";
//    dummyTourStop1.addressOfEvent = @"65 4th Ave";
//    dummyTourStop1.cityOfEvent = @"New York";
//    dummyTourStop1.descriptionOfEvent = @"Best Ramen in the city";
//
//    
//    
//    TRVTourStop *dummyTourStop2 = [[TRVTourStop alloc] initWithCoordinates:CLLocationCoordinate2DMake(10.0, 10.0)];
//    dummyTourStop2.image = [UIImage imageNamed:@"london.jpg"];
//    dummyTourStop2.nameOfPlace = @"Totto Ramen";
//    dummyTourStop2.addressOfEvent = @"248 E 52nd St";
//    dummyTourStop2.cityOfEvent = @"New York";
//    dummyTourStop2.descriptionOfEvent = @"The 2nd Best Ramen in the city";
//
//    
//    //add 4 dummy stops
//    [tourStopsArray addObjectsFromArray:@[dummyTourStop1, dummyTourStop2,dummyTourStop2, dummyTourStop1]];
//    
//    //add array to itinerary
//    TRVItinerary *futureItinerary = [[TRVItinerary alloc] initNameOfTour:@"Future Tour" tourImage:[UIImage imageNamed:@"madrid"] tourStops:tourStopsArray];
//    TRVItinerary *pastItinerary = [[TRVItinerary alloc] initNameOfTour:@"Past Tour" tourImage:[UIImage imageNamed:@"beijing"] tourStops:tourStopsArray];
//
//    // create tour and add itinerary
//    
//
//        // make tour far in the future
//        TRVTour *dummyTourInTheFuture = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:futureItinerary categoryForThisTour:[TRVTourCategory returnDrinkCategory]];
//        dummyTourInTheFuture.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
//
//        // make tour far in the past
//    
//        NSCalendar *cal = [NSCalendar currentCalendar];
//        NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
//    
//        [components setHour:-[components hour]];
//        [components setMinute:-[components minute]];
//        [components setSecond:-[components second]];
//        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
//    
//        [components setHour:-24];
//        [components setMinute:0];
//        [components setSecond:0];
//        NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
//    
//
//        // set these Tours as 1 day old from start
//        TRVTour *dummyTourInThePast = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:pastItinerary categoryForThisTour:[TRVTourCategory returnCategoryWithTitle:@"See"]];
//        dummyTourInThePast.tourDeparture = yesterday;
//
//
//        
//    
//    //add 4  of these dummy trips into allTrips Array
//    [allTripsArray addObjectsFromArray:@[dummyTourInTheFuture,dummyTourInThePast,dummyTourInThePast, dummyTourInTheFuture,dummyTourInTheFuture,dummyTourInTheFuture]];
//    

    //COMMENT OUT IF YOU DO NOT WANT TO CREATE DUMMY DATA

   // [self createParseDummyTour];

   
    
    return allTripsArray;
}


+(void)createParseDummyTour {
    
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
    
    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
    theTour[@"categoryForThisTour"] = @"Discover";
    
    theTour[@"tourDeparture"] = [NSDate dateWithTimeIntervalSinceNow:10000];
    theTour[@"isPurchased"] = @(YES);
    theTour[@"price"] = @(99);
    
    
    theTour[@"itineraryForThisTour"] = theItinerary;
    theItinerary[@"nameOfTour"] = @"Wall St. Walk";
    
    UIImage *tourImage = [UIImage imageNamed:@"fedHall.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
    
    theItinerary[@"tourImage"] = PFImage;

    PFObject *theStop1 = [PFObject objectWithClassName:@"TourStop"];
    PFObject *theStop2 = [PFObject objectWithClassName:@"TourStop"];
    PFObject *theStop3 = [PFObject objectWithClassName:@"TourStop"];
    
    theStop1[@"operatorCost"] = @0;
    theStop1[@"incidentalCost"] = @0;
    theStop1[@"lat"] = @10;
    theStop1[@"lng"] = @10;
    theStop1[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop1[@"nameOfPlace"] = @"New York Stock Exchange";
    theStop1[@"descriptionOfEvent"] = @"We will start by walking down the historic Wall St. and straight to the New York Stock Exchange.  See where all the action happens.";
    theStop1[@"addressOfEvent"] = @"11 Wall St, New York, NY 10005";
    
    UIImage *stopImage1 = [UIImage imageNamed:@"stockExchange.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData1 = UIImageJPEGRepresentation(stopImage1, .2f);
    PFFile *PFImage1 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData1];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop1[@"image"] = PFImage1;
    
    
    theStop2[@"operatorCost"] = @0;
    theStop2[@"incidentalCost"] = @0;
    theStop2[@"lat"] = @10;
    theStop2[@"lng"] = @10;
    theStop2[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop2[@"nameOfPlace"] = @"The Charging Bull";
    theStop2[@"descriptionOfEvent"] = @"Let's take a stop at the Charging Bull!  An amazing and fun photo opportunity.";
    theStop2[@"addressOfEvent"] = @"Broadway & Morris St, New York, NY";
    
    UIImage *stopImage2 = [UIImage imageNamed:@"bull.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData2 = UIImageJPEGRepresentation(stopImage2, .2f);
    PFFile *PFImage2 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData2];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop2[@"image"] = PFImage2;
    
    
    
    
    theStop3[@"operatorCost"] = @0;
    theStop3[@"incidentalCost"] = @0;
    theStop3[@"lat"] = @10;
    theStop3[@"lng"] = @10;
    theStop3[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop3[@"nameOfPlace"] = @"Federal Hall";
    theStop3[@"descriptionOfEvent"] = @"Take a dive into American history at Federal Hall.  This is where Wasington was sworn in and the Bill of Rights was written!";
    theStop3[@"addressOfEvent"] = @"26 Wall St, New York, NY 10005";
    
    UIImage *stopImage3 = [UIImage imageNamed:@"george.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData3 = UIImageJPEGRepresentation(stopImage3, .2f);
    PFFile *PFImage3 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData3];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop3[@"image"] = PFImage3;
    
    
    
    
    NSArray *tourStopsArray = @[theStop1, theStop2, theStop3];
    theItinerary[@"tourStops"] = tourStopsArray;
    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);

    
    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
       
        
        [currentUser addObject:theTour forKey:@"myGuideTrips"];
        [currentUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (error){
                NSLog(@"Cant save to array because: %@", error);
            } else {
                NSLog(@"Successfully added stuff to array.");
            }
        }];

        
    }];
    
}

+(void)createParseDummyTour2 {
    
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
    
    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
    theTour[@"categoryForThisTour"] = @"See";
    
    theTour[@"tourDeparture"] = [NSDate dateWithTimeIntervalSinceNow:10000];
    theTour[@"isPurchased"] = @(YES);
    theTour[@"price"] = @(99);
    
    
    theTour[@"itineraryForThisTour"] = theItinerary;
    theItinerary[@"nameOfTour"] = @"Central Park Adventure";
    
    UIImage *tourImage = [UIImage imageNamed:@"centralParkMain.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
    
    theItinerary[@"tourImage"] = PFImage;
    
    PFObject *theStop1 = [PFObject objectWithClassName:@"TourStop"];
    PFObject *theStop2 = [PFObject objectWithClassName:@"TourStop"];
    
    theStop1[@"operatorCost"] = @0;
    theStop1[@"incidentalCost"] = @0;
    theStop1[@"lat"] = @10;
    theStop1[@"lng"] = @10;
    theStop1[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop1[@"nameOfPlace"] = @"Feeding The Ducks";
    theStop1[@"descriptionOfEvent"] = @"Let's give back to nature, by feeding bread to the wildlife.  These ducks are gorgeous animals!";
    theStop1[@"addressOfEvent"] = @"Central Park West & W. 86th St., New York, NY 10005";
    
    UIImage *stopImage1 = [UIImage imageNamed:@"lake.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData1 = UIImageJPEGRepresentation(stopImage1, .2f);
    PFFile *PFImage1 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData1];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop1[@"image"] = PFImage1;
    
    
    theStop2[@"operatorCost"] = @0;
    theStop2[@"incidentalCost"] = @0;
    theStop2[@"lat"] = @10;
    theStop2[@"lng"] = @10;
    theStop2[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop2[@"nameOfPlace"] = @"Lay In The Park";
    theStop2[@"descriptionOfEvent"] = @"After a nice afternoon at the lake, we will lay in the grass and observe the horniculture.  Take in the beauty.";
    theStop2[@"addressOfEvent"] = @"Central Park West & W. 86th St., New York, NY 10005";
    
    UIImage *stopImage2 = [UIImage imageNamed:@"lay.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData2 = UIImageJPEGRepresentation(stopImage2, .4f);
    PFFile *PFImage2 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData2];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop2[@"image"] = PFImage2;
    
    
    
    
//    theStop3[@"operatorCost"] = @0;
//    theStop3[@"incidentalCost"] = @0;
//    theStop3[@"lat"] = @10;
//    theStop3[@"lng"] = @10;
//    theStop3[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
//    theStop3[@"nameOfPlace"] = @"Federal Hall";
//    theStop3[@"descriptionOfEvent"] = @"Take a dive into American history at Federal Hall.  This is where Wasington was sworn in and the Bill of Rights was written!";
//    theStop3[@"addressOfEvent"] = @"26 Wall St, New York, NY 10005";
//    
//    UIImage *stopImage3 = [UIImage imageNamed:@"george.jpg"];
//    // converts tour image to 1/5 quality
//    NSData *imageData3 = UIImageJPEGRepresentation(stopImage3, .2f);
//    PFFile *PFImage3 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData3];
//    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
//    theStop3[@"image"] = PFImage3;
//    
    
    
    
    NSArray *tourStopsArray = @[theStop1, theStop2];
    theItinerary[@"tourStops"] = tourStopsArray;
    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);
    
    
    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
        
        
        [currentUser addObject:theTour forKey:@"myGuideTrips"];
        [currentUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (error){
                NSLog(@"Cant save to array because: %@", error);
            } else {
                NSLog(@"Successfully added stuff to array.");
            }
        }];
        
        
    }];
    
}

+(void)createParseDummyTour3 {
    
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
    
    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
    theTour[@"categoryForThisTour"] = @"See";
    
    theTour[@"tourDeparture"] = [NSDate dateWithTimeIntervalSinceNow:10000];
    theTour[@"isPurchased"] = @(YES);
    theTour[@"price"] = @(99);
    
    
    theTour[@"itineraryForThisTour"] = theItinerary;
    theItinerary[@"nameOfTour"] = @"Explore Times Square";
    
    UIImage *tourImage = [UIImage imageNamed:@"timeSquareMain.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
    
    theItinerary[@"tourImage"] = PFImage;
    
    PFObject *theStop1 = [PFObject objectWithClassName:@"TourStop"];
    PFObject *theStop2 = [PFObject objectWithClassName:@"TourStop"];
    PFObject *theStop3 = [PFObject objectWithClassName:@"TourStop"];
    
    theStop1[@"operatorCost"] = @0;
    theStop1[@"incidentalCost"] = @0;
    theStop1[@"lat"] = @10;
    theStop1[@"lng"] = @10;
    theStop1[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop1[@"nameOfPlace"] = @"Disney Store";
    theStop1[@"descriptionOfEvent"] = @"Let's take a stroll through the magical world of Disney and they landmark store.  An amazing experience for people of all ages.";
    theStop1[@"addressOfEvent"] = @"1540 Broadway, New York, NY 10036";
    
    UIImage *stopImage1 = [UIImage imageNamed:@"disney.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData1 = UIImageJPEGRepresentation(stopImage1, .2f);
    PFFile *PFImage1 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData1];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop1[@"image"] = PFImage1;
    
    
    theStop2[@"operatorCost"] = @0;
    theStop2[@"incidentalCost"] = @0;
    theStop2[@"lat"] = @10;
    theStop2[@"lng"] = @10;
    theStop2[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop2[@"nameOfPlace"] = @"Watch Wicked!";
    theStop2[@"descriptionOfEvent"] = @"We'll be watching the world reknown, legendary play known as Wicked!  I've got 10 free tickets, just for this tour.  Truly a once in a lifetime opportunity.";
    theStop2[@"addressOfEvent"] = @"222 West 51st Street New York, NY";
    
    UIImage *stopImage2 = [UIImage imageNamed:@"play.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData2 = UIImageJPEGRepresentation(stopImage2, .2f);
    PFFile *PFImage2 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData2];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop2[@"image"] = PFImage2;
    
    
    theStop3[@"operatorCost"] = @0;
    theStop3[@"incidentalCost"] = @0;
    theStop3[@"lat"] = @10;
    theStop3[@"lng"] = @10;
    theStop3[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop3[@"nameOfPlace"] = @"Meet The Cast!";
    theStop3[@"descriptionOfEvent"] = @"Thanks to my Broadway experience, I'll give you a behind the scenes experience and introduce you to a few of the famous characters found on Broadway.";
    theStop3[@"addressOfEvent"] = @"26 Wall St, New York, NY 10005";
    
    UIImage *stopImage3 = [UIImage imageNamed:@"characters.jpg"];
    // converts tour image to 1/5 quality
    NSData *imageData3 = UIImageJPEGRepresentation(stopImage3, .2f);
    PFFile *PFImage3 = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData3];
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop3[@"image"] = PFImage3;
    
    
    
    
    NSArray *tourStopsArray = @[theStop1, theStop2, theStop3];
    theItinerary[@"tourStops"] = tourStopsArray;
    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);
    
    
    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
        
        
        [currentUser addObject:theTour forKey:@"myGuideTrips"];
        [currentUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (error){
                NSLog(@"Cant save to array because: %@", error);
            } else {
                NSLog(@"Successfully added stuff to array.");
            }
        }];
        
        
    }];
    
}



@end
