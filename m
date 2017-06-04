MIME-Version: 1.0
From: Jim Langston <jim.langston@gmail.com>
Date: Sun, 4 Jun 2017 12:34:07 -0400
Message-ID: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Issues with Xenomai 3.0.5...
Reply-To: jlangston@panurgyinc.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am attempting to run Xenomai 3.0.5 on an embedded system.

It is being built using Buildroot 2017.02.2, Xenomai 3.0.5, Kernel 4.1.18,
Adeos patch 4.1.18 #9.

The resultant image boots, and I can see that Xenomai is running:


*dmesg | grep -i xeno*
[    1.233003] [Xenomai] scheduling class idle registered.
[    1.233098] [Xenomai] scheduling class rt registered.
[    1.233373] I-pipe: head domain Xenomai registered.
[    1.236591] [Xenomai] Cobalt v3.0.5 (Sisyphus's Boulder)
[    2.208662] udevd[664]: specified group 'xenomai' unknown

But attempting to run ANY of the test apps for Xenomai segfaults:


*strace latency*
execve("/usr/bin/latency", ["latency"], [/* 11 vars */]) = 0
readlinkat(AT_FDCWD, "/proc/self/exe", "/usr/bin/latency", 4096) = 16
mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_UNINITIALIZED, -1, 0) = 0xb7768000
open("/lib/libcobalt.so.2", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/lib/libcobalt.so.2", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/usr/lib/libcobalt.so.2", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=143764, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_UNINITIALIZED, -1, 0) = 0xb7767000
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\211\0\0004\0\0\0"...,
4096) = 4096
mmap2(NULL, 114688, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb774b000
mmap2(0xb774b000, 104088, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0xb774b000
mmap2(0xb7765000, 4584, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x19000) = 0xb7765000
close(3)                                = 0
munmap(0xb7767000, 4096)                = 0
open("/lib/libmodechk.so.0", O_RDONLY)  = -1 ENOENT (No such file or
directory)
open("/lib/libmodechk.so.0", O_RDONLY)  = -1 ENOENT (No such file or
directory)
open("/usr/lib/libmodechk.so.0", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=5476, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_UNINITIALIZED, -1, 0) = 0xb7767000
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\370\4\0\0004\0\0\0"...,
4096) = 4096
mmap2(NULL, 8192, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7749000
mmap2(0xb7749000, 2120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0xb7749000
mmap2(0xb774a000, 2376, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0xb774a000
close(3)                                = 0
munmap(0xb7767000, 4096)                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=644488, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_UNINITIALIZED, -1, 0) = 0xb7767000
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0
\343\0\0004\0\0\0"..., 4096) = 4096
mmap2(NULL, 610304, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb76b4000
mmap2(0xb76b4000, 507852, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0xb76b4000
mmap2(0xb7731000, 4846, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x7c000) = 0xb7731000
mmap2(0xb7733000, 88360, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7733000
close(3)                                = 0
munmap(0xb7767000, 4096)                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=644488, ...}) = 0
close(3)                                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=644488, ...}) = 0
close(3)                                = 0
stat("/lib/ld-uClibc.so.0", {st_mode=S_IFREG|0755, st_size=28764, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_UNINITIALIZED, -1, 0) = 0xb7767000
set_thread_area({entry_number:-1, base_addr:0xb77676a0, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}) = 0 (entry_number:6)
mprotect(0xb7731000, 4096, PROT_READ)   = 0
mprotect(0xb7772000, 4096, PROT_READ)   = 0
set_tid_address(0xb7767708)             = 774
set_robust_list(0xb776770c, 12)         = 0
rt_sigaction(SIGRTMIN, {sa_handler=0xb770517c, sa_mask=[],
sa_flags=SA_RESTORER|SA_SIGINFO, sa_restorer=0xb76c3cb7}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0xb77050b7, sa_mask=[],
sa_flags=SA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=0xb76c3cb7}, NULL,
8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
ugetrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
uname({sysname="Linux", nodename="buildroot", ...}) = 0
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
open("/proc/self/cmdline", O_RDONLY)    = 3
brk(NULL)                               = 0x956b000
brk(0x956c000)                          = 0x956c000
read(3, "latency\0", 1024)              = 8
close(3)                                = 0
gettid()                                = 774
rt_sigaction(SIGILL, {sa_handler=0xb7754c64, sa_mask=[ILL],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0xb76c3cbe},
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGILL, {sa_handler=SIG_DFL, sa_mask=[ILL],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0xb76c3cbe},
{sa_handler=0xb7754c64, sa_mask=[ILL], sa_flags=SA_RESTORER|SA_RESTART,
sa_restorer=0xb76c3cbe}, 8) = 0
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=NULL} ---
+++ killed by SIGSEGV +++
Segmentation fault

(Sorry about the length)

Any ideas on where i could start looking about?  I don't see any causality
here...

Thanks,
Jim
