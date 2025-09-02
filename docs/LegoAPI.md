# LegoAPI

All URIs are relative to *https://rebrickable.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**legoColorsList**](LegoAPI.md#legocolorslist) | **GET** /api/v3/lego/colors/ | Get a list of all Colors.
[**legoColorsRead**](LegoAPI.md#legocolorsread) | **GET** /api/v3/lego/colors/{id}/ | Get details about a specific Color.
[**legoElementsRead**](LegoAPI.md#legoelementsread) | **GET** /api/v3/lego/elements/{element_id}/ | Get details about a specific Element ID.
[**legoMinifigsList**](LegoAPI.md#legominifigslist) | **GET** /api/v3/lego/minifigs/ | Get a list of Minifigs.
[**legoMinifigsPartsList**](LegoAPI.md#legominifigspartslist) | **GET** /api/v3/lego/minifigs/{set_num}/parts/ | Get a list of all Inventory Parts in this Minifig.
[**legoMinifigsRead**](LegoAPI.md#legominifigsread) | **GET** /api/v3/lego/minifigs/{set_num}/ | Get details for a specific Minifig.
[**legoMinifigsSetsList**](LegoAPI.md#legominifigssetslist) | **GET** /api/v3/lego/minifigs/{set_num}/sets/ | Get a list of Sets a Minifig has appeared in.
[**legoPartCategoriesList**](LegoAPI.md#legopartcategorieslist) | **GET** /api/v3/lego/part_categories/ | Get a list of all Part Categories.
[**legoPartCategoriesRead**](LegoAPI.md#legopartcategoriesread) | **GET** /api/v3/lego/part_categories/{id}/ | Get details about a specific Part Category.
[**legoPartsColorsList**](LegoAPI.md#legopartscolorslist) | **GET** /api/v3/lego/parts/{part_num}/colors/ | Get a list of all Colors a Part has appeared in.
[**legoPartsColorsRead**](LegoAPI.md#legopartscolorsread) | **GET** /api/v3/lego/parts/{part_num}/colors/{color_id}/ | Get details about a specific Part/Color combination.
[**legoPartsColorsSetsList**](LegoAPI.md#legopartscolorssetslist) | **GET** /api/v3/lego/parts/{part_num}/colors/{color_id}/sets/ | Get a list of all Sets the Part/Color combination has appeard in.
[**legoPartsList**](LegoAPI.md#legopartslist) | **GET** /api/v3/lego/parts/ | Get a list of Parts.
[**legoPartsRead**](LegoAPI.md#legopartsread) | **GET** /api/v3/lego/parts/{part_num}/ | Get details about a specific Part.
[**legoSetsAlternatesList**](LegoAPI.md#legosetsalternateslist) | **GET** /api/v3/lego/sets/{set_num}/alternates/ | Get a list of MOCs which are Alternate Builds of a specific Set - i.e. all parts in the MOC can
[**legoSetsList**](LegoAPI.md#legosetslist) | **GET** /api/v3/lego/sets/ | Get a list of Sets, optionally filtered by any of the below parameters.
[**legoSetsMinifigsList**](LegoAPI.md#legosetsminifigslist) | **GET** /api/v3/lego/sets/{set_num}/minifigs/ | Get a list of all Inventory Minifigs in this Set.
[**legoSetsPartsList**](LegoAPI.md#legosetspartslist) | **GET** /api/v3/lego/sets/{set_num}/parts/ | Get a list of all Inventory Parts in this Set.
[**legoSetsRead**](LegoAPI.md#legosetsread) | **GET** /api/v3/lego/sets/{set_num}/ | Get details for a specific Set.
[**legoSetsSetsList**](LegoAPI.md#legosetssetslist) | **GET** /api/v3/lego/sets/{set_num}/sets/ | Get a list of all Inventory Sets in this Set.
[**legoThemesList**](LegoAPI.md#legothemeslist) | **GET** /api/v3/lego/themes/ | Return all Themes
[**legoThemesRead**](LegoAPI.md#legothemesread) | **GET** /api/v3/lego/themes/{id}/ | Return details for a specific Theme


# **legoColorsList**
```swift
    open class func legoColorsList(page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: ColorsList?, _ error: Error?) -> Void)
```

Get a list of all Colors.

Get a list of all Colors.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all Colors.
LegoAPI.legoColorsList(page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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

[**ColorsList**](ColorsList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoColorsRead**
```swift
    open class func legoColorsRead(id: String, ordering: String? = nil, completion: @escaping (_ data: Color?, _ error: Error?) -> Void)
```

Get details about a specific Color.

Get details about a specific Color.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let id = "id_example" // String | A unique value identifying this color.
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get details about a specific Color.
LegoAPI.legoColorsRead(id: id, ordering: ordering) { (response, error) in
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
 **id** | **String** | A unique value identifying this color. | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**Color**](Color.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoElementsRead**
```swift
    open class func legoElementsRead(elementId: String, completion: @escaping (_ data: Element?, _ error: Error?) -> Void)
```

Get details about a specific Element ID.

Get details about a specific Element ID.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let elementId = "elementId_example" // String | 

// Get details about a specific Element ID.
LegoAPI.legoElementsRead(elementId: elementId) { (response, error) in
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
 **elementId** | **String** |  | 

### Return type

[**Element**](Element.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoMinifigsList**
```swift
    open class func legoMinifigsList(page: Int? = nil, pageSize: Int? = nil, minParts: Double? = nil, maxParts: Double? = nil, inSetNum: String? = nil, inThemeId: String? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: SetList?, _ error: Error?) -> Void)
```

Get a list of Minifigs.

Get a list of Minifigs.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let minParts = 987 // Double |  (optional)
let maxParts = 987 // Double |  (optional)
let inSetNum = "inSetNum_example" // String |  (optional)
let inThemeId = "inThemeId_example" // String |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Get a list of Minifigs.
LegoAPI.legoMinifigsList(page: page, pageSize: pageSize, minParts: minParts, maxParts: maxParts, inSetNum: inSetNum, inThemeId: inThemeId, ordering: ordering, search: search) { (response, error) in
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
 **minParts** | **Double** |  | [optional] 
 **maxParts** | **Double** |  | [optional] 
 **inSetNum** | **String** |  | [optional] 
 **inThemeId** | **String** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

[**SetList**](SetList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoMinifigsPartsList**
```swift
    open class func legoMinifigsPartsList(setNum: String, page: Int? = nil, pageSize: Int? = nil, incPartDetails: Bool? = nil, completion: @escaping (_ data: SetPartsList?, _ error: Error?) -> Void)
```

Get a list of all Inventory Parts in this Minifig.

Get a list of all Inventory Parts in this Minifig.  Optional parameter inc_part_details=1 can be used to return additional part fields, the same as for a single part lookup.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let incPartDetails = true // Bool | Return additional part's fields. (optional)

// Get a list of all Inventory Parts in this Minifig.
LegoAPI.legoMinifigsPartsList(setNum: setNum, page: page, pageSize: pageSize, incPartDetails: incPartDetails) { (response, error) in
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
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **incPartDetails** | **Bool** | Return additional part&#39;s fields. | [optional] 

### Return type

[**SetPartsList**](SetPartsList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoMinifigsRead**
```swift
    open class func legoMinifigsRead(setNum: String, completion: @escaping (_ data: Set?, _ error: Error?) -> Void)
```

Get details for a specific Minifig.

Get details for a specific Minifig.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 

// Get details for a specific Minifig.
LegoAPI.legoMinifigsRead(setNum: setNum) { (response, error) in
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

### Return type

[**Set**](Set.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoMinifigsSetsList**
```swift
    open class func legoMinifigsSetsList(setNum: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: SetList?, _ error: Error?) -> Void)
```

Get a list of Sets a Minifig has appeared in.

Get a list of Sets a Minifig has appeared in.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of Sets a Minifig has appeared in.
LegoAPI.legoMinifigsSetsList(setNum: setNum, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**SetList**](SetList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartCategoriesList**
```swift
    open class func legoPartCategoriesList(page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: PartCategoriesList?, _ error: Error?) -> Void)
```

Get a list of all Part Categories.

Get a list of all Part Categories.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all Part Categories.
LegoAPI.legoPartCategoriesList(page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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

[**PartCategoriesList**](PartCategoriesList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartCategoriesRead**
```swift
    open class func legoPartCategoriesRead(id: Int, ordering: String? = nil, completion: @escaping (_ data: PartCategory?, _ error: Error?) -> Void)
```

Get details about a specific Part Category.

Get details about a specific Part Category.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let id = 987 // Int | A unique integer value identifying this part category.
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get details about a specific Part Category.
LegoAPI.legoPartCategoriesRead(id: id, ordering: ordering) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this part category. | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**PartCategory**](PartCategory.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartsColorsList**
```swift
    open class func legoPartsColorsList(partNum: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: PartColorsList?, _ error: Error?) -> Void)
```

Get a list of all Colors a Part has appeared in.

Get a list of all Colors a Part has appeared in.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let partNum = "partNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all Colors a Part has appeared in.
LegoAPI.legoPartsColorsList(partNum: partNum, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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
 **partNum** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**PartColorsList**](PartColorsList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartsColorsRead**
```swift
    open class func legoPartsColorsRead(partNum: String, colorId: String, completion: @escaping (_ data: PartColor?, _ error: Error?) -> Void)
```

Get details about a specific Part/Color combination.

Get details about a specific Part/Color combination.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let partNum = "partNum_example" // String | 
let colorId = "colorId_example" // String | 

// Get details about a specific Part/Color combination.
LegoAPI.legoPartsColorsRead(partNum: partNum, colorId: colorId) { (response, error) in
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
 **partNum** | **String** |  | 
 **colorId** | **String** |  | 

### Return type

[**PartColor**](PartColor.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartsColorsSetsList**
```swift
    open class func legoPartsColorsSetsList(partNum: String, colorId: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: SetList?, _ error: Error?) -> Void)
```

Get a list of all Sets the Part/Color combination has appeard in.

Get a list of all Sets the Part/Color combination has appeared in.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let partNum = "partNum_example" // String | 
let colorId = "colorId_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of all Sets the Part/Color combination has appeard in.
LegoAPI.legoPartsColorsSetsList(partNum: partNum, colorId: colorId, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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
 **partNum** | **String** |  | 
 **colorId** | **String** |  | 
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**SetList**](SetList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartsList**
```swift
    open class func legoPartsList(page: Int? = nil, pageSize: Int? = nil, partNum: String? = nil, partNums: String? = nil, partCatId: String? = nil, colorId: String? = nil, bricklinkId: String? = nil, brickowlId: String? = nil, legoId: String? = nil, ldrawId: String? = nil, ordering: String? = nil, search: String? = nil, incPartDetails: Bool? = nil, completion: @escaping (_ data: PartsList?, _ error: Error?) -> Void)
```

Get a list of Parts.

Get a list of Parts.  Optional parameter inc_part_details=1 can be used to return additional fields, the same as for a single part lookup.  The optional part_nums filter parameter should be a comma separated list of part_num without spaces.  Optionally filter by one or more of the below query parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let partNum = "partNum_example" // String | Rebrickable part_num (part number) to lookup. (optional)
let partNums = "partNums_example" // String | Comma separated list of part_num. (optional)
let partCatId = "partCatId_example" // String | Part category id (optional)
let colorId = "colorId_example" // String | Color id. (optional)
let bricklinkId = "bricklinkId_example" // String | Bricklink specific id. (optional)
let brickowlId = "brickowlId_example" // String | Brickowl specific id. (optional)
let legoId = "legoId_example" // String |  (optional)
let ldrawId = "ldrawId_example" // String |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)
let incPartDetails = true // Bool | Return additional part's fields. (optional)

// Get a list of Parts.
LegoAPI.legoPartsList(page: page, pageSize: pageSize, partNum: partNum, partNums: partNums, partCatId: partCatId, colorId: colorId, bricklinkId: bricklinkId, brickowlId: brickowlId, legoId: legoId, ldrawId: ldrawId, ordering: ordering, search: search, incPartDetails: incPartDetails) { (response, error) in
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
 **partNum** | **String** | Rebrickable part_num (part number) to lookup. | [optional] 
 **partNums** | **String** | Comma separated list of part_num. | [optional] 
 **partCatId** | **String** | Part category id | [optional] 
 **colorId** | **String** | Color id. | [optional] 
 **bricklinkId** | **String** | Bricklink specific id. | [optional] 
 **brickowlId** | **String** | Brickowl specific id. | [optional] 
 **legoId** | **String** |  | [optional] 
 **ldrawId** | **String** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 
 **incPartDetails** | **Bool** | Return additional part&#39;s fields. | [optional] 

### Return type

[**PartsList**](PartsList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoPartsRead**
```swift
    open class func legoPartsRead(partNum: String, completion: @escaping (_ data: Part?, _ error: Error?) -> Void)
```

Get details about a specific Part.

Get details about a specific Part.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let partNum = "partNum_example" // String | 

// Get details about a specific Part.
LegoAPI.legoPartsRead(partNum: partNum) { (response, error) in
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
 **partNum** | **String** |  | 

### Return type

[**Part**](Part.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoSetsAlternatesList**
```swift
    open class func legoSetsAlternatesList(setNum: String, page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: MocList?, _ error: Error?) -> Void)
```

Get a list of MOCs which are Alternate Builds of a specific Set - i.e. all parts in the MOC can

Get a list of MOCs which are Alternate Builds of a specific Set - i.e. all parts in the MOC can be found in the Set.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Get a list of MOCs which are Alternate Builds of a specific Set - i.e. all parts in the MOC can
LegoAPI.legoSetsAlternatesList(setNum: setNum, page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**MocList**](MocList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoSetsList**
```swift
    open class func legoSetsList(page: Int? = nil, pageSize: Int? = nil, themeId: String? = nil, minYear: Double? = nil, maxYear: Double? = nil, minParts: Double? = nil, maxParts: Double? = nil, ordering: String? = nil, search: String? = nil, completion: @escaping (_ data: SetList?, _ error: Error?) -> Void)
```

Get a list of Sets, optionally filtered by any of the below parameters.

Get a list of Sets, optionally filtered by any of the below parameters.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let themeId = "themeId_example" // String |  (optional)
let minYear = 987 // Double |  (optional)
let maxYear = 987 // Double |  (optional)
let minParts = 987 // Double |  (optional)
let maxParts = 987 // Double |  (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)
let search = "search_example" // String | A search term. (optional)

// Get a list of Sets, optionally filtered by any of the below parameters.
LegoAPI.legoSetsList(page: page, pageSize: pageSize, themeId: themeId, minYear: minYear, maxYear: maxYear, minParts: minParts, maxParts: maxParts, ordering: ordering, search: search) { (response, error) in
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
 **themeId** | **String** |  | [optional] 
 **minYear** | **Double** |  | [optional] 
 **maxYear** | **Double** |  | [optional] 
 **minParts** | **Double** |  | [optional] 
 **maxParts** | **Double** |  | [optional] 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 
 **search** | **String** | A search term. | [optional] 

### Return type

[**SetList**](SetList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoSetsMinifigsList**
```swift
    open class func legoSetsMinifigsList(setNum: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (_ data: SetMinifigsList?, _ error: Error?) -> Void)
```

Get a list of all Inventory Minifigs in this Set.

Get a list of all Inventory Minifigs in this Set.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)

// Get a list of all Inventory Minifigs in this Set.
LegoAPI.legoSetsMinifigsList(setNum: setNum, page: page, pageSize: pageSize) { (response, error) in
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
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 

### Return type

[**SetMinifigsList**](SetMinifigsList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoSetsPartsList**
```swift
    open class func legoSetsPartsList(setNum: String, page: Int? = nil, pageSize: Int? = nil, incPartDetails: Bool? = nil, completion: @escaping (_ data: SetPartsList?, _ error: Error?) -> Void)
```

Get a list of all Inventory Parts in this Set.

Get a list of all Inventory Parts in this Set.  Optional parameter inc_part_details=1 can be used to return additional part fields, the same as for a single part lookup. Optional parameter inc_minifig_parts=1 can be used to include minifig parts in this call. Optional parameter inc_color_details=0 can be used to prevent color field expansion and reduce response sizes.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let incPartDetails = true // Bool | Return additional part's fields. (optional)

// Get a list of all Inventory Parts in this Set.
LegoAPI.legoSetsPartsList(setNum: setNum, page: page, pageSize: pageSize, incPartDetails: incPartDetails) { (response, error) in
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
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 
 **incPartDetails** | **Bool** | Return additional part&#39;s fields. | [optional] 

### Return type

[**SetPartsList**](SetPartsList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoSetsRead**
```swift
    open class func legoSetsRead(setNum: String, completion: @escaping (_ data: Set?, _ error: Error?) -> Void)
```

Get details for a specific Set.

Get details for a specific Set.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 

// Get details for a specific Set.
LegoAPI.legoSetsRead(setNum: setNum) { (response, error) in
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

### Return type

[**Set**](Set.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoSetsSetsList**
```swift
    open class func legoSetsSetsList(setNum: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (_ data: SetList?, _ error: Error?) -> Void)
```

Get a list of all Inventory Sets in this Set.

Get a list of all Inventory Sets in this Set.

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let setNum = "setNum_example" // String | 
let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)

// Get a list of all Inventory Sets in this Set.
LegoAPI.legoSetsSetsList(setNum: setNum, page: page, pageSize: pageSize) { (response, error) in
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
 **page** | **Int** | A page number within the paginated result set. | [optional] 
 **pageSize** | **Int** | Number of results to return per page. | [optional] 

### Return type

[**SetList**](SetList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoThemesList**
```swift
    open class func legoThemesList(page: Int? = nil, pageSize: Int? = nil, ordering: String? = nil, completion: @escaping (_ data: ThemesList?, _ error: Error?) -> Void)
```

Return all Themes

Return all Themes

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let page = 987 // Int | A page number within the paginated result set. (optional)
let pageSize = 987 // Int | Number of results to return per page. (optional)
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Return all Themes
LegoAPI.legoThemesList(page: page, pageSize: pageSize, ordering: ordering) { (response, error) in
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

[**ThemesList**](ThemesList.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **legoThemesRead**
```swift
    open class func legoThemesRead(id: Int, ordering: String? = nil, completion: @escaping (_ data: Theme?, _ error: Error?) -> Void)
```

Return details for a specific Theme

Return details for a specific Theme

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import RebrickableLegoAPIClient

let id = 987 // Int | A unique integer value identifying this theme.
let ordering = "ordering_example" // String | Which field to use when ordering the results. (optional)

// Return details for a specific Theme
LegoAPI.legoThemesRead(id: id, ordering: ordering) { (response, error) in
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
 **id** | **Int** | A unique integer value identifying this theme. | 
 **ordering** | **String** | Which field to use when ordering the results. | [optional] 

### Return type

[**Theme**](Theme.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

