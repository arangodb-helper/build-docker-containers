#!/usr/bin/python

# tested with:
# tar -cvzf /tmp/test.tar.gz etc/
# md5sum /tmp/test.tar.gz -> 36ac61ca0ca8c7375be464058fd8f3e6
# ./copyFileLockedIfNewer.py  36ac61ca0ca8c7375be464058fd8f3e6  /tmp/test.tar.gz  /var/tmp/tst /var/tmp/this.tar.gz thisjob "mkdir /var/tmp/blarg; cd /var/tmp/blarg; tar -xvzf /var/tmp/this.tar.gz"; find /var/tmp/blarg 

from lockfile import LockFile, LockTimeout
from shutil import copy
import sys
from subprocess import call

my_md5sum=sys.argv[1]
my_sourcefile=sys.argv[2]
my_lockfile=sys.argv[3]
my_destfile=sys.argv[4]
my_jobname=sys.argv[5]
have_command = False
if (len(sys.argv) > 6):
    have_command = True
    command = sys.argv[6]

#print("my_md5sum: %s my_sourcefile: %s my_lockfile: %s my_destfile: %s" %(
#    my_md5sum,
#    my_sourcefile,
#    my_lockfile,
#    my_destfile
#))

print(my_jobname + ": waiting for lock: \n")
lock = LockFile(my_lockfile)
while not lock.i_am_locking():
    try:
        lock.acquire(timeout=6000)    # wait up to 100 Minutes
    except LockTimeout:
        print(my_jobname + ": lock timed out!\n")
        lock.break_lock()
        lock.acquire()

print(my_jobname + ": Got lock: %s\n" % lock.path)
remoteMD5=""
try: 
    md5File=open(my_destfile + '.md5', 'r')
    remoteMD5=md5File.read()
    md5File.close()
except:
    pass

if remoteMD5 != my_md5sum:
    print(my_jobname + ": Copying file: %s -> %s\n" % (my_sourcefile, my_destfile))
    copy(my_sourcefile, my_destfile)
    md5File=open(my_destfile + '.md5', 'w')
    md5File.write(my_md5sum)

    if have_command:
        print my_jobname + ": running: call([\"bash\", \"-c\", \"'" + command + "'\"'])\n"
        call(["bash", "-c", command])

else:
    print(my_jobname + ": File md5 sums match, not copying.\n")

lock.release()
