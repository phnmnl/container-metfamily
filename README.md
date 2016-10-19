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

## Short description

Identification of regulated metabolite families.

## Description

The MetFamily web application is designed for the identification of regulated metabolite families. This is possible on the basis of metabolite profiles for a set of MS features as well as one MS/MS spectrum for each MS feature. Group-discriminating MS features are identified using a principal component analysis (PCA) of metabolite profiles and metabolite families are identified using a hierarchical cluster analysis (HCA) of MS/MS spectra. Regulated metabolite families are identified by considering group-discriminating MS features from corporate metabolite families.

## Publications

Treutler H, Tsugawa H, Porzel A, Gorzolka K, Tissier A, Neumann S, Balcke GU (2016): Discovering Regulated Metabolite Families in Untargeted Metabolomics Studies. Anal Chem 88(16):8082-90. doi:10.1021/acs.analchem.6b01569

## Screenshots

metfamily.png

## Tool Authors 
- [Hendrik Treutler](https://github.com/treutler) (IPB-Halle)

## Container Contributors
- [Kristian Peters](https://github.com/korseby) (IPB-Halle)

## Website
* http://msbi.ipb-halle.de/MetFamily/
* https://github.com/Treutler/MetFamily

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
