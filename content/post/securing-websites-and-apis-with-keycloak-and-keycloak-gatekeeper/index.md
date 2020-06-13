---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Securing Websites and APIs With Keycloak and Keycloak Gatekeeper"
subtitle: ""
summary: "How to secure your website or API endpoint(s) without changing the website or unsecured APIs."
authors: [siuyin]
tags: [security]
categories: []
date: 2020-06-13T10:34:29+08:00
lastmod: 2020-06-13T10:34:29+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
`keycloak` is both an authentication (who are you?) and an authorization (what can you do?) solution.

`keycloak-gatekeeper` is a statically linked executable with no external dependencies.
keycloak-gatekeeper sits in front of your unsecured website or API endpoint(s) to
ensure only authorized users are allowed in.

Both keycloak and keycloak-gatekeeper are available for linux, mac and windows.

## Overview

1. Configure and deploy keycloak.
1. Adjust serving of your website or APIs so that they are no longer publicly accessible.  
  Refer to your web server (eg. nginx, apache, IIS) documentation for details on how to do this.
  Eg. edit you web server configuration to serve on a different port like 8123.
1. Configure keycloak-gatekeeper to authenticate with keycloak and
  point to your new website address ( Eg. http://localhost:8123 ).
1. Adjust your web server configuration to make keycloak-gatekeeper publicly accessible.  
  Access your now secured website through keycloak-gatekeeper.

## Configure and deploy keycloak

1. Download keycloak from [keycloak.org](https://www.keycloak.org/) downloads link.
1. Follow keycloak.org instructions to install keycloak.
1. Launch keycloak administration console.
   1. Near the top the realm will be displayed. On a fresh install, "Master" will be displayed.
  The realm is the name of the set of things you wish to secure. 
   1. We want to create a new realm, say "foo", for foo.com and its APIs.
  Do this by hovering over "Master" and clicking on Add realm. Then fill in your desired realm name.
   1. Next we want to create a client for the foo realm.
  A client is a computer program that will access keycloak.
  In this case our client will be keycloak-gatekeeper.
  Look for Configure / Clients and click on it.
      1. Look for the create button near the extreme right of the page and click on it.
      1. Enter a client-id (eg. gatekeeper)
      1. Ensure the Client Protocol is "openid-connect". This is the default setting, so you should not need
  to change it.
      1. Change Access Type from "public" to "confidential" by clicking on the field to show a list of options and selecting confidential.
      1. Change Valid Redirect URIs to a url like http://foo.com or https://foo.com or http://192.168.1.123:8080.
  The redirect URI is the place keycloak will send an authorisation token (something like a passport)
  after you have sucessfully logged-in as a user.
  For our example we want to send the token to `keycloak-gatekeeper`. We will set-up users in the next steps.
      1. Click Save (near the bottom of the page).
      1. Look for and click on Credentials near the top of the page. Copy the secret. We will need it to configure keycloak-gatekeeper.
   1. Create users and groups.
  These will be the users authorized to access your website and/or APIs.
      1. Look for Manage / Groups on the left-hand menu. Click on Groups.
      1. Look for New near the right size of the page. Click on the New button.
      1. Enter a group name, say users.
      1. Look for Manage / Users. Click on Users, then Add user.
      1. Add at minimum the username, then click Save.
      1. Give the new user credentials. Look for Credentials near the top of the page. Remember to click "Set Password".
   1. Include the authorized group in the authorization token (think visa in the passport).
  We do this by creating a realm role and associating the role with the authorized group. 
      1. Click on Configure / Roles / Add Role. Make the role name the same as the authorized group name (eg. users).
  This need not be the same but is good management practice to keep names similar.
      1. Click on Manage / Groups . Select your group (eg. users), then click on Edit button.
         1. Click on Role Mappings (near the top of the page). Add Realm Roles "user" by selecting the role then click Add Selected.
      1. Click on Configure / Clients / {your client-id eg. gatekeeper} / Mappers / Create. On the Mapper Type field, select Audience, then click Save.  
 This is required to add the client-id to the "aud" field of the token (i.e. actually affix the visa to the passport's "aud" page).
 This step  works around a known issue with keycloak-gatekeeper.
 See [keycloak.org / Securing Apps / Keycloak Gatekeeper / Known Issues](https://www.keycloak.org/docs/latest/securing_apps/index.html#known-issues).

## Configure keycloak-gatekeeper
  1. keycloak-gatekeeper needs a configuration to work.
  Detailed reference can be found on
  [keycloak.org / Securing Apps / Keycloak Gatekeeper](https://www.keycloak.org/docs/latest/securing_apps/index.html#_keycloak_generic_adapter)
  1. Below is an example config.yaml file for the public address
  at http//:192.168.1.123:8080 and the unsecured internal website now reconfigured to listen at http://192.168.1.123:8123.  
  Make sure your firewall _denies_ access to port 8123 from the internet!  
  In the example below keycloak is running at http://192.168.1.200
  (when using http, configure realm thus: Configure / Realm Settings / Login / Require SSL to "none").

```
# keycloak is running at 192.168.1.200 and the realm is foo
discovery-url: http://192.168.1.200/auth/realms/foo

# client-secret is the secret you copied from Configure / clients / {client-id} / Credentials.
client-id: gatekeeper
client-secret: bfe02249-5a48-4b88-b0b0-cdaea7e2d90d 

# keycloak-gatekeeper is listening on port ... or port 80 (http) or 443 (https). Note the extra :
listen: :8080
enable-refresh-tokens: true
enable-default-deny: true
redirection-url: http://192.168.1.123:8080 # must match keycloak Configure / Clients / {client-id} / Valid Redirect URIs

# encryption key can be any string you like. It is used internally within keycloak. 
encryption-key: sflfjljuweru0989

# upstream-url is the url of your unsecured website.
upstream-url: http://192.168.1.123:8123

secure-cookie: false # needs to be false for http

# The config below requires users role to access all urls
# except for the contact url which will be publicly accessible.
resources:
- uri: /*
  roles:
  - users
- uri: /contact
  white-listed: true
```

## Run keycloak-gatekeeper
```
keycloak-gatekeeper --config config.yaml
```

## Login and Logout
In the example configuration above,
when you access http://192.168.1.123:8080 you are redirected to keycloak to log in.

The logout url is http://192.168.1.123:8080/oauth/logout . This can be a useful link to add to your website.
Otherwise the user is automatically logged out by closing the browser.
