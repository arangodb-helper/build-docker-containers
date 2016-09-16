#!/usr/bin/python
from lockfile import LockFile, LockTimeout
from shutil import copy
import sys

my_md5sum=sys.argv[1]
my_sourcefile=sys.argv[2]
my_lockfile=sys.argv[3]
my_destfile=sys.argv[4]

print("waiting for lock: \n")
lock = LockFile(my_lockfile)
while not lock.i_am_locking():
    try:
        lock.acquire(timeout=600)    # wait up to 10 Minutes
    except LockTimeout:
        lock.break_lock()
        lock.acquire()

print("Got lock: %s\n" % lock.path)
md5File=open(my_destfile + '.md5', 'r')
remoteMD5=md5File.read()
md5File.close()
if remoteMD5 != my_md5sum:
    print("Copying file: %s -> %s\n" % (my_sourcefile, my_destfile))
    copy(my_sourcefile, my_destfile)
    md5File=open(my_destfile + '.md5', 'w')
    md5File.write(my_md5sum)
else:
    print("File md5 sums match, not copying.\n")

lock.release()
