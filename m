Message-ID: <4EF27CD5.4060603@domain.hid>
Date: Wed, 21 Dec 2011 19:41:57 -0500
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Summary: I am having a problem running rtcansend/recv on Xenomai 2.6.0,
with the processes hanging in their cleanup code.

I had been running Xenomai on an Intel Atom system with a PEAK PCI
SJA1000 CAN adapter.

I was running Linux 2.5.35.7 with Xenomai 2.5.5.2.  I connected a servo
and motor to the PEAK adapter, and I was able to talk with it using
rtcansend and rtcanrecv.

After working on other things for a few months, I need to return to this
project, so I downloaded the latest Linux/Xenomai pair, which I think is
Linux 2.5.38.8 and Xenomai 2.6.0.

I was able to compile these (using the Debian build advice, generating
.deb files for Linux and Xenomai, which I install with dpkg -i).  I used
a Linux .config derived from my older build.

With both the new and old installs, I am able to run xeno-test and get
decent latencies and such, though some of the tests fail depending on
what I have configured in Realtime/Drivers/Testing Drivers.  That is not
what I'm asking about.



I am having a problem running rtcansend/recv on Xenomai 2.6.0:

I can run rtcanconfig and it sets up my rtcan0 properly so I can see and
configure the servo.  The data in /proc/rtcan looks ok.

But when I try to talk with the servo using rtcansend, the rtcansend
process fails during the close phase, it looks like this:

$ rtcansend rtcan0 -v -i 0x0 0x82 0x1
interface rtcan0
s=0, ifr_name=rtcan0
<0x000> [2] 82 01
Cleaning up...
^CSignal 2 received
Cleaning up...
$

So it hangs after the first "Cleaning up..." and I hit Control-C and
then it catches the ^C and exits.  The code at the bottom of

   xenomai-2.6.0/src/utils/can/rtcansend.c

looks like this:

    ...
    cleanup();
    return 0;

 failure:
    cleanup();
    return -1;
}

and cleanup is printing "Cleaning up..." twice, so maybe both of those
are being called?  I'm not sure.

Under 2.5.5.2, the same command runs normally and exits cleanly:

$ rtcansend rtcan0 -v -i 0x0 0x82 0x1
interface rtcan0
s=0, ifr_name=rtcan0
<0x000> [2] 82 01
Cleaning up...
$


I have strace output from both of the builds (running something
similar, where it rtcansend loops with a delay, long enough for me to
catch the problem with it:

Working 2.5.5.2 strace:

$ tail -25 str.rtcs.2.5.5.2.ok.out
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "Cleaning up...\n", 15)        = 15
nanosleep({0, 100000000}, NULL)         = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=69045, ...}) = 0
mmap2(NULL, 69045, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76c6000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p#\0\0004\0\0\0"...,
512) = 512
brk(0)                                  = 0x9b3c000
brk(0x9b5d000)                          = 0x9b5d000
fstat64(3, {st_mode=S_IFREG|0644, st_size=120368, ...}) = 0
mmap2(NULL, 123432, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb76a7000
mmap2(0xb76c4000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1c) = 0xb76c4000
close(3)                                = 0
mprotect(0xb76c4000, 4096, PROT_READ)   = 0
munmap(0xb76c6000, 69045)               = 0
futex(0xb76c50e8, FUTEX_WAKE_PRIVATE, 2147483647) = 0
exit_group(0)                           = ?
Process 1766 detached


Broken 2.6.0 strace:

$ tail -25 str.rtcs.2.6.0.hang.out
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "<0x000> [2] 82 01\n", 18)     = 18
write(1, "Cleaning up...\n", 15)        = 15
nanosleep({0, 100000000}, NULL)         = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=68769, ...}) = 0
mmap2(NULL, 68769, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7590000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p#\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=120368, ...}) = 0
mmap2(NULL, 123432, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb7571000
mmap2(0xb758e000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1c) = 0xb758e000
close(3)                                = 0
mprotect(0xb758e000, 4096, PROT_READ)   = 0
munmap(0xb7590000, 68769)               = 0
futex(0xb758f0e8, FUTEX_WAKE_PRIVATE, 2147483647) = 0
_exit(0)                                = ?
Process 8114 detached
$

If I just run rtcansend with no args (so it prints a help message), it
exits ok on 2.6.0 with no hang.  But if I run rtcansend or rtcanrecv
with any CAN i/o, they hang in the cleanup function, though they do
their processing before then correctly.

Any idea why rtcansend/recv would hang for me here on 2.6.0?

Andy

