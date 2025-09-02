# UsersAPI

All URIs are relative to *https://rebrickable.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**usersAllpartsList**](UsersAPI.md#usersallpartslist) | **GET** /api/v3/users/{user_token}/allparts/ | Get a list of all the Parts in all the user&#39;s Part Lists as well as the Parts inside Sets in the user&#39;s Set Lists.
[**usersBadgesList**](UsersAPI.md#usersbadgeslist) | **GET** /api/v3/users/badges/ | Get a list of all the available Badges
[**usersBadgesRead**](UsersAPI.md#usersbadgesread) | **GET** /api/v3/users/badges/{id}/ | Get details about a specific Badge
[**usersBuildRead**](UsersAPI.md#usersbuildread) | **GET** /api/v3/users/{user_token}/build/{set_num}/ | Find out how many parts the user needs to build the specified Set.
[**usersLostPartsCreate**](UsersAPI.md#userslostpartscreate) | **POST** /api/v3/users/{user_token}/lost_parts/ | Add one or more Lost Parts to the user.
[**usersLostPartsDelete**](UsersAPI.md#userslostpartsdelete) | **DELETE** /api/v3/users/{user_token}/lost_parts/{id}/ | Remove the Lost Part from the user.
[**usersLostPartsList**](UsersAPI.md#userslostpartslist) | **GET** /api/v3/users/{user_token}/lost_parts/ | Get a list of all the Lost Parts from the user&#39;s LEGO collection.
[**usersMinifigsList**](UsersAPI.md#usersminifigslist) | **GET** /api/v3/users/{user_token}/minifigs/ | Get a list of all the Minifigs in all the user&#39;s Sets. Note that this is a read-only list as Minifigs are
[**usersPartlistsCreate**](UsersAPI.md#userspartlistscreate) | **POST** /api/v3/users/{user_token}/partlists/ | Add a new Part List.
[**usersPartlistsDelete**](UsersAPI.md#userspartlistsdelete) | **DELETE** /api/v3/users/{user_token}/partlists/{list_id}/ | Delete a Part List and all it&#39;s Parts.
[**usersPartlistsList**](UsersAPI.md#userspartlistslist) | **GET** /api/v3/users/{user_token}/partlists/ | Get a list of all the user&#39;s Part Lists.
[**usersPartlistsPartialUpdate**](UsersAPI.md#userspartlistspartialupdate) | **PATCH** /api/v3/users/{user_token}/partlists/{list_id}/ | Update an existing Part List&#39;s details.
[**usersPartlistsPartsCreate**](UsersAPI.md#userspartlistspartscreate) | **POST** /api/v3/users/{user_token}/partlists/{list_id}/parts/ | Add one or more Parts to the Part List.
[**usersPartlistsPartsDelete**](UsersAPI.md#userspartlistspartsdelete) | **DELETE** /api/v3/users/{user_token}/partlists/{list_id}/parts/{part_num}/{color_id}/ | Delete a Part from the Part List.
[**usersPartlistsPartsList**](UsersAPI.md#userspartlistspartslist) | **GET** /api/v3/users/{user_token}/partlists/{list_id}/parts/ | Get a list of all the Parts in a specific Part List.
[**usersPartlistsPartsRead**](UsersAPI.md#userspartlistspartsread) | **GET** /api/v3/users/{user_token}/partlists/{list_id}/parts/{part_num}/{color_id}/ | Get details about a specific Part in the Part List.
[**usersPartlistsPartsUpdate**](UsersAPI.md#userspartlistspartsupdate) | **PUT** /api/v3/users/{user_token}/partlists/{list_id}/parts/{part_num}/{color_id}/ | Replace an existing Part&#39;s details in the Part List.
[**usersPartlistsRead**](UsersAPI.md#userspartlistsread) | **GET** /api/v3/users/{user_token}/partlists/{list_id}/ | Get details about a specific Part List.
[**usersPartlistsUpdate**](UsersAPI.md#userspartlistsupdate) | **PUT** /api/v3/users/{user_token}/partlists/{list_id}/ | Replace an existing Part List&#39;s details.
[**usersPartsList**](UsersAPI.md#userspartslist) | **GET** /api/v3/users/{user_token}/parts/ | Get a list of all the Parts in all the user&#39;s Part Lists.
[**usersProfileRead**](UsersAPI.md#usersprofileread) | **GET** /api/v3/users/{user_token}/profile/ | Get details about a specific user.
[**usersSetlistsCreate**](UsersAPI.md#userssetlistscreate) | **POST** /api/v3/users/{user_token}/setlists/ | Add a new Set List.
[**usersSetlistsDelete**](UsersAPI.md#userssetlistsdelete) | **DELETE** /api/v3/users/{user_token}/setlists/{list_id}/ | Delete a Set List and all it&#39;s Sets.
[**usersSetlistsList**](UsersAPI.md#userssetlistslist) | **GET** /api/v3/users/{user_token}/setlists/ | Get a list of all the user&#39;s Set Lists.
[**usersSetlistsPartialUpdate**](UsersAPI.md#userssetlistspartialupdate) | **PATCH** /api/v3/users/{user_token}/setlists/{list_id}/ | Update an existing Set List&#39;s details.
[**usersSetlistsRead**](UsersAPI.md#userssetlistsread) | **GET** /api/v3/users/{user_token}/setlists/{list_id}/ | Get details about a specific Set List.
[**usersSetlistsSetsCreate**](UsersAPI.md#userssetlistssetscreate) | **POST** /api/v3/users/{user_token}/setlists/{list_id}/sets/ | Add one or more Sets to the Set List. Existing Sets are unaffected.
[**usersSetlistsSetsDelete**](UsersAPI.md#userssetlistssetsdelete) | **DELETE** /api/v3/users/{user_token}/setlists/{list_id}/sets/{set_num}/ | Delete a Set from the Set List.
[**usersSetlistsSetsList**](UsersAPI.md#userssetlistssetslist) | **GET** /api/v3/users/{user_token}/setlists/{list_id}/sets/ | Get a list of all the Sets in a specific Set List.
[**usersSetlistsSetsPartialUpdate**](UsersAPI.md#userssetlistssetspartialupdate) | **PATCH** /api/v3/users/{user_token}/setlists/{list_id}/sets/{set_num}/ | Update an existing Set&#39;s details in the Set List.
[**usersSetlistsSetsRead**](UsersAPI.md#userssetlistssetsread) | **GET** /api/v3/users/{user_token}/setlists/{list_id}/sets/{set_num}/ | Get details about a specific Set in the Set List.
[**usersSetlistsSetsUpdate**](UsersAPI.md#userssetlistssetsupdate) | **PUT** /api/v3/users/{user_token}/setlists/{list_id}/sets/{set_num}/ | Replace an existing Set&#39;s details in the Set List.
[**usersSetlistsUpdate**](UsersAPI.md#userssetlistsupdate) | **PUT** /api/v3/users/{user_token}/setlists/{list_id}/ | Replace an existing Set List&#39;s details.
[**usersSetsCreate**](UsersAPI.md#userssetscreate) | **POST** /api/v3/users/{user_token}/sets/ | Add one or more Sets to the user&#39;s LEGO collection. Existing Sets are unaffected.
[**usersSetsDelete**](UsersAPI.md#userssetsdelete) | **DELETE** /api/v3/users/{user_token}/sets/{set_num}/ | Delete the Set from all the user&#39;s Set Lists.
[**usersSetsList**](UsersAPI.md#userssetslist) | **GET** /api/v3/users/{user_token}/sets/ | Get a list of all the Sets in the user&#39;s LEGO collection.
[**usersSetsRead**](UsersAPI.md#userssetsread) | **GET** /api/v3/users/{user_token}/sets/{set_num}/ | Get details about a specific Set in the user&#39;s LEGO collection.
[**usersSetsSyncCreate**](UsersAPI.md#userssetssynccreate) | **POST** /api/v3/users/{user_token}/sets/sync/ | Synchronise a user&#39;s Sets to the POSTed list.
[**usersSetsUpdate**](UsersAPI.md#userssetsupdate) | **PUT** /api/v3/users/{user_token}/sets/{set_num}/ | Update an existing Set&#39;s quantity in all Set Lists. This PUT call is different to others in that it will create
[**usersTokenCreate**](UsersAPI.md#userstokencreate) | **POST** /api/v3/users/_token/ | Generate a User Token to be used for authorising user account actions in subsequent calls. Username can be either


# **usersAllpartsList**
```swift
    open class func usersAllpartsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, partNum: String? = nil, partCatId: Double? = nil, colorId: Double? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Parts in all the user's Part Lists as well as the Parts inside Sets in the user's Set Lists.

Get a list of all the Parts in all the user's Part Lists as well as the Parts inside Sets in the user's Set Lists.  ###WARNING this call is very resource intensive, do not overuse it!  Optionally, filter by one or more of the below query parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let partNum = "partNum_example" // String |  (optional)
let partCatId = 987 // Double |  (optional)
let colorId = 987 // Double |  (optional)

// Get a list of all the Parts in all the user's Part Lists as well as the Parts inside Sets in the user's Set Lists.
UsersAPI.usersAllpartsList(userToken: userToken, page: page, pageSize: pageSize, partNum: partNum, partCatId: partCatId, colorId: colorId) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **partNum** | **String** |  | [optional] 
 **partCatId** | **Double** |  | [optional] 
 **colorId** | **Double** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersBadgesList**
```swift
    open class func usersBadgesList(page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the available Badges

Get a list of all the available Badges

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all the available Badges
UsersAPI.usersBadgesList(page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersBadgesRead**
```swift
    open class func usersBadgesRead(id: Int, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific Badge

Get details about a specific Badge

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | A unique integer value identifying this badge.
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get details about a specific Badge
UsersAPI.usersBadgesRead(id: id, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** | A unique integer value identifying this badge. | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersBuildRead**
```swift
    open class func usersBuildRead(setNum: String, userToken: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Find out how many parts the user needs to build the specified Set.

Find out how many parts the user needs to build the specified Set.  The user's default Build Settings will be used to calculate a Build Match % using their LEGO Collection of Sets and Parts.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 

// Find out how many parts the user needs to build the specified Set.
UsersAPI.usersBuildRead(setNum: setNum, userToken: userToken) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersLostPartsCreate**
```swift
    open class func usersLostPartsCreate(userToken: String, invPartId: Int, lostQuantity: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Add one or more Lost Parts to the user.

Add one or more Lost Parts to the user.  ### Single Part When adding a single Part, returns the successfully created Part (status 201) or details for why the Part could not be added. ### Multiple Parts To add multiple Parts, POST a JSON list of them (using a Content-Type header of 'application/json'). The inv_part_id field can be retrieved from the Set's inventory. e.g: `[{\"inv_part_id\": 806698, \"lost_quantity\": 3},   {\"inv_part_id\": 256007, \"lost_quantity\": 2}]` Returns a list of successfully added Parts. If the Part already exists or is unrecognised, it will be skipped.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let invPartId = 987 // Int | 
let lostQuantity = 987 // Int |  (optional)

// Add one or more Lost Parts to the user.
UsersAPI.usersLostPartsCreate(userToken: userToken, invPartId: invPartId, lostQuantity: lostQuantity) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **invPartId** | **Int** |  | 
 **lostQuantity** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersLostPartsDelete**
```swift
    open class func usersLostPartsDelete(id: String, userToken: String, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Remove the Lost Part from the user.

Remove the Lost Part from the user.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = "id_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Remove the Lost Part from the user.
UsersAPI.usersLostPartsDelete(id: id, userToken: userToken, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersLostPartsList**
```swift
    open class func usersLostPartsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Lost Parts from the user's LEGO collection.

Get a list of all the Lost Parts from the user's LEGO collection.  Optionally, filter by one or more of the below query parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all the Lost Parts from the user's LEGO collection.
UsersAPI.usersLostPartsList(userToken: userToken, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersMinifigsList**
```swift
    open class func usersMinifigsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, figSetNum: String? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Minifigs in all the user's Sets. Note that this is a read-only list as Minifigs are

Get a list of all the Minifigs in all the user's Sets. Note that this is a read-only list as Minifigs are automatically determined by the Sets in the user's Set Lists.  Minifigs that were manually added to Set Lists can be retrieved via the GET /api/v3/users/{user_token}/sets/ endpoint.  Optionally, filter by one or more of the below query parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let figSetNum = "figSetNum_example" // String |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Get a list of all the Minifigs in all the user's Sets. Note that this is a read-only list as Minifigs are
UsersAPI.usersMinifigsList(userToken: userToken, page: page, pageSize: pageSize, figSetNum: figSetNum, ordering: ordering, search: search) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **figSetNum** | **String** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsCreate**
```swift
    open class func usersPartlistsCreate(userToken: String, name: String, isBuildable: Bool? = nil, numParts: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Add a new Part List.

Add a new Part List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let name = "name_example" // String | 
let isBuildable = true // Bool |  (optional)
let numParts = 987 // Int |  (optional)

// Add a new Part List.
UsersAPI.usersPartlistsCreate(userToken: userToken, name: name, isBuildable: isBuildable, numParts: numParts) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **name** | **String** |  | 
 **isBuildable** | **Bool** |  | [optional] 
 **numParts** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsDelete**
```swift
    open class func usersPartlistsDelete(listId: String, userToken: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Delete a Part List and all it's Parts.

Delete a Part List and all it's Parts.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 

// Delete a Part List and all it's Parts.
UsersAPI.usersPartlistsDelete(listId: listId, userToken: userToken) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsList**
```swift
    open class func usersPartlistsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the user's Part Lists.

Get a list of all the user's Part Lists.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)

// Get a list of all the user's Part Lists.
UsersAPI.usersPartlistsList(userToken: userToken, page: page, pageSize: pageSize) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsPartialUpdate**
```swift
    open class func usersPartlistsPartialUpdate(listId: String, userToken: String, isBuildable: Bool? = nil, name: String? = nil, numParts: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Update an existing Part List's details.

Update an existing Part List's details.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let isBuildable = true // Bool |  (optional)
let name = "name_example" // String |  (optional)
let numParts = 987 // Int |  (optional)

// Update an existing Part List's details.
UsersAPI.usersPartlistsPartialUpdate(listId: listId, userToken: userToken, isBuildable: isBuildable, name: name, numParts: numParts) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **isBuildable** | **Bool** |  | [optional] 
 **name** | **String** |  | [optional] 
 **numParts** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsPartsCreate**
```swift
    open class func usersPartlistsPartsCreate(listId: String, userToken: String, partNum: String, quantity: Int, colorId: Int, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Add one or more Parts to the Part List.

Add one or more Parts to the Part List.  ### Single Part When adding a single Part, returns the successfully created Part (status 201) or details for why the Part could not be added. ### Multiple Parts To add multiple Parts, POST a JSON list of them (using a Content-Type header of 'application/json'). e.g: `[{\"part_num\":\"3001\", \"color_id\": 1, \"quantity\": 10},  {\"part_num\":\"3001\", \"color_id\": 2, \"quantity\": 20},  {\"part_num\":\"3002\", \"color_id\": 14, \"quantity\": 30}]` Returns a list of successfully added Parts. If the Part already exists or is unrecognised, it will be skipped.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let partNum = "partNum_example" // String | 
let quantity = 987 // Int | 
let colorId = 987 // Int | 

// Add one or more Parts to the Part List.
UsersAPI.usersPartlistsPartsCreate(listId: listId, userToken: userToken, partNum: partNum, quantity: quantity, colorId: colorId) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **partNum** | **String** |  | 
 **quantity** | **Int** |  | 
 **colorId** | **Int** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsPartsDelete**
```swift
    open class func usersPartlistsPartsDelete(listId: String, partNum: String, colorId: String, userToken: String, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Delete a Part from the Part List.

Delete a Part from the Part List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let partNum = "partNum_example" // String | 
let colorId = "colorId_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Delete a Part from the Part List.
UsersAPI.usersPartlistsPartsDelete(listId: listId, partNum: partNum, colorId: colorId, userToken: userToken, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **partNum** | **String** |  | 
 **colorId** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsPartsList**
```swift
    open class func usersPartlistsPartsList(listId: String, userToken: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Parts in a specific Part List.

Get a list of all the Parts in a specific Part List.  Optional parameter inc_part_details=1 can be used to return additional part fields, the same as for a single part lookup. Optional parameter inc_color_details=0 can be used to prevent color field expansion and reduce response sizes.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all the Parts in a specific Part List.
UsersAPI.usersPartlistsPartsList(listId: listId, userToken: userToken, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsPartsRead**
```swift
    open class func usersPartlistsPartsRead(listId: String, partNum: String, colorId: String, userToken: String, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific Part in the Part List.

Get details about a specific Part in the Part List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let partNum = "partNum_example" // String | 
let colorId = "colorId_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get details about a specific Part in the Part List.
UsersAPI.usersPartlistsPartsRead(listId: listId, partNum: partNum, colorId: colorId, userToken: userToken, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **partNum** | **String** |  | 
 **colorId** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsPartsUpdate**
```swift
    open class func usersPartlistsPartsUpdate(listId: String, partNum: String, colorId: String, userToken: String, quantity: Int, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Replace an existing Part's details in the Part List.

Replace an existing Part's details in the Part List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let partNum = "partNum_example" // String | 
let colorId = "colorId_example" // String | 
let userToken = "userToken_example" // String | 
let quantity = 987 // Int | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Replace an existing Part's details in the Part List.
UsersAPI.usersPartlistsPartsUpdate(listId: listId, partNum: partNum, colorId: colorId, userToken: userToken, quantity: quantity, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **partNum** | **String** |  | 
 **colorId** | **String** |  | 
 **userToken** | **String** |  | 
 **quantity** | **Int** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsRead**
```swift
    open class func usersPartlistsRead(listId: String, userToken: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific Part List.

Get details about a specific Part List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 

// Get details about a specific Part List.
UsersAPI.usersPartlistsRead(listId: listId, userToken: userToken) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartlistsUpdate**
```swift
    open class func usersPartlistsUpdate(listId: String, userToken: String, name: String, isBuildable: Bool? = nil, numParts: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Replace an existing Part List's details.

Replace an existing Part List's details.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let name = "name_example" // String | 
let isBuildable = true // Bool |  (optional)
let numParts = 987 // Int |  (optional)

// Replace an existing Part List's details.
UsersAPI.usersPartlistsUpdate(listId: listId, userToken: userToken, name: name, isBuildable: isBuildable, numParts: numParts) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **name** | **String** |  | 
 **isBuildable** | **Bool** |  | [optional] 
 **numParts** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersPartsList**
```swift
    open class func usersPartsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, partNum: String? = nil, partCatId: Double? = nil, colorId: Double? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Parts in all the user's Part Lists.

Get a list of all the Parts in all the user's Part Lists.  Optional parameter inc_part_details=1 can be used to return additional part fields, the same as for a single part lookup.  ###Set List logic Parts appearing in multiple Part Lists will be listed multiple times.  Optionally, filter by one or more of the below query parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let partNum = "partNum_example" // String |  (optional)
let partCatId = 987 // Double |  (optional)
let colorId = 987 // Double |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Get a list of all the Parts in all the user's Part Lists.
UsersAPI.usersPartsList(userToken: userToken, page: page, pageSize: pageSize, partNum: partNum, partCatId: partCatId, colorId: colorId, ordering: ordering, search: search) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **partNum** | **String** |  | [optional] 
 **partCatId** | **Double** |  | [optional] 
 **colorId** | **Double** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersProfileRead**
```swift
    open class func usersProfileRead(userToken: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific user.

Get details about a specific user.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 

// Get details about a specific user.
UsersAPI.usersProfileRead(userToken: userToken) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsCreate**
```swift
    open class func usersSetlistsCreate(userToken: String, name: String, isBuildable: Bool? = nil, numSets: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Add a new Set List.

Add a new Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let name = "name_example" // String | 
let isBuildable = true // Bool |  (optional)
let numSets = 987 // Int |  (optional)

// Add a new Set List.
UsersAPI.usersSetlistsCreate(userToken: userToken, name: name, isBuildable: isBuildable, numSets: numSets) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **name** | **String** |  | 
 **isBuildable** | **Bool** |  | [optional] 
 **numSets** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsDelete**
```swift
    open class func usersSetlistsDelete(listId: String, userToken: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Delete a Set List and all it's Sets.

Delete a Set List and all it's Sets.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 

// Delete a Set List and all it's Sets.
UsersAPI.usersSetlistsDelete(listId: listId, userToken: userToken) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsList**
```swift
    open class func usersSetlistsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the user's Set Lists.

Get a list of all the user's Set Lists.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)

// Get a list of all the user's Set Lists.
UsersAPI.usersSetlistsList(userToken: userToken, page: page, pageSize: pageSize) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsPartialUpdate**
```swift
    open class func usersSetlistsPartialUpdate(listId: String, userToken: String, isBuildable: Bool? = nil, name: String? = nil, numSets: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Update an existing Set List's details.

Update an existing Set List's details.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let isBuildable = true // Bool |  (optional)
let name = "name_example" // String |  (optional)
let numSets = 987 // Int |  (optional)

// Update an existing Set List's details.
UsersAPI.usersSetlistsPartialUpdate(listId: listId, userToken: userToken, isBuildable: isBuildable, name: name, numSets: numSets) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **isBuildable** | **Bool** |  | [optional] 
 **name** | **String** |  | [optional] 
 **numSets** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsRead**
```swift
    open class func usersSetlistsRead(listId: String, userToken: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific Set List.

Get details about a specific Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 

// Get details about a specific Set List.
UsersAPI.usersSetlistsRead(listId: listId, userToken: userToken) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsSetsCreate**
```swift
    open class func usersSetlistsSetsCreate(listId: String, userToken: String, setNum: String, quantity: Int? = nil, includeSpares: Bool? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Add one or more Sets to the Set List. Existing Sets are unaffected.

Add one or more Sets to the Set List. Existing Sets are unaffected.  ### Single Set When adding a single Set, returns the successfully created Set (status 201) or details for why the Set could not be added. ### Multiple Sets To add multiple Sets, POST a JSON list of them (using a Content-Type header of 'application/json'). e.g: `[{\"set_num\":\"8043-1\", \"quantity\": 1},  {\"set_num\":\"8110-1\", \"quantity\": 2, \"include_spares\": \"False\"}]` Returns a list of successfully added Sets. If the Set already exists or is unrecognised, it will be skipped.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let setNum = "setNum_example" // String | 
let quantity = 987 // Int |  (optional)
let includeSpares = true // Bool |  (optional)

// Add one or more Sets to the Set List. Existing Sets are unaffected.
UsersAPI.usersSetlistsSetsCreate(listId: listId, userToken: userToken, setNum: setNum, quantity: quantity, includeSpares: includeSpares) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **setNum** | **String** |  | 
 **quantity** | **Int** |  | [optional] 
 **includeSpares** | **Bool** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsSetsDelete**
```swift
    open class func usersSetlistsSetsDelete(listId: String, setNum: String, userToken: String, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Delete a Set from the Set List.

Delete a Set from the Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Delete a Set from the Set List.
UsersAPI.usersSetlistsSetsDelete(listId: listId, setNum: setNum, userToken: userToken, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsSetsList**
```swift
    open class func usersSetlistsSetsList(listId: String, userToken: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Sets in a specific Set List.

Get a list of all the Sets in a specific Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all the Sets in a specific Set List.
UsersAPI.usersSetlistsSetsList(listId: listId, userToken: userToken, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsSetsPartialUpdate**
```swift
    open class func usersSetlistsSetsPartialUpdate(listId: String, setNum: String, userToken: String, ordering: String? = nil, quantity: Int? = nil, includeSpares: Bool? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Update an existing Set's details in the Set List.

Update an existing Set's details in the Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let quantity = 987 // Int |  (optional)
let includeSpares = true // Bool |  (optional)

// Update an existing Set's details in the Set List.
UsersAPI.usersSetlistsSetsPartialUpdate(listId: listId, setNum: setNum, userToken: userToken, ordering: ordering, quantity: quantity, includeSpares: includeSpares) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **quantity** | **Int** |  | [optional] 
 **includeSpares** | **Bool** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsSetsRead**
```swift
    open class func usersSetlistsSetsRead(listId: String, setNum: String, userToken: String, ordering: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific Set in the Set List.

Get details about a specific Set in the Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get details about a specific Set in the Set List.
UsersAPI.usersSetlistsSetsRead(listId: listId, setNum: setNum, userToken: userToken, ordering: ordering) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsSetsUpdate**
```swift
    open class func usersSetlistsSetsUpdate(listId: String, setNum: String, userToken: String, ordering: String? = nil, quantity: Int? = nil, includeSpares: Bool? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Replace an existing Set's details in the Set List.

Replace an existing Set's details in the Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let quantity = 987 // Int |  (optional)
let includeSpares = true // Bool |  (optional)

// Replace an existing Set's details in the Set List.
UsersAPI.usersSetlistsSetsUpdate(listId: listId, setNum: setNum, userToken: userToken, ordering: ordering, quantity: quantity, includeSpares: includeSpares) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **quantity** | **Int** |  | [optional] 
 **includeSpares** | **Bool** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetlistsUpdate**
```swift
    open class func usersSetlistsUpdate(listId: String, userToken: String, name: String, isBuildable: Bool? = nil, numSets: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Replace an existing Set List's details.

Replace an existing Set List's details.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let listId = "listId_example" // String | 
let userToken = "userToken_example" // String | 
let name = "name_example" // String | 
let isBuildable = true // Bool |  (optional)
let numSets = 987 // Int |  (optional)

// Replace an existing Set List's details.
UsersAPI.usersSetlistsUpdate(listId: listId, userToken: userToken, name: name, isBuildable: isBuildable, numSets: numSets) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listId** | **String** |  | 
 **userToken** | **String** |  | 
 **name** | **String** |  | 
 **isBuildable** | **Bool** |  | [optional] 
 **numSets** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetsCreate**
```swift
    open class func usersSetsCreate(userToken: String, setNum: String, quantity: Int? = nil, includeSpares: Bool? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Add one or more Sets to the user's LEGO collection. Existing Sets are unaffected.

Add one or more Sets to the user's LEGO collection. Existing Sets are unaffected.  ### Set List logic The Set List used when adding sets is chosen in the following order: 1. If no Set Lists exist, one will be created and used 2. User's configured default Set List for Imports 3. The first Set List alphabetically  ### Single Set When adding a single Set, returns the successfully created Set (status 201) or details for why the Set could not be added. ### Multiple Sets To add multiple Sets, POST a JSON list of them (using a Content-Type header of 'application/json'). e.g: `[{\"set_num\":\"8043-1\", \"quantity\": 1},  {\"set_num\":\"8110-1\", \"quantity\": 2, \"include_spares\": \"False\"}]` Returns a list of successfully added Sets. If the Set already exists or is unrecognised, it will be skipped.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let setNum = "setNum_example" // String | 
let quantity = 987 // Int |  (optional)
let includeSpares = true // Bool |  (optional)

// Add one or more Sets to the user's LEGO collection. Existing Sets are unaffected.
UsersAPI.usersSetsCreate(userToken: userToken, setNum: setNum, quantity: quantity, includeSpares: includeSpares) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **setNum** | **String** |  | 
 **quantity** | **Int** |  | [optional] 
 **includeSpares** | **Bool** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetsDelete**
```swift
    open class func usersSetsDelete(setNum: String, userToken: String, setNum2: String? = nil, themeId: Double? = nil, minYear: Double? = nil, maxYear: Double? = nil, minParts: Double? = nil, maxParts: Double? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Delete the Set from all the user's Set Lists.

Delete the Set from all the user's Set Lists.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let setNum2 = "setNum2_example" // String |  (optional)
let themeId = 987 // Double |  (optional)
let minYear = 987 // Double |  (optional)
let maxYear = 987 // Double |  (optional)
let minParts = 987 // Double |  (optional)
let maxParts = 987 // Double |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Delete the Set from all the user's Set Lists.
UsersAPI.usersSetsDelete(setNum: setNum, userToken: userToken, setNum2: setNum2, themeId: themeId, minYear: minYear, maxYear: maxYear, minParts: minParts, maxParts: maxParts, ordering: ordering, search: search) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **setNum2** | **String** |  | [optional] 
 **themeId** | **Double** |  | [optional] 
 **minYear** | **Double** |  | [optional] 
 **maxYear** | **Double** |  | [optional] 
 **minParts** | **Double** |  | [optional] 
 **maxParts** | **Double** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetsList**
```swift
    open class func usersSetsList(userToken: String, page: Int? = nil, pageSize: Int? = nil, setNum: String? = nil, themeId: Double? = nil, minYear: Double? = nil, maxYear: Double? = nil, minParts: Double? = nil, maxParts: Double? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get a list of all the Sets in the user's LEGO collection.

Get a list of all the Sets in the user's LEGO collection.  ### Set List logic Sets appearing in multiple Set Lists will be listed multiple times.  Optionally, filter by one or more of the below query parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let setNum = "setNum_example" // String |  (optional)
let themeId = 987 // Double |  (optional)
let minYear = 987 // Double |  (optional)
let maxYear = 987 // Double |  (optional)
let minParts = 987 // Double |  (optional)
let maxParts = 987 // Double |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Get a list of all the Sets in the user's LEGO collection.
UsersAPI.usersSetsList(userToken: userToken, page: page, pageSize: pageSize, setNum: setNum, themeId: themeId, minYear: minYear, maxYear: maxYear, minParts: minParts, maxParts: maxParts, ordering: ordering, search: search) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **setNum** | **String** |  | [optional] 
 **themeId** | **Double** |  | [optional] 
 **minYear** | **Double** |  | [optional] 
 **maxYear** | **Double** |  | [optional] 
 **minParts** | **Double** |  | [optional] 
 **maxParts** | **Double** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetsRead**
```swift
    open class func usersSetsRead(setNum: String, userToken: String, setNum2: String? = nil, themeId: Double? = nil, minYear: Double? = nil, maxYear: Double? = nil, minParts: Double? = nil, maxParts: Double? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Get details about a specific Set in the user's LEGO collection.

Get details about a specific Set in the user's LEGO collection.  ### Set List logic Because this merges sets found across all Set Lists the fields list_id and include_spares may not be accurate unless the Set actually only exists in a single Set List.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let setNum2 = "setNum2_example" // String |  (optional)
let themeId = 987 // Double |  (optional)
let minYear = 987 // Double |  (optional)
let maxYear = 987 // Double |  (optional)
let minParts = 987 // Double |  (optional)
let maxParts = 987 // Double |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Get details about a specific Set in the user's LEGO collection.
UsersAPI.usersSetsRead(setNum: setNum, userToken: userToken, setNum2: setNum2, themeId: themeId, minYear: minYear, maxYear: maxYear, minParts: minParts, maxParts: maxParts, ordering: ordering, search: search) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **setNum2** | **String** |  | [optional] 
 **themeId** | **Double** |  | [optional] 
 **minYear** | **Double** |  | [optional] 
 **maxYear** | **Double** |  | [optional] 
 **minParts** | **Double** |  | [optional] 
 **maxParts** | **Double** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetsSyncCreate**
```swift
    open class func usersSetsSyncCreate(userToken: String, setNum: String, quantity: Int? = nil, includeSpares: Bool? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Synchronise a user's Sets to the POSTed list.

Synchronise a user's Sets to the POSTed list.  ### Set List logic This is used to completely replace the user's Sets with those in the supplied list. It will remove any Sets in Rebrickable that are not found in the supplied list. It will attempt to keep any current Rebrickable Sets in their existing Set Lists, and will add any new Sets found into the Default Set List for Imports in the user's settings. ### Single Set When adding a single Set, returns the successfully created Set (status 201) or details for why the Set could not be added. ### Multiple Sets To add multiple Sets, POST a JSON list of them (using a Content-Type header of 'application/json'). e.g: `[{\"set_num\":\"8043-1\", \"quantity\": 1},  {\"set_num\":\"8110-1\", \"quantity\": 2, \"include_spares\": \"False\"}]` Returns a list of successfully added Sets. If the Set is unrecognised, it will be skipped.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userToken = "userToken_example" // String | 
let setNum = "setNum_example" // String | 
let quantity = 987 // Int |  (optional)
let includeSpares = true // Bool |  (optional)

// Synchronise a user's Sets to the POSTed list.
UsersAPI.usersSetsSyncCreate(userToken: userToken, setNum: setNum, quantity: quantity, includeSpares: includeSpares) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userToken** | **String** |  | 
 **setNum** | **String** |  | 
 **quantity** | **Int** |  | [optional] 
 **includeSpares** | **Bool** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersSetsUpdate**
```swift
    open class func usersSetsUpdate(setNum: String, userToken: String, setNum2: String? = nil, themeId: Double? = nil, minYear: Double? = nil, maxYear: Double? = nil, minParts: Double? = nil, maxParts: Double? = nil, ordering: String? = nil, search: String? = nil, quantity: Int? = nil, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Update an existing Set's quantity in all Set Lists. This PUT call is different to others in that it will create

Update an existing Set's quantity in all Set Lists. This PUT call is different to others in that it will create the Set if it doesn't already exist, and it will delete the Set if you pass a quantity of 0.  ### Set List logic * Default Set List = user's configured default import list or the first alphabetically if none exist. * Increasing quantity = add to Set in default Set List if it exists, else add it there * Decreasing quantity = remove from Set in default Set List first, then from remaining lists until done

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let setNum = "setNum_example" // String | 
let userToken = "userToken_example" // String | 
let setNum2 = "setNum2_example" // String |  (optional)
let themeId = 987 // Double |  (optional)
let minYear = 987 // Double |  (optional)
let maxYear = 987 // Double |  (optional)
let minParts = 987 // Double |  (optional)
let maxParts = 987 // Double |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)
let quantity = 987 // Int |  (optional)

// Update an existing Set's quantity in all Set Lists. This PUT call is different to others in that it will create
UsersAPI.usersSetsUpdate(setNum: setNum, userToken: userToken, setNum2: setNum2, themeId: themeId, minYear: minYear, maxYear: maxYear, minParts: minParts, maxParts: maxParts, ordering: ordering, search: search, quantity: quantity) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setNum** | **String** |  | 
 **userToken** | **String** |  | 
 **setNum2** | **String** |  | [optional] 
 **themeId** | **Double** |  | [optional] 
 **minYear** | **Double** |  | [optional] 
 **maxYear** | **Double** |  | [optional] 
 **minParts** | **Double** |  | [optional] 
 **maxParts** | **Double** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 
 **quantity** | **Int** |  | [optional] 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersTokenCreate**
```swift
    open class func usersTokenCreate(username: String, password: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Generate a User Token to be used for authorising user account actions in subsequent calls. Username can be either

Generate a User Token to be used for authorising user account actions in subsequent calls. Username can be either  the actual username or the user's email address.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let username = "username_example" // String | Username (or email) of user
let password = "password_example" // String | Password of user

// Generate a User Token to be used for authorising user account actions in subsequent calls. Username can be either
UsersAPI.usersTokenCreate(username: username, password: password) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String** | Username (or email) of user | 
 **password** | **String** | Password of user | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

