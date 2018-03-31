From: Steve Freyder <steve@freyder.net>
Message-ID: <5ABFDCCE.8060007@freyder.net>
Date: Sat, 31 Mar 2018 14:09:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai argv editing, and registry client socket issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

============================================================================80|
Hello Xenomai list.

I have a couple of issues to report, I believe two minor patches may be in
order.  I've searched the archives for a report on these, and couldn't find
any, so I submit this for your consideration.

Here's my test environment.

This small C program I call "exectest" - basically it does an exec as
directed by its command arguments:

===============exectest.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

int main(
     int     argc,
     char    *argv[]
){
     if (getenv("argvterm") != NULL)  {
         argv[argc] = NULL ;
     }
     return(execvp(argv[1],&argv[1])) ;
}
===============exectest.c end

I compile this program using --skins=alchemy so it has the Xenomai
auto-init code wrapping main(), the executable is "exectest".

A few test scripts -- "dotest", "argv", and "reg" -- all of them
chmod +x

===============dotest
#!/bin/sh

function ext()  {
     ./exectest --session=$SESSION --mem-pool-size=16M "$@"
}

set -x
pkill sysregd     # start fresh
SESSION=mysession
sysregd --daemon --root /var/run/xenomai/$USER/$SESSION --linger
ext ./argv foo bar
argvterm=1 ext ./argv foo bar
sleep 3  # wait for reg to clear out
#
find /run/xenomai
ext ./reg
===============dotest end

===============argv
ICB-G3L:/.g3l# cat argv
#!/bin/sh

echo pid $$ argv = "$@"
===============argv end

===============reg
#!/bin/sh

set -x
ls -l /proc/$$/fd
netstat -xenp | grep SEQPACKET
find /run/xenomai
===============reg end

When I run ./dotest, here's the output (with <<<>>>'s interspersed
for comments):

# ./dotest
+ pkill sysregd
+ SESSION=mysession
+ sysregd --daemon --root /var/run/xenomai/root/mysession --linger
+ ext ./argv foo bar
+ ./exectest --session=mysession --mem-pool-size=16M ./argv foo bar
pid 1757 argv = foo bar foo bar
+ argvterm=1
+ ext ./argv foo bar
+ ./exectest --session=mysession --mem-pool-size=16M ./argv foo bar
pid 1764 argv = foo bar

<<<<<<  >>>>>>>>

Note the duplicate args on the first invocation "foo bar foo bar",
but not on the second where "argvterm" is set to 1.

This seems to indicate that something like:

     argv[argc] = NULL

should be added to the Xenomai command line parsing code that expunges
the Xenomai-specific options from argv, after all of the work is done,
to restore the expectations that execvp (and probably others) apparently
have about a NULL-terminated argv array.

Now the second issue:

<<<<<<  >>>>>>>>

+ sleep 3
+ find /run/xenomai
/run/xenomai
/run/xenomai/root
/run/xenomai/root/mysession
/run/xenomai/root/mysession/system
/run/xenomai/root/mysession/system/threads
/run/xenomai/root/mysession/system/heaps
/run/xenomai/root/mysession/system/version
+ ext ./reg
+ ./exectest --session=mysession --mem-pool-size=16M ./reg
+ ls -l /proc/1811/fd
lrwx------    1 root     root            64 Mar 31 13:12 0 -> /dev/ttymxc1
lrwx------    1 root     root            64 Mar 31 13:12 1 -> /dev/ttymxc1
lrwx------    1 root     root            64 Mar 31 13:12 2 -> /dev/ttymxc1
lr-x------    1 root     root            64 Mar 31 13:12 255 -> /.g3l/reg
lrwx------    1 root     root            64 Mar 31 13:12 3 -> socket:[11759]
lrwx------    1 root     root            64 Mar 31 13:12 4 -> /dev/fuse
+ grep SEQPACKET
+ netstat -xenp
unix  3      [ ]   SEQPACKET  CONNECTED  11759 1811/sh
unix  3      [ ]   SEQPACKET  CONNECTED  13704 1798/sysregd 
@EC0B7696-xenomai
+ find /run/xenomai
/run/xenomai
/run/xenomai/root
/run/xenomai/root/mysession

<<<<<<  >>>>>>>>

Here, we're running the same "exectest" program to exec a shell script, but
this time it's to test the registry connect code, checking for inheritance
of the socket file descriptor that the registry code will be using to 
connect
to sysregd via the @EC0B7696-xenomai Unix domain socket.

We're listing our fd's from /proc/ourpid/fd, and we're seeing based on that
plus the netstat output that fd 3 is the client-side of the sysregd Unix
domain socket created by the Xenomai initialization code that "sh" has
inherited from "exectest".

This seems to suggest that FD_CLOEXEC should be set on the client-side 
socket
in the registry client code.

Finally, this causes the "find /run/xenomai" command to hang (until 
interrupted
by Control-C or other) indefinitely.

Here is the pertinent part of an strace of that "find /run/xenomai" command

<<<<<<  >>>>>>>>

lstat64("/run/xenomai", {st_mode=S_IFDIR|0755, st_size=60, ...}) = 0
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(207, 17), ...}) = 0
ioctl(1, TCGETS, {B115200 opost isig icanon echo ...}) = 0
write(1, "/run/xenomai\n", 13/run/xenomai
)          = 13
open("/run/xenomai", 
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 5
fstat64(5, {st_mode=S_IFDIR|0755, st_size=60, ...}) = 0
getdents64(5, /* 3 entries */, 32768)   = 72
lstat64("/run/xenomai/root", {st_mode=S_IFDIR|0755, st_size=60, ...}) = 0
write(1, "/run/xenomai/root\n", 18/run/xenomai/root
)     = 18
open("/run/xenomai/root", 
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 6
fstat64(6, {st_mode=S_IFDIR|0755, st_size=60, ...}) = 0
getdents64(6, /* 3 entries */, 32768)   = 80
lstat64("/run/xenomai/root/mysession", {st_mode=S_IFDIR|0755, 
st_size=100, ...}) = 0
write(1, "/run/xenomai/root/mysession\n", 28/run/xenomai/root/mysession
) = 28
open("/run/xenomai/root/mysession", 
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 7
fstat64(7, {st_mode=S_IFDIR|0755, st_size=100, ...}) = 0
getdents64(7, /* 5 entries */, 32768)   = 128
lstat64("/run/xenomai/root/mysession/1811",

<<<<<<  >>>>>>>>

That last lstat64() is what hangs indefinitely.


Thank you in advance.
Steve


