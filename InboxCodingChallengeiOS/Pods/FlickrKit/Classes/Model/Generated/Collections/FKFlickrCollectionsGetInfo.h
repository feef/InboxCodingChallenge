//
//  FKFlickrCollectionsGetInfo.h
//  FlickrKit
//
//  Generated by FKAPIBuilder on 19 Sep, 2014 at 10:49.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrAPIMethod.h"

typedef enum {
	FKFlickrCollectionsGetInfoError_CollectionNotFound = 1,		 /* The requested collection could not be found or is not visible to the calling user. */
	FKFlickrCollectionsGetInfoError_SSLIsRequired = 95,		 /* SSL is required to access the Flickr API. */
	FKFlickrCollectionsGetInfoError_InvalidSignature = 96,		 /* The passed signature was invalid. */
	FKFlickrCollectionsGetInfoError_MissingSignature = 97,		 /* The call required signing but no signature was sent. */
	FKFlickrCollectionsGetInfoError_LoginFailedOrInvalidAuthToken = 98,		 /* The login details or auth token passed were invalid. */
	FKFlickrCollectionsGetInfoError_UserNotLoggedInOrInsufficientPermissions = 99,		 /* The method requires user authentication but the user was not logged in, or the authenticated method call did not have the required permissions. */
	FKFlickrCollectionsGetInfoError_InvalidAPIKey = 100,		 /* The API key passed was not valid or has expired. */
	FKFlickrCollectionsGetInfoError_ServiceCurrentlyUnavailable = 105,		 /* The requested service is temporarily unavailable. */
	FKFlickrCollectionsGetInfoError_WriteOperationFailed = 106,		 /* The requested operation failed due to a temporary issue. */
	FKFlickrCollectionsGetInfoError_FormatXXXNotFound = 111,		 /* The requested response format was not found. */
	FKFlickrCollectionsGetInfoError_MethodXXXNotFound = 112,		 /* The requested method was not found. */
	FKFlickrCollectionsGetInfoError_InvalidSOAPEnvelope = 114,		 /* The SOAP envelope send in the request could not be parsed. */
	FKFlickrCollectionsGetInfoError_InvalidXMLRPCMethodCall = 115,		 /* The XML-RPC request document could not be parsed. */
	FKFlickrCollectionsGetInfoError_BadURLFound = 116,		 /* One or more arguments contained a URL that has been used for abuse on Flickr. */

} FKFlickrCollectionsGetInfoError;

/*

Returns information for a single collection.  Currently can only be called by the collection owner, this may change.


Response:

<collection id="12-72157594586579649" child_count="6" datecreate="1173812218" iconlarge="http://farm1.static.flickr.com/187/cols/73743fac2cf79_l.jpg" iconsmall="http://farm1.static.flickr.com/187/cols/72157594586579649_43fac2cf79_s.jpg" server="187" secret="36">
<title>All My Photos</title>
<description>Photos!</description>
<iconphotos>
<photo id="14" owner="12@N01" secret="b57ba5c" server="51" farm="1" title="in full cap and gown" ispublic="1" isfriend="0" isfamily="0"/>
<photo id="15" owner="12@N01" secret="ba1c2a8" server="58" farm="1" title="Just beyond the door" ispublic="0" isfriend="1" isfamily="0"/>
<photo id="17" owner="12@N01" secret="0001969" server="73" farm="1" title="IMG_3787.JPG" ispublic="1" isfriend="0" isfamily="0"/>
....
</iconphotos>
</collection>

*/
@interface FKFlickrCollectionsGetInfo : NSObject <FKFlickrAPIMethod>

/* The ID of the collection to fetch information for. */
@property (nonatomic, copy) NSString *collection_id; /* (Required) */


@end