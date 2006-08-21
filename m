Message-ID: <44E91231.8070403@domain.hid>
Date: Sun, 20 Aug 2006 19:53:53 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] xeno-load: line 182: 2794 Floating point
	exception$suflag $* $cmdargs
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>



I get the above error when running xeno-test,
or when running individually, like so:

soekris:/usr/xenomai/bin# ( cd ../testsuite/switchbench; loudly ./run -- 
-p 10
-n -l 1000 $XENOT_SWITCHBENCH '# switchbench';     )

Sun Aug 20 18:51:53 MDT 2006
running: ./run -- -p 10 -n -l 1000 # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 10 us
== Do not interrupt this program
/usr/xenomai/bin/xeno-load: line 182:  2868 Floating point 
exception$suflag $* $cmdargs



but I dont get it when running it manually, w/o the ./run wrapper.

soekris:/usr/xenomai/testsuite/switchbench# switchbench
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      25.568|      28.740|      45.584|           0
soekris:/usr/xenomai/testsuite/switchbench#
soekris:/usr/xenomai/testsuite/switchbench#

BTW, the line-number given above is a red-herring:

    177 while test -n "$target_info" ; do
    178   action=`echo $target_info|cut -d';' -f1`
    179   target_info=`echo $target_info|cut -s -d';' -f2-`
    180   set -- $action
    181
    182   case "$1" in
    183
    184     push)


I stuffed in an strace, and got this:

+ test ./switchbench = ./switchbench
+ waitflag=1
+ set -- ./switchbench
+ test 0 = 1
+ test 1 = 1
+ echo what ./switchbench -p 10 -n -l 1000
what ./switchbench -p 10 -n -l 1000
+ strace ./switchbench -p 10 -n -l 1000
execve("./switchbench", ["./switchbench", "-p", "10", "-n", "-l", 
"1000"], [/* 14 vars */]) = 0
uname({sys="Linux", node="soekris", ...}) = 0
brk(0)                                  = 0x804d000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f5d000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f5c000
open("/usr/xenomai/lib/tls/i586/cmov/libpthread.so.0", O_RDONLY) = -1 
ENOENT (No such file or directory)
stat64("/usr/xenomai/lib/tls/i586/cmov", 0xbf8e55d4) = -1 ENOENT (No 
such file or directory)
open("/usr/xenomai/lib/tls/i586/libpthread.so.0", O_RDONLY) = -1 ENOENT 
(No such file or directory)
stat64("/usr/xenomai/lib/tls/i586", 0xbf8e55d4) = -1 ENOENT (No such 
file or directory)
open("/usr/xenomai/lib/tls/cmov/libpthread.so.0", O_RDONLY) = -1 ENOENT 
(No such file or directory)
stat64("/usr/xenomai/lib/tls/cmov", 0xbf8e55d4) = -1 ENOENT (No such 
file or directory)
open("/usr/xenomai/lib/tls/libpthread.so.0", O_RDONLY) = -1 ENOENT (No 
such file or directory)
stat64("/usr/xenomai/lib/tls", 0xbf8e55d4) = -1 ENOENT (No such file or 
directory)
open("/usr/xenomai/lib/i586/cmov/libpthread.so.0", O_RDONLY) = -1 ENOENT 
(No such file or directory)
stat64("/usr/xenomai/lib/i586/cmov", 0xbf8e55d4) = -1 ENOENT (No such 
file or directory)
open("/usr/xenomai/lib/i586/libpthread.so.0", O_RDONLY) = -1 ENOENT (No 
such file or directory)
stat64("/usr/xenomai/lib/i586", 0xbf8e55d4) = -1 ENOENT (No such file or 
directory)
open("/usr/xenomai/lib/cmov/libpthread.so.0", O_RDONLY) = -1 ENOENT (No 
such file or directory)
stat64("/usr/xenomai/lib/cmov", 0xbf8e55d4) = -1 ENOENT (No such file or 
directory)
open("/usr/xenomai/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such 
file or directory)
stat64("/usr/xenomai/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=16163, ...}) = 0
mmap2(NULL, 16163, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f58000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260G\0"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=84977, ...}) = 0
mmap2(NULL, 70104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) 
= 0xb7f46000
mmap2(0xb7f54000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb7f54000
mmap2(0xb7f56000, 4568, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f56000
close(3)                                = 0
open("/usr/xenomai/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file 
or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240O\1"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1245680, ...}) = 0
mmap2(NULL, 1251484, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0xb7e14000
mmap2(0xb7f3c000, 28672, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x128) = 0xb7f3c000
mmap2(0xb7f43000, 10396, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f43000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7e13000
mprotect(0xb7f3c000, 20480, PROT_READ)  = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e136c0, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f58000, 16163)               = 0
set_tid_address(0xb7e13708)             = 3538
rt_sigaction(SIGRTMIN, {0xb7f4a420, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb7f4a390, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
open("/proc/sys/kernel/version", O_RDONLY) = 3
read(3, "#1 Sat Aug 19 12:08:22 MDT 2006\n", 512) = 32
close(3)                                = 0
rt_sigaction(SIGXCPU, {0x804a910, [], 0}, NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_IGN}, 8) = 0
rt_sigaction(SIGTERM, {SIG_IGN}, {SIG_DFL}, 8) = 0
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(4, 64), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo 
...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f5b000
write(1, "== Sampling period: 10 us\n", 26== Sampling period: 10 us
) = 26
write(1, "== Do not interrupt this program"..., 33== Do not interrupt 
this program
) = 33
sched_get_priority_max(SCHED_FIFO)      = 99
mmap2(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7e03000
brk(0)                                  = 0x804d000
brk(0x806e000)                          = 0x806e000
mprotect(0xb7e03000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb7e124c4, 
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, 
parent_tidptr=0xb7e12bf8, {entry_number:6, base_addr:0xb7e12bb0, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}, 
child_tidptr=0xb7e12bf8) = 3539
+++ killed by SIGFPE +++
Process 3538 detached
+ test -n popall
echo $target_info|cut -d';' -f1
++ echo popall
++ cut '-d;' -f1
+ action=popall
echo $target_info|cut -s -d';' -f2-
++ echo popall
++ cut -s '-d;' -f2-
+ target_info=
+ set -- popall
+ set -o xtrace
+ set -o verbose



BTW

over the past year, Xenomai has moved away from (at least some) of the 
ideosyncracies
it used to have:

- modules now get installed with rest of kernel, so modprobe etc just work
    this suggests that some parts of xeno-load are now obsolete / 
unnecessary.

- ive set LD_LIBRARY_PATH to make life more convenient

Im (idly) wondering if theres more to do, what things need to be done 
1st, etc..


FWIW  switchtest output is pretty ;-)

