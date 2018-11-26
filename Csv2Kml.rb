require 'csv'

=begin
CSV format：sample.csv encode:Shift_JIS headers:exists
|0:id|1:name|2:none|3:meter|4:longitude|5:latitude|6:marker|7:none|8:memo1|9:memo2|
|0   |東京駅 |-     |202221 |139.767052 |35.681167 |1       |-     |memo1  |memo2  |
|1   |代々木 |-     |202221 |139.694945 |35.671736 |1       |-     |memo1  |memo2  |

=end

locations = []

# sample.csvファイルはShift_JIS想定のためUTF-8でエンコーディングする（ヘッダーあり）
CSV.foreach("sample.csv", encoding: 'Shift_JIS:UTF-8', headers:true) do |row|

  location = {
  'name' => (row[3].to_f/1000).to_s + 'km ' + row[1],
  'longitude' => row[4].to_f,
  'latitude' => row[5].to_f,
  'marker' => row[6],
  'dispName1' => 'メモラベル1',
  'dispVal1' => row[8].to_s,
  'dispName2' => 'メモラベル2',
  'dispVal2' => row[9].to_s,
  }
  locations << location
end

File.open('csv2kmlSample.kml', 'w:UTF-8') do |f|
  f.puts('<?xml version="1.0" encoding="utf-8" standalone="no"?>')
  f.puts('<kml xmlns="http://www.opengis.net/kml/2.2">')
  f.puts('<Document>')
  f.puts('<name>csv2kmlサンプル</name>')
  f.puts('<description /><Style><IconStyle><Icon /></IconStyle></Style>')

  # locationの数分繰り返して<Placemark>データを作成する
  locations.each do |location|
    f.puts('<Placemark>')
    f.puts('<Point>')
    f.puts(' <coordinates>' + location['longitude'].to_s + ',' + location['latitude'].to_s + ',0.000000' + '</coordinates>')
    f.puts('</Point>')
    f.puts('<name>'+ location['name'] +'</name>')

    f.puts('<description>&lt;!----&gt;</description>')
    f.puts('<styleUrl />')
    f.puts('<ExtendedData>')
    f.puts('<Data name="Marker">')
    f.puts('<value>' + location['marker'] + '</value>')
    f.puts('</Data>')

    f.puts('<Data name="MemoInformation1">')
    f.puts('<displayName>' + location['dispName1'] + '</displayName>')
    f.puts('<value>' + location['dispVal1'] + '</value>')
    f.puts('</Data>')
    f.puts('<Data name="MemoInformation2">')
    f.puts('<displayName>' + location['dispName2'] + '</displayName>')
    f.puts('<value>' + location['dispVal2'] + '</value>')
    f.puts('</Data>')
    f.puts('</ExtendedData>')

    f.puts('</Placemark>')
  end

  f.puts('</Document>')
  f.puts('</kml>')
end
