# With a music archive of the file format:
#     Artist/AlbumA
#            AlbumB
#            AlbumC
#            ...
#
#     Quickly go into the directory and add mp3 ID3 tags with the artist's name 
#         and album name sourced from the folder directly containing the mp3's
cd Speed\ of\ Doom/ && eyeD3 -a "James Paddock" -A "$(basename "$PWD")" *.mp3 && cd .. && ls -lah

# Generate a text file containing filneame headers and text of all files recursively in a directory, ignoring binary files. 
find . -type f -not -path '*/\.*' -exec grep -Il '.' {} \; | xargs awk 'FNR==1{print "--------------------------------------------------------------------------------"; print FILENAME; print "--------------------------------------------------------------------------------"; print ""; }{ print; print "" }' > allcode.txt
