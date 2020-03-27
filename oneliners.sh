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

# Download a file using multiple connections for faster downloading
# https://stackoverflow.com/a/24444698
aria2c -x 16 -s 16 [url]
#          |    |
#          |    |
#          |    |
#          ---------> the number of connections here

# Download from a torrent magnet link
aria2c 'magnet:?xt=urn:btih:248D0A1CD08284299DE78D5C1ED359BB46717D8C'

# Download from a torrent file
aria2c http://example.org/mylinux.torrent

# Download URI's found in a text file
aria2c -i uris.txt
# Download all songs on a remote playlist text file
aria2c -i example.com/fire_mixtape.m3u

wget -i uris.txt
# Download all songs on a remote playlist text file
wget -i example.com/fire_mixtape.m3u

# test internet connection speed from command line
speedtest-cli

# see the available space on  mounted file-systems in human-readable printout
df -h

# Look through a system and see where space is being used
ncdu /

# Check graphics cards
lspci -k | grep -A 2 -i "VGA"

# Switch to using integrated graphics on a linux laptop with nvidia x server installed
# https://www.linuxbabe.com/desktop-linux/switch-intel-nvidia-graphics-card-ubuntu
sudo prime-select intel

# Switch to using nvidia graphics on a linux laptop with nvidia x server installed (for games, ML, etc.)
sudo prime-select nvidia

# query which graphics device is active (is a liar sometimes, rquires log out and in to apply)
prime-select query

# Query which graphics device is active (i.e. games would actually use)
# Important when used to figure out if either Intel or Nvidia card is actually active
glxinfo|egrep "OpenGL vendor|OpenGL renderer*"

# download a YouTube video and convert the format to mp3
youtube-dl --restrict-filenames --ignore-errors -x --audio-format mp3 https://www.youtube.com/watch?v=MopniCeuWTk



