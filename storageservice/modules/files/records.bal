// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerinax/'client.config;

# Azure File Service Configuration.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    *config:ConnectionConfig;
    never auth?;
    # Access key or Shared Access Signature for Azure Storage Account 
    @display {
        label: "",
        kind: "password"
    }
    string accessKeyOrSAS;
    # Name of the Azure Storage account
    string accountName;
    # Holds the used authorization method from the enum AuthorizationMethod
    AuthorizationMethod authorizationMethod;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_1_1;
|};

# Represents a list of FileShares.
#
# + Shares - Shares type record
public type SharesList record {
    Shares Shares;
};

# Represents a File share or FileShare array.
#
# + Share - An array of shares or a share record
public type Shares record {
    ShareItem[]|ShareItem Share;
};

# Represents a share.
#
# + Name - Name of the share
# + Properties - Properties of the share
public type ShareItem record {
    string Name;
    PropertiesItem Properties;
};

# Represents Properties of the share.
#
# + Last\-Modified - Last Modified date and time
# + Quota - Quota of the fileShare
# + Etag - Etag given by the fileShare
# + AccessTier - AccessTier of the fileShare
public type PropertiesItem record {
    string 'Last\-Modified;
    string Quota;
    string Etag?;
    string AccessTier?;
};

# Represents the file service properties list.
#
# + StorageServiceProperties - Storage Service Properties record
public type FileServicePropertiesList record {
    StorageServicePropertiesType StorageServiceProperties;
};

# Represents the storage service properties type record.
#
# + HourMetrics - Provides a summary of request statistics grouped by API in hourly aggregates
# + MinuteMetrics - Provides a summary of request statistics grouped by API for each minute
# + Cors - Groups all CORS rules
# + ProtocolSettings - Groups the settings for file system protocols
public type StorageServicePropertiesType record {
    MetricsType HourMetrics?;
    MetricsType MinuteMetrics?;
    string|CorsType Cors?;
    ProtocolSettingsType ProtocolSettings?;
};

# Represents the Storage Analytics HourMetrics/MinuteMetrics settings.
#
# + Version - The version of Storage Analytics to configure
# + Enabled - Indicates whether metrics are enabled for the File service
# + IncludeAPIs - Indicates whether metrics should generate summary statistics for called API operations
# + RetentionPolicy - Indicates whether metrics should generate summary statistics for called API operations
public type MetricsType record {
    string Version;
    string|boolean Enabled?;
    string|boolean IncludeAPIs?;
    RetentionPolicyType RetentionPolicy?;
};

# Contains the CORS rules.
#
# + CorsRules - Represents the CORS rules
public type CorsType record {
    CoreRulesType CorsRules?;
};

# Contains the Retention Policy details.
#
# + Enabled - Indicates whether metrics are enabled for the File service
# + Days - Indicates the number of days that metrics data should be retained
public type RetentionPolicyType record {
    string Enabled?;
    string Days?;
};

# Represents a CORS rules.
#
# + AllowedOrigins - A comma-separated list of origin domains that will be allowed via CORS, or "*" to allow all domains
# + AllowedMethods - A comma-separated list of response headers to expose to CORS clients
# + MaxAgeInSeconds - The number of seconds that the client/browser should cache a preflight response
# + AllowedHeaders - A comma-separated list of headers allowed to be part of the cross-origin request
# + ExposedHeaders - A comma-separated list of HTTP methods that are allowed to be executed by the origin
public type CoreRulesType record {
    string AllowedOrigins?;
    string AllowedMethods?;
    string MaxAgeInSeconds?;
    string AllowedHeaders?;
    string ExposedHeaders?;
};

# Groups the settings for file system protocols.
#
# + SMB - Represents SMB type variable 
public type ProtocolSettingsType record {
    SMBType SMB?;
};

# Groups the settings for SMB.
#
# + Multichannel - Contains multi channel type record
public type SMBType record {
    MultichannelType Multichannel?;
};

# Contains the settings for SMB multichannel.
#
# + Enabled - Toggles the state of SMB multichannel
public type MultichannelType record {
    string Enabled?;
};

