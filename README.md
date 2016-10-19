<!-- Guidance:
Logo: The logo needs have the text "Logo" inside the square bracket place holder to be recognized at the App Library.
Tool name: First single hashtag (#) will be taken as tool name.
Version: Should always go after the first hastag and before the second hastag. The line needs to respond to the regexp "^Version: (.+)" being the first group the actual version.

Fields: for the App Library, the following fields will be parsed:

# Name of the tool
Version: z.x-whatever
## Short description
## Description
## Key features
## Publications
## Screenshots
## Tool Authors 
- Author 1 and affiliation
- [Author 2](link_to_author_2) and affiliation
## Container Contributors
- Contributor 1
- [Contributor 2](link_to_contributior_2) and affiliation
## Website
## Usage Instructions

Free text with triple tick code blocks, comprising docker, ipython and galaxy usage

## Installation 

They all have to be at the second hashtag level

For screenshots, you should use the following scheme:

![screenshot](screenshots/s1.gif)
![screenshot](screenshots/s2.gif)

-->

# MetFamily
Identification of regulated metabolite families.

## Short description

## Description


## Key features


## Publications


## Screenshots


## Tool Authors 
- [Hendrik Treutler](https://github.com/treutler) (IPB-Halle)

## Container Contributors
- [Kristian Peters](https://github.com/korseby) (IPB-Halle)

## Website
http://msbi.ipb-halle.de/MetFamily/

## Installation 

For local individual installation:

```bash
docker pull docker-registry.phenomenal-h2020.eu/phnmnl/metfamily
```

## Usage Instructions

For direct docker usage:

```bash
docker run docker-registry.phenomenal-h2020.eu/phnmnl/metfamily ...
```

For launchin with traefik:

```bash
docker-compose -f traefik/docker-compose.yaml up -d
curl -H Host:metfamily.docker.localhost http://localhost:80
```
