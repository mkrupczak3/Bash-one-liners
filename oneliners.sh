# With a music archive of the file format:
#     Artist/AlbumA
#            AlbumB
#            AlbumC
#            ...
#
#     Quickly go into the directory and add mp3 ID3 tags with the artist's name 
#         and album name sourced from the folder directly containing the mp3's
cd Speed\ of\ Doom/ && eyeD3 -a "James Paddock" -A "$(basename "$PWD")" *.mp3 && cd .. && ls -lah

# Generate a text file containing filneame headers and text content of all files recursively in a directory, ignoring binary files. 
find . -type f -not -path '*/\.*' -exec grep -Il '.' {} \; | xargs awk 'FNR==1{print "--------------------------------------------------------------------------------"; print FILENAME; print "--------------------------------------------------------------------------------"; print ""; }{ print; print "" }' > allcode.txt

# Convert images from one format to another with multithreaded processing
# https://drewlustro.com/blog/batch-convert-raw-images-to-jpeg-with-imagemagick-in-parallel
find . -type f -iname '*.ARW' -print0 | xargs -0 -n 1 -P 4 -I {} convert -verbose -units PixelsPerInch {} -colorspace sRGB -resize 2560x2650 -set filename:new '%t-%wx%h' -density 72 -format JPG -quality 80 '%[filename:new].jpg'
