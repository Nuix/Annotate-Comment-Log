Annotate Comment Log
====================

![Last tested in Nuix 7.4](https://img.shields.io/badge/Nuix-7.4-green.svg)

View the GitHub project [here](https://github.com/Nuix/Annotate-Comment-Log) or download the latest release [here](https://github.com/Nuix/Annotate-Comment-Log/releases).

# Overview

**Written By:** Jason Wells

In some instances a presentation processed by Nuix may contain comments which are captured in the item's content text rather than in metadata fields.  These comments may look something like this:

```
Smith, Bob [ABCD] (XYZ) @ Jun 02, 2010 11:31:41 PM: Icons are not aligned properly, font is inconsistent.
Doe, Jane [ABCD] (XYZ) @ Jun 02, 2010 11:59:01 PM: Aligned icons, fixed fonts to be consisten with style guide.
```

The script searches the case for potential items to scrape this information from using the following query:

```
properties:\"Contains Comments:true\" AND name:( ppt OR pptx )
```

The script scans the content text of these items with the following regular expression:

```
^(.*, .*) \[[^\]]+\] \([^\)]+\) @ ([a-z]{3} [012][0-9], [0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2} [AP]M): (.*)$
```

Producing a custom metadata field on item's with matches like the following:

```
Smith, Bob @ Jun 02, 2010 11:31:41 PM: Icons are not aligned properly, font is inconsistent.
Doe, Jane @ Jun 02, 2010 11:59:01 PM: Aligned icons, fixed fonts to be consisten with style guide.
```


# Getting Started

## Setup

Begin by downloading the latest release of this code.  Extract the contents of the archive into your Nuix scripts directory.  In Windows the script directory is likely going to be either of the following:

- `%appdata%\Nuix\Scripts` - User level script directory
- `%programdata%\Nuix\Scripts` - System level script directory

# License

```
Copyright 2018 Nuix

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```