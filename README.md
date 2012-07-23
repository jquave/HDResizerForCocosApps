HDResizerForCocosApps
=====================

Script to recursively resize hd images to standard definition (and handle renaming) using the -hd convention.




Usage
====================

Just run
> ruby hd-tool.rb

from whatever directory you want the recursive search to start, it will find any files with -hd ending and create a half-resolution copy witout the extension, if it doesn't exist.
If it can't find an -hd file, it will assume that it was misname, add -hd to the end, then make the low res copy.
