//
//  TRVGoogleAPIClient.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/7/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
/**
 *  The Google SDK for iOS can:
 -Add an interactive map with markers, routes, polyshape drawing, overlayed images, SteetView views, and -- if desired -- open google maps from an app (take that, mapkit!)...
 
 * Some services are only available to iOS devices via WEB SERVICES:
-Geocoding (Google Geocoding API).
-Reverse Geocoding (Google Places API).
-Get Directions (not just plan a route) including traffic, transit, etc. (Google Directions API).
 -Find nearby businesses and other places, OR search for businesses and other places by category/type or query string. (Google Places API)
 -Get the name, address, opening hours, and other details of a place, including customer ratings and reviews. (Google Places API)
-Add the type-ahead search behavior of the Google Maps search field to your app.(Google Places Autocomplete)
 -Autofill an address form. (Google Places Autocomplete)
 -Find photos of businesses and other points of interest, sourced from the Places and Google+ databases. (Photos service in the Google Places API)
 -Display search results for the visible region on a map, including nearby businesses and other places. (Google Maps Embed API).
- Get a location and accuracy radius based on information about cell towers and WiFi nodes that a mobile client can detect. Useful when GPS is not available, for example. (Geolocation API)
 Calculate the travel distance and travel time for multiple origins and destinations, optionally specifying various forms of transport: walking, driving, cycling. (Google Distance Matrix API).
 */
#import <Foundation/Foundation.h>

@interface TRVGoogleAPIClient : NSObject

@end
