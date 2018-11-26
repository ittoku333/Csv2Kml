Csv2Kml
====

Overview

- This is a tool for converting ```CSV``` file to ```KML``` file.

## Description
- It is necessary to prepare in advance a CSV file named ```sample.csv``` .
- You must create a CSV file in the following format.
```
[CSV format] filename:sample.csv encode:Shift_JIS headers:exists
|0:id|1:name|2:none|3:meter|4:longitude|5:latitude|6:marker|7:none|8:memo1|9:memo2|
|0   |東京駅 |-     |202221 |139.767052 |35.681167 |1       |-     |memo1  |memo2  |
|1   |代々木 |-     |202221 |139.694945 |35.671736 |1       |-     |memo1  |memo2  |
```

## Usage
ruby Csv2Kml.rb

## Install
ruby only.
