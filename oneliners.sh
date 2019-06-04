# With a music archive of the file format:
#     Artist/AlbumA
#            AlbumB
#            AlbumC
#            ...
#
#     Quickly go into the directory and add mp3 ID3 tags with the artist's name 
#         and album name sourced from the folder directly containing the mp3's
cd Speed\ of\ Doom/ && eyeD3 -a "James Paddock" -A "$(basename "$PWD")" *.mp3 && cd .. && ls -lah
