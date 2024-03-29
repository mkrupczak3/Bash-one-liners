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
# -----------------------------------------------------------------------
#     Chagnge -P # where '#' is your number of physical CPU cores
# -----------------------------------------------------------------------
# Convert raw images, commonly used in photography. Heavily compress and spit out jpegs:
find . -type f -iname '*.ARW' -print0 | xargs -0 -n 1 -P 4 -I {} convert -verbose -units PixelsPerInch {} -colorspace sRGB -resize 2560x2650 -set filename:new '%t-%wx%h' -density 72 -format JPG -quality 80 '%[filename:new].jpg'
# Batch convert Steam uncompressed PNG videogame screenshots to high-quality low compression JPG for use with twitter:
find . -type f -iname '286690*.png' -print0 | xargs -0 -n 1 -P 4 -I {} convert -verbose -units PixelsPerInch {} -colorspace sRGB -resize 3840x2160 -set filename:new '%t-%wx%h' -density 72 -format JPG -quality 97 '%[filename:new].jpg'
# Convert images to the maximum quality allowed by twitter. Res preserves aspect ratio of 3:2 from Nikon D3500
find . -type f -iname '*.JPG' -print0 | xargs -0 -n 1 -P 4 -I {} convert -verbose -units PixelsPerInch {} -colorspace sRGB -resize 4096x2731 -set filename:new '%t-%wx%h' -density 72 -format JPG -quality 89 '%[filename:new].jpg'

# Download a file using multiple connections for faster downloading
# https://stackoverflow.com/a/24444698
# ----
# TCP multiplexing allows for fast downloads even on a congested connection
#     Trust me, I once took a networking class
aria2c -x 16 -s 16 [url]
#          |    |
#          |    |
#          |    |
#          ---------> the number of connections here

# Download from a torrent magnet link
aria2c 'magnet:?xt=urn:btih:248D0A1CD08284299DE78D5C1ED359BB46717D8C'

# Download from a torrent file
aria2c http://example.org/mylinux.torrent

# Download multiple things in parallel using aria2
# https://stackoverflow.com/questions/54853223/download-multiple-files-with-aria2c-in-parallel
find . -iregex ".*.torrent" -print0 | parallel -0 aria2c

# Download URI's found in a text file
aria2c -i uris.txt
# Download all songs on a remote playlist text file
aria2c -i example.com/fire_mixtape.m3u

wget -i uris.txt
# Download all songs on a remote playlist text file
wget -i example.com/fire_mixtape.m3u

#Unzip a folder
unzip bla.zip

#Unrar a rar archive
unrar x Starbound\ 1.2.2.rar

# Remotely SYNC two directories, smarter than scp and easier than creating a tar
rsync -rtvP --bwlimit=512 [source] [destination] 

# [source] [destination] e.g. myuser@remotemachine.com:/mixtapes /home/localuser/mixtapebkp
# Where
#
# -r is recursive
# -t retains the files' modification time
# -v to show what is going on
# -P shows the progress
# --bwlimit=512 limits the upload to 512Kb/sec, ~= 4.1 mbps
# 
# If interrupted, just run the command again and it will pickup where it left off

# test internet connection speed from command line
speedtest-cli

# Terminal window with the date and ping time to Cloudfare DNS (1.1.1.1) every 1s
ping 1.1.1.1 | while read line; do clear && echo `date` - $line; done

# Have a random cow say a random thing
watch -n 10 fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)

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

# PACKAGE MANAGEMENT
# diagnose weird Java runtime issues
# https://stackoverflow.com/q/53090590/14460558
update-alternatives --display java

# download a YouTube video and convert the format to mp3
youtube-dl --restrict-filenames --ignore-errors -x --audio-format mp3 https://www.youtube.com/watch?v=dQw4w9WgXcQ

#---------------------------------
# ╔═══╗ ╔═══╗╔═╗╔═╗╔═══╗╔═══╗╔═══╗
# ║╔══╝ ║╔══╝║║╚╝║║║╔═╗║║╔══╝║╔═╗║
# ║╚══╗ ║╚══╗║╔╗╔╗║║╚═╝║║╚══╗║║ ╚╝
# ║╔══╝ ║╔══╝║║║║║║║╔══╝║╔══╝║║╔═╗
#╔╝╚╗  ╔╝╚╗  ║║║║║║║║   ║╚══╗║╚╩═║
#╚══╝  ╚══╝  ╚╝╚╝╚╝╚╝   ╚═══╝╚═══╝
#---------------------------------

# Use ffmpeg to encode an audio file with an image as a video file for use with Youtube
#     e.g.: Album cover displayed on loop while song is heard for length of video/song
#     
#     do not fall afoul of the RIAA or ThemTube
# # https://superuser.com/questions/700419/how-to-convert-mp3-to-youtube-allowed-video-format
ffmpeg -loop 1 -r 1 -i pic.jpg -i audio.mp3 -c:a copy -shortest -c:v libx264 output.mp4