# The types of records, which support the  azure operations.
public type AzureRecord FileServicePropertiesList|SharesList;

# The type description of the nested records.
public type AzureRecordType typedesc<AzureRecord>;

# Represnts an Azure directory.
#
# + Name - Name of the azure directory
# + Properties - Properties of the directory
public type Directory record {
    string Name;
    PropertiesFileItem|EMPTY_STRING Properties?;
};

# Represents an Azure file.
#
# + Name - Name of the azure file
# + Properties - Properties of the azure file
public type File record {
    string Name;
    PropertiesFileItem|EMPTY_STRING Properties?;
};

# Represents the details of the Properties.
#
# + Content\-Length - Content Length of the file
public type PropertiesFileItem record {
    string 'Content\-Length?;
};

# Represents a list of files.
#
# + File - A file of list of files
# + Marker - Marker for the list
# + MaxResults - limits number of results in the list
public type FileList record {
    File[]|File File;
    string Marker?;
    int MaxResults?;
};

# Represents a list of  azure directories.
#
# + Directory - A directory or a list of directory
# + Marker - Marker for the list
# + MaxResults - limits number of results in the list
public type DirectoryList record {
    Directory[]|Directory Directory;
    string Marker?;
    int MaxResults?;
};

# Represents a range of a file content.
#
# + Ranges - A list of Ranges
public type RangeList record {
    string|RangeItemList Ranges;
};

# Represents a range item list as a record.
#
# + Range - Range item
public type RangeItemList record {
    RangeItem Range;
};

# Represents a range item as a record.
#
# + Start - Start byte
# + End - End byte
public type RangeItem record {
    string Start;
    string End;
};

# Represents different types of  Request parameters.
#
# + fileShareName - Name of the fileshare
# + azureDirectoryName - Name of the azure directory
# + azureFileName - Name of the file name
# + azureDirectoryPath - Path of the azure directory
# + SearchPrefix - Search prefix word
# + maxResult - Maximum number of search results in the response
# + marker - Marker to the left items if any
# + newDirectoryName - Name of the new directory to be created 
# + fileSizeInByte - Size of the file in bytes
# + localFilePath - Path to the local location of a file
public type RequestParameterList record {
    string fileShareName;
    string azureDirectoryName?;
    string azureFileName?;
    string azureDirectoryPath?;
    string SearchPrefix?;
    int maxResult?;
    int marker?;
    string newDirectoryName?;
    int fileSizeInByte?;
    string localFilePath?;
};

