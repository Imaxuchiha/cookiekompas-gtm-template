___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "CookieKompas — Google Consent Mode v2",
  "categories": ["UTILITY", "TAG_MANAGEMENT"],
  "brand": {
    "id": "cookiekompas",
    "displayName": "CookieKompas"
  },
  "description": "Sets Google Consent Mode v2 defaults and loads the CookieKompas banner. Use with the Consent Initialization trigger.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "websiteId",
    "displayName": "Website ID",
    "simpleValueType": true,
    "valueValidators": [
      { "type": "NON_EMPTY", "errorMessage": "Required — find it on the Installation page in the dashboard." }
    ],
    "help": "The CookieKompas website UUID."
  },
  {
    "type": "TEXT",
    "name": "loaderUrl",
    "displayName": "Loader URL",
    "simpleValueType": true,
    "defaultValue": "https://cdn.example.com/consent.js",
    "valueValidators": [
      { "type": "NON_EMPTY", "errorMessage": "Required." }
    ],
    "help": "Full https URL to consent.js (shown in the dashboard)."
  },
  {
    "type": "TEXT",
    "name": "regionCodes",
    "displayName": "Region codes",
    "simpleValueType": true,
    "defaultValue": "EU,EEA,GB",
    "help": "Comma-separated ISO codes that the default-deny matrix applies to."
  },
  {
    "type": "CHECKBOX",
    "name": "denyAdStorage",
    "checkboxText": "ad_storage default: denied",
    "simpleValueType": true,
    "defaultValue": true
  },
  {
    "type": "CHECKBOX",
    "name": "denyAnalyticsStorage",
    "checkboxText": "analytics_storage default: denied",
    "simpleValueType": true,
    "defaultValue": true
  },
  {
    "type": "CHECKBOX",
    "name": "denyAdUserData",
    "checkboxText": "ad_user_data default: denied",
    "simpleValueType": true,
    "defaultValue": true
  },
  {
    "type": "CHECKBOX",
    "name": "denyAdPersonalization",
    "checkboxText": "ad_personalization default: denied",
    "simpleValueType": true,
    "defaultValue": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// CookieKompas — Sandboxed JS for GTM Template
// Sets Consent Mode v2 defaults (region-scoped) and injects the loader.

const setDefaultConsentState = require('setDefaultConsentState');
const injectScript = require('injectScript');
const createQueue = require('createQueue');
const dataLayerPush = createQueue('dataLayer');

const regionList = (data.regionCodes || '')
  .split(',')
  .map(function (r) { return r.trim(); })
  .filter(function (r) { return r.length > 0; });

const state = {
  ad_storage: data.denyAdStorage ? 'denied' : 'granted',
  analytics_storage: data.denyAnalyticsStorage ? 'denied' : 'granted',
  ad_user_data: data.denyAdUserData ? 'denied' : 'granted',
  ad_personalization: data.denyAdPersonalization ? 'denied' : 'granted',
  functionality_storage: 'granted',
  personalization_storage: 'denied',
  security_storage: 'granted',
  wait_for_update: 500
};

if (regionList.length > 0) {
  state.region = regionList;
}

setDefaultConsentState(state);

// Tell the dashboard which version we loaded with.
dataLayerPush({ event: 'ach_consent_default', websiteId: data.websiteId });

const loaderUrl = data.loaderUrl;
injectScript(
  loaderUrl,
  function () { data.gtmOnSuccess(); },
  function () { data.gtmOnFailure(); },
  loaderUrl
);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": { "publicId": "access_consent", "versionId": "1" },
      "param": [
        { "key": "consentTypes", "value": { "type": 2, "listItem": [
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" },
                { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "ad_storage" }, { "type": 8, "boolean": true }
              ] },
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" }, { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "analytics_storage" }, { "type": 8, "boolean": true }
              ] },
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" }, { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "ad_user_data" }, { "type": 8, "boolean": true }
              ] },
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" }, { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "ad_personalization" }, { "type": 8, "boolean": true }
              ] },
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" }, { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "functionality_storage" }, { "type": 8, "boolean": true }
              ] },
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" }, { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "personalization_storage" }, { "type": 8, "boolean": true }
              ] },
            { "type": 3, "mapKey": [
                { "type": 1, "string": "consentType" }, { "type": 1, "string": "write" }
              ], "mapValue": [
                { "type": 1, "string": "security_storage" }, { "type": 8, "boolean": true }
              ] }
          ] } }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": { "publicId": "inject_script", "versionId": "1" },
      "param": [
        { "key": "urls", "value": { "type": 2, "listItem": [
            { "type": 1, "string": "*" }
          ] } }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": { "publicId": "access_globals", "versionId": "1" },
      "param": [
        { "key": "keys", "value": { "type": 2, "listItem": [
            { "type": 3, "mapKey": [
                { "type": 1, "string": "key" },
                { "type": 1, "string": "read" },
                { "type": 1, "string": "write" },
                { "type": 1, "string": "execute" }
              ], "mapValue": [
                { "type": 1, "string": "dataLayer" },
                { "type": 8, "boolean": true },
                { "type": 8, "boolean": true },
                { "type": 8, "boolean": false }
              ] }
          ] } }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2025-01-01 by Adsvantage. Update by editing this .tpl file in the
repository and re-importing into GTM.