# Trim an MP4 video file to a subset at a certain start and end time
#     , preserving original encoding, based on timecodes:
# https://stackoverflow.com/a/42827058/14460558
# 
# WARNING
#     ass-backwards crap where 2nd timecode arg is the LENGTH
#     of the desired video to be copied, NOT a timecode on the source vid! 
ffmpeg -i movie.mp4 -ss 00:00:03 -t 00:00:08 -async 1 -strict -2 -c copy cut.mp4 
# Vid scaling
#     https://write.corbpie.com/upscaling-and-downscaling-video-with-ffmpeg/
# ===============
# Upscale a video:
#    Change threads if ur a potato or u work at NASA
ffmpeg -i input.mp4 -strict -2 -max_muxing_queue_size 9999 -threads 4 -vf scale=1920x1080:flags=lanczos -c:v libx264 -preset slow -crf 21 output_compress_1080p.mp4
# ================
# Downscale a video:
#    Change threads if ur a potato or u work at NASA
ffmpeg -i input.mp4 -strict -2 -max_muxing_queue_size 9999 -threads 4 -vf scale=640x480:flags=lanczos -c:v libx264 -preset slow -crf 21 output_compress_480p.mp4
# ================
#---------------------------------------------------------------------------------------- 
# Convert a Video for Twitter? (May Not Work)
# https://gist.github.com/nikhan/26ddd9c4e99bbf209dd7
#
ffmpeg -i test.mov -strict -2 -max_muxing_queue_size 9999 -vcodec libx264 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -pix_fmt yuv420p -strict experimental -r 30 -t 2:20 -acodec aac -vb 1024k -minrate 1024k -maxrate 1024k -bufsize 1024k -ar 44100 -ac 2 out.mp4

# Check GPU usage of NVIDIA card:
# Setup
#     http://blog.datumbox.com/getting-the-gpu-usage-of-nvidia-cards-with-the-linux-dstat-tool/
# sudo apt-get install dstat #install dstat
# sudo pip install nvidia-ml-py #install Python NVIDIA Management Library
# wget https://raw.githubusercontent.com/datumbox/dstat/master/plugins/dstat_nvidia_gpu.py
# sudo mv dstat_nvidia_gpu.py /usr/share/dstat/ #move file to the plugins directory of dstat
dstat -a --nvidia-gpu

# Issue I've run into MULTIPLE times, very frustrating for something so stupid
#
# Start the redshift night-time blue light removal / display dimming service, providing it a longitude and latitude manually
# Since apparently these garbage-tier developers can't be bothered to get some of the most BASIC
# software on the planet to work on an esoteric system such as, I don't know, UBUNTU 18.04 LONG TERM SUPPORT (WTF?)
#
# https://github.com/jonls/redshift/issues/445
#
# https://manpages.ubuntu.com/manpages/trusty/man5/redshift.5.html
# @TODO change 6471 to the correct daytime color temperature (no modification/redshift)
redshift -l 4.65:-74.06 -t 6471:3600 -g 0.8 -m randr -v &
# As an aside, this is a perfect example of why I would never recommend Linux or even Ubuntu to a normal human being. 
# It just isn't designed for usability, and the contract with users
# (I do something -> it is supposed to actually work [dammit!]) even with the simplest GUI
# apps clearly doesn't even exist on this platform. 
#
# Never mind trying to convince your grandma to 
# try to mess with all this crap on the command line every time your computer forgets how to wipe its own a**.
#
# This unfortunately has been painfully demonstrated to me time and time again.
#
# Edit: I'm an idiot
#    Your grandma and snot-nosed nephew who wants to play Minecraft can
#    both dim their dispaly at night with their sanity intact easily on
#    Ubuntu using the night light setting:
# https://www.omgubuntu.co.uk/2017/10/enable-night-light-mode-on-ubuntu


# Ubuntu Start a daemon at startup:
update-rc.d service_name defaults
# Ubuntu remove a daemon from startup:
update-rc.d -f service_name remove

#Check if a specific port or range of ports (TCP and or UDP) is/are open using nmap
nmap -p U:53,111,137,T:21-25,80,139,8080

#List devices mounted to a linux machine (e.g. ssd on sda, thumbdrive on sdd, ...)
## https://linuxhandbook.com/linux-list-disks/
sudo parted -l

# From a given disk device, mount it to filesystem:
## mount [OPTION/S] DEVICE_NAME DIRECTORY_NAME
mount -t ext4 /dev/sdb1 /mnt/media

# Use mkdosfs to format a thumb drive as FAT32
#     Legacy filesystem necessary for use with many devices
#     Use 'sudo fdisk -l' to find correct device name
sudo umount /dev/sdc1 && sudo mkdosfs -F 32 -I /dev/sdc1

# SMARTCTL HDD Health
# -------------------
#   Automated montly test and report:
#   https://brismuth.com/scheduling-automated-storage-health-checks-d470b4283e3e
# ----
#   run a short test on a disk
smartctl -t short /dev/sda
#   Human readable health of a disk
smartctl -H /dev/sda 
#   All info of a disk, including results of all tests
smartctl -a /dev/sda


# Linux create a filesystem hard link
#     creates another inode to the data on hard disk
#     completely transparent to underlying software
ln SOURCE TARGET

# Linux create a filesystem soft link
#     creates a symbolic link to point to another file
ln -s SOURCE TARGET

# Use DD to make a backup image of a physical disk device
sudo dd bs=4M if=/dev/sdc of=/home/mkrupczak/Retro_Pie_BKP.img status=progress

# Use DD to duplicate one drive onto another
dd if=/dev/sda of=/dev/sdb bs=4M conv=notrunc,noerror status=progress

# Use DD to retore a backup image of a drive onto a disk
sudo dd bs=4M if=/home/mkrupczak/Retro_Pie_BKP.img of=/dev/sdc status=progress

# suspend a long-running program in a shell window
#     https://askubuntu.com/a/465834
#
# CTRL + Z
# ---------------
# Resume after suspending:
# %
# ---------------
#
# CONTROL FLOW
#     CTRL + S: pause scrolling of output
#     CTRL + Q: resume scrolling of output

# Figure out what my IP looks like to other people 
curl ifconfig.me