# Represents the necessary elements for generating the authorization header.
#
# + azureRequest - The http request object reference to be sent to the azure
# + azureConfig - An AzureConfiguration record
# + httpVerb - The http method of the request
# + uriParameterRecord - A URIRecord record
# + resourcePath - String value for the resource path if available any
# + requiredURIParameters - The map of required URI parameters for the request
type AuthorizationDetail record {
    http:Request azureRequest;
    ConnectionConfig azureConfig;
    http:HttpOperation httpVerb;
    URIRecord uriParameterRecord?;
    string resourcePath?;
    map<string> requiredURIParameters;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Records for Optional URI parameters                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Represents optional URI parameters for ListShares operation.
#
# + prefix - Filters the results to return only shares whose name begins with the specified prefix
# + marker - A string value that identifies the portion of the list to be returned with the next list operation
# + maxresults - Specifies the maximum number of shares to return. Maximum limit and default is 5000.
# + include - Specifies one or more datasets to include in the response like metadata, snapshots, deleted
# + timeout - The timeout parameter is expressed in seconds
public type ListShareURIParameters record {|
    string prefix?;
    string marker?;
    string maxresults?;
    string include?;
    string timeout?;
|};

# Represents optional URI parameters for GetDirectoryList operation.
#
# + prefix - Filters the results to return only directories whose name begins with the specified prefix
# + sharesnapshot - The share snapshot to query for the list of directories
# + marker - A string value that identifies the portion of the list to be returned with the next list operation
# + maxresults - The maximum number of shares to return. Maximum limit and default is 5000.
# + timeout - The timeout parameter is expressed in seconds
public type GetDirectoryListURIParameters record {|
    string prefix?;
    string sharesnapshot?;
    string marker?;
    string maxresults?;
    string timeout?;
|};

# Represents optional URI parameters for GetFileList operation.
#
# + prefix - Filters the results to return only files  whose name begins with the specified prefix
# + sharesnapshot - The share snapshot to query for the list of files and directories
# + marker - A string value that identifies the portion of the list to be returned with the next list operation
# + maxresults - The maximum number of shares to return. Maximum limit and default is 5000.
# + timeout - The timeout parameter is expressed in seconds
public type GetFileListURIParameters record {|
    string prefix?;
    string sharesnapshot?;
    string marker?;
    string maxresults?;
    string timeout?;
|};

# Represents optional URI parameters for get meta data operation.
#
# + sharesnapshot - The sharesnapshot parameter is an opaque DateTime value that, when present, specifies the share 
# snapshot to query to retrieve the metadata  
# + timeout - The timeout parameter is expressed in seconds
public type OptionalURIParametersFileMetaData record {|
    string sharesnapshot?;
    string timeout?;
|};

# Defines byte range of a file content
#
# + startByte - Start position, Example: 0  
# + endByte - End position, Example: 255
public type ContentRange record {|
    int startByte;
    int endByte;
|};

# Represents Response headers.
#
# + Date - A UTC date/time value that indicates the time at which the response was initiated  
# + x\-ms\-version - Indicates the service version that was used to execute the request 
# + x\-ms\-request\-id - Uniquely identifies the request that was made, and can be used for troubleshooting
public type ResponseHeaders record {
    string Date;
    string x\-ms\-version;
    string x\-ms\-request\-id;
};

# Represents File Metadata Result.
#
# + metadata - Metadata of file
# + eTag - ETag
# + lastModified - Date/time that the file was last modified
# + responseHeaders - Response headers from Azure
public type FileMetadataResult record {
    map<string> metadata;
    string eTag;
    string lastModified;
    ResponseHeaders responseHeaders;
};

# Represents optional request headers for CreateShareHeaders operation.
#
# + x\-ms\-share\-quota - Maximum size of the share, in GiB
# + x\-ms\-access\-tier - Access tier of the share
# + x\-ms\-enabled\-protocols - Enabled protocols on the share
public type RequestHeaders record {|
    string 'x\-ms\-share\-quota?;
    string 'x\-ms\-access\-tier?;
    string 'x\-ms\-enabled\-protocols?;
|};

# Defines the type of URIRecord for ListShareURIParameters, GetDirectoryListURIParameters, GetFileListURIParameters
public type URIRecord ListShareURIParameters|GetDirectoryListURIParameters|GetFileListURIParameters;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//User-Defined Errors                                                                                                 //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Represents a record for share not found error information.
#
# + storageAccountName - Name of the fileshare that error is related
public type NoSharesFoundErrorData record {
    string storageAccountName;
};

# Defines an error for ShareNotFound
public type NoSharesFoundError distinct error<NoSharesFoundErrorData>;

# Super type error returned by connector
public type Error ServerError|ClientError;

# Defines the details of an File Service error message.
#
# + httpStatus - HTTP status code associated with the error 
# + errorCode - Azure File Service error code  
# + message - Associated error message
public type ServerErrorDetail record {|
    int httpStatus;
    string errorCode;
    string message;
|};

# Error created by connector depending on server responses
public type ServerError distinct error<ServerErrorDetail>;

# Error created by connector when processing or invoking
public type ClientError ProcessingError|http:ClientError;

# Error created by connector when processing, transforming data
public type ProcessingError distinct error;

# Error for Http Status 409
public type ConflictError distinct ServerError;

# Error for Http Status 404
public type NotFoundError distinct ServerError;

# Error for Http Status 400
public type BadRequestError distinct ServerError;

# Error for Http Status 500
public type InternalServerError distinct ServerError;

# Error for Http Status 403
public type ForbiddenError distinct ServerError;
