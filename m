MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <54F716CC.1010600@xenomai.org>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F5BE3F.4010008@xenomai.org> <54F5C020.8090102@xenomai.org>
 <CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>
 <54F5CD4D.8080004@xenomai.org>
 <CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>
 <54F5D6C6.40908@xenomai.org>
 <CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>
 <54F5E958.2090701@xenomai.org> <54F5EA06.4040104@xenomai.org>
 <CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>
 <54F60A62.3020708@xenomai.org> <54F60C16.5070500@xenomai.org>
 <CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>
 <54F614EF.7040307@xenomai.org>
 <CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>
 <54F6C50F.5040301@xenomai.org>
 <CAKk99t1LaQg9HJkXuiXbi09Mhr5H2EXqcmHw5PPTN4=V7mT3Dg@mail.gmail.com>
 <54F6EF2E.1090705@xenomai.org>
 <CAKk99t3K=+Eo+Z_+nPEgi6FNWzg8gigZGfMnVW3Ap+XkVb5aTg@mail.gmail.com>
 <54F716CC.1010600@xenomai.org>
Date: Wed, 4 Mar 2015 15:26:54 +0000
Message-ID: <CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I reinstall xenomai enabling debug support:

/usr/xenomai/sbin/version -a
Xenomai/mercury v3.0-rc3 --
Target: i686-pc-linux-gnu
Compiler: gcc version 4.7.2 (Debian 4.7.2-5)
Build args:  '--with-core=mercury' '--enable-registry' '--enable-pshared'
'--prefix=/usr/xenomai' '--enable-debug'

Then I removed all the code from the second process (binder.c), now main()
its empty.

Running binder.c while creator.c is running, still gives a segmentation
fault.

Since now there is no code in binder.c I compile it with no Xenomai
support, just gcc binder.c -o binder.
This way it runs (of course does nothing) without segmentation fault.

So it must be something in the initialization of the Xenomai app.
And only happens when another Xenomai app (creator.c) is running.

I did not backtrace it with gdbg yet, but I recompile it (main() still
empty) with Xenomai support and make an strace -f (while creator.c is still
running).
It seems that the segmentation fault happens when trying to lock memory
pages in RAM (called by the initialization code):

execve("./binder", ["./binder"], [/* 18 vars */]) = 0
brk(0)                                  = 0x87b6000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb7791000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65962, ...}) = 0
mmap2(NULL, 65962, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7780000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/libalchemy.so.0", O_RDONLY) = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0pA\0\0004\0\0\0"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=287215, ...}) = 0
mmap2(NULL, 65100, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7770000
mmap2(0xb777f000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf) = 0xb777f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/libcopperplate.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0
a\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=495119, ...}) = 0
mmap2(NULL, 129532, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7750000
mmap2(0xb776d000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d) = 0xb776d000
mmap2(0xb776f000, 2556, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb776f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i386-linux-gnu/i686/cmov/libpthread.so.0", O_RDONLY) = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220L\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=117010, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb774f000
mmap2(NULL, 98816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7736000
mmap2(0xb774b000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb774b000
mmap2(0xb774d000, 4608, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb774d000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i386-linux-gnu/i686/cmov/librt.so.1", O_RDONLY) = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=30684, ...}) = 0
mmap2(NULL, 33360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb772d000
mmap2(0xb7734000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7734000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i386-linux-gnu/libfuse.so.2", O_RDONLY) = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`_\0\0004\0\0\0"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0644, st_size=211296, ...}) = 0
mmap2(NULL, 209924, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb76f9000
mmap2(0xb7723000, 40960, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a) = 0xb7723000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i386-linux-gnu/i686/cmov/libc.so.6", O_RDONLY) = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240o\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1446056, ...}) = 0
mmap2(NULL, 1460600, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7594000
mmap2(0xb76f3000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15e) = 0xb76f3000
mmap2(0xb76f6000, 10616, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76f6000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i386-linux-gnu/i686/cmov/libdl.so.2", O_RDONLY) = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\n\0\0004\0\0\0"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9844, ...}) = 0
mmap2(NULL, 12408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7590000
mmap2(0xb7592000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7592000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb758f000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb758e000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb758e6d0, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}) = 0
mprotect(0xb7592000, 4096, PROT_READ)   = 0
mprotect(0xb76f3000, 8192, PROT_READ)   = 0
mprotect(0xb7723000, 36864, PROT_READ)  = 0
mprotect(0xb7734000, 4096, PROT_READ)   = 0
mprotect(0xb774b000, 4096, PROT_READ)   = 0
mprotect(0xb77b0000, 4096, PROT_READ)   = 0
munmap(0xb7780000, 65962)               = 0
set_tid_address(0xb758e738)             = 3907
set_robust_list(0xb758e740, 0xc)        = 0
futex(0xbfbbcc90, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1, NULL,
bfbbcca0) = -1 EAGAIN (Resource temporarily unavailable)
rt_sigaction(SIGRTMIN, {0xb773a6e0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb773ab70, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
uname({sys="Linux", node="debian", ...}) = 0
clock_gettime(CLOCK_MONOTONIC, {225, 53614430}) = 0
futex(0xb776e504, FUTEX_WAKE_PRIVATE, 2147483647) = 0
gettid()                                = 3907
brk(0)                                  = 0x87b6000
brk(0x87d7000)                          = 0x87d7000
statfs("/dev/shm/", {f_type=0x1021994, f_bsize=4096, f_blocks=70795,
f_bfree=70480, f_bavail=70480, f_files=64349, f_ffree=64342, f_fsid={0, 0},
f_namelen=255, f_frsize=4096}) = 0
futex(0xb7735200, FUTEX_WAKE_PRIVATE, 2147483647) = 0
open("/dev/shm/xeno:(null).main-heap", O_RDWR|O_CREAT|O_NOFOLLOW|O_CLOEXEC,
0600) = 3
flock(3, LOCK_EX)                       = 0
fstat64(3, {st_mode=S_IFREG|0600, st_size=1059164, ...}) = 0
mmap2(NULL, 1059164, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0xb748b000
kill(3903, SIG_0)                       = 0
flock(3, LOCK_UN)                       = 0
close(3)                                = 0
socket(PF_FILE, SOCK_SEQPACKET, 0)      = 3
connect(3, {sa_family=AF_FILE, path=@"DEF365BC-xenomai"}, 19) = 0
recv(3, "/var/run/xenomai/anon/3907\0", 4096, 0) = 27
clock_gettime(CLOCK_MONOTONIC, {225, 54779417}) = 0
mmap2(NULL, 69632, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xb7780000
mprotect(0xb7780000, 4096, PROT_NONE)   = 0
clone(Process 3908 attached
child_stack=0xb7790484,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0xb7790bd8, {entry_number:6, base_addr:0xb7790b70,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}, child_tidptr=0xb7790bd8) = 3908
[pid  3907] futex(0xb776e94c, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...>
[pid  3908] set_robust_list(0xb7790be0, 0xc) = 0
[pid  3908] lstat64("/var", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
[pid  3908] lstat64("/var/run", {st_mode=S_IFLNK|0777, st_size=4, ...}) = 0
[pid  3908] readlink("/var/run", "/run", 4095) = 4
[pid  3908] lstat64("/run", {st_mode=S_IFDIR|0755, st_size=880, ...}) = 0
[pid  3908] lstat64("/run/xenomai", {st_mode=S_IFDIR|0755, st_size=60,
...}) = 0
[pid  3908] lstat64("/run/xenomai/anon", {st_mode=S_IFDIR|0755,
st_size=180, ...}) = 0
[pid  3908] lstat64("/run/xenomai/anon/3907", {st_mode=S_IFDIR|0755,
st_size=40, ...}) = 0
[pid  3908] open("/dev/null", O_RDWR|O_LARGEFILE) = 4
[pid  3908] close(4)                    = 0
[pid  3908] stat64("/run/xenomai/anon/3907", {st_mode=S_IFDIR|0755,
st_size=40, ...}) = 0
[pid  3908] open("/run/xenomai/anon/3907",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 4
[pid  3908] getdents64(4, /* 2 entries */, 32768) = 48
[pid  3908] getdents64(4, /* 0 entries */, 32768) = 0
[pid  3908] close(4)                    = 0
[pid  3908] open("/dev/fuse", O_RDWR|O_LARGEFILE) = 4
[pid  3908] getgid32()                  = 0
[pid  3908] getuid32()                  = 0
[pid  3908] mount("binder", "/run/xenomai/anon/3907", "fuse.binder",
MS_NOSUID|MS_NODEV, "default_permissions,fd=4,rootmod"...) = 0
[pid  3908] geteuid32()                 = 0
[pid  3908] lstat64("/run", {st_mode=S_IFDIR|0755, st_size=880, ...}) = 0
[pid  3908] lstat64("/run/xenomai", {st_mode=S_IFDIR|0755, st_size=60,
...}) = 0
[pid  3908] lstat64("/run/xenomai/anon", {st_mode=S_IFDIR|0755,
st_size=180, ...}) = 0
[pid  3908] lstat64("/etc/mtab", {st_mode=S_IFLNK|0777, st_size=12, ...}) =
0
[pid  3908] getuid32()                  = 0
[pid  3908] mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb748a000
[pid  3908] rt_sigaction(SIGHUP, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid  3908] rt_sigaction(SIGHUP, {0xb7712ed0, [], 0}, NULL, 8) = 0
[pid  3908] rt_sigaction(SIGINT, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid  3908] rt_sigaction(SIGINT, {0xb7712ed0, [], 0}, NULL, 8) = 0
[pid  3908] rt_sigaction(SIGTERM, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid  3908] rt_sigaction(SIGTERM, {0xb7712ed0, [], 0}, NULL, 8) = 0
[pid  3908] rt_sigaction(SIGPIPE, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid  3908] rt_sigaction(SIGPIPE, {SIG_IGN, [], 0}, NULL, 8) = 0
[pid  3908] mmap2(NULL, 139264, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7468000
[pid  3908] read(4,
"8\0\0\0\32\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
135168) = 56
[pid  3908] rt_sigaction(SIGTERM, {SIG_DFL, [], 0}, NULL, 8) = 0
[pid  3908] rt_sigaction(SIGHUP, {SIG_DFL, [], 0}, NULL, 8) = 0
[pid  3908] rt_sigaction(SIGINT, {SIG_DFL, [], 0}, NULL, 8) = 0
[pid  3908] rt_sigaction(SIGPIPE, {SIG_DFL, [], 0}, NULL, 8) = 0
[pid  3908] futex(0xb776e94c, FUTEX_WAKE_PRIVATE, 1) = 1
[pid  3907] <... futex resumed> )       = 0
[pid  3907] sched_get_priority_max(SCHED_FIFO) = 99
[pid  3907] rt_sigaction(SIGRT_12, {0xb775aa90, [], SA_RESTART}, NULL, 8) =
0
[pid  3907] rt_sigaction(SIGRT_13, {0xb775ab50, [], SA_RESTART}, NULL, 8) =
0
[pid  3907] rt_sigaction(SIGRT_10, {0xb775ab40, [], SA_RESTART}, NULL, 8) =
0
[pid  3907] rt_sigaction(SIGRT_11, {0xb775aad0, [], SA_RESTART}, NULL, 8) =
0
[pid  3907] rt_sigaction(SIGRT_15, {0xb775aad0, [], SA_RESTART}, NULL, 8) =
0
[pid  3907] rt_sigprocmask(SIG_BLOCK, [RT_14], NULL, 8) = 0
[pid  3907] mmap2(NULL, 69632, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xb7457000
[pid  3907] mprotect(0xb7457000, 4096, PROT_NONE) = 0
[pid  3907] clone(Process 3909 attached
child_stack=0xb7467484,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0xb7467bd8, {entry_number:6, base_addr:0xb7467b70,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}, child_tidptr=0xb7467bd8) = 3909
[pid  3907] futex(0xbfbbca38, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...>
[pid  3908] writev(4, [{"(\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0", 16},
{"\7\0\0\0\22\0\0\0\0\0\2\0\20\0\0\0\0\0\0\0\0\0\2\0", 24}], 2) = 40
[pid  3908] read(4,  <unfinished ...>
[pid  3909] set_robust_list(0xb7467be0, 0xc) = 0
[pid  3909] gettid()                    = 3909
[pid  3909] prctl(PR_SET_NAME, 0xb7767adf, 0, 0, 0) = 0
[pid  3909] futex(0xbfbbca38, FUTEX_WAKE_PRIVATE, 1) = 1
[pid  3907] <... futex resumed> )       = 0
[pid  3907] gettid()                    = 3907
[pid  3907] prctl(PR_SET_NAME, 0xb74935a8, 0, 0, 0) = 0
[pid  3907] rt_sigprocmask(SIG_BLOCK, [RT_11 RT_15], NULL, 8) = 0
[pid  3907] timer_create(0xfffffffe /* CLOCK_??? */, {(nil), 45,
SIGEV_THREAD_ID, {3907}}, {0x1}) = 0
[pid  3907] mlockall(MCL_CURRENT|MCL_FUTURE) = 0
[pid  3907] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
[pid  3908] +++ killed by SIGSEGV +++
[pid  3909] +++ killed by SIGSEGV +++










it still gives a segmentation fault

On 4 March 2015 at 14:29, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/04/2015 03:25 PM, Helder Daniel wrote:
> > I reinstalled xenomai with pshared enabled but it still do not work.
> > Second process gives now a segmentation fault when trying to bind.
> > If executed with --no-registry (it will not bind of course) but it does
> > not segment fault also.
> >
>
> In case of a segfault,  run the application over gdb, so that you can
> provide the backtrace. Building with --enable-debug will help.
>
> > /usr/xenomai/sbin/version -a
> > Xenomai/mercury v3.0-rc3 --
> > Target: i686-pc-linux-gnu
> > Compiler: gcc version 4.7.2 (Debian 4.7.2-5)
> > Build args:  '--with-core=mercury' '--enable-registry'
> > '--enable-pshared' '--prefix=/usr/xenomai'
> >
> >
> > On 4 March 2015 at 11:40, Philippe Gerum <rpm@xenomai.org
> > <mailto:rpm@xenomai.org>> wrote:
> >
> >     On 03/04/2015 12:21 PM, Helder Daniel wrote:
> >     > Ok.
> >     > This way I can recover registry.
> >     > I did not find yet when and why registry crashes.
> >     > If I found the scenario I'll report it.
> >     >
> >     > Meanwhile I am having roubles binding to a semaphore created in one
> >     > process, from another process.
> >     > I used a simple demo app to show what is happening (full source
> code
> >     > attached)
> >     >
> >     > From one process (creator.c) a semaphore is created and binded by
> its
> >     > registry name "namedSem":
> >     >
> >     > rt_task_shadow (&task, "creatorTask", 20, 0);
> >     > rt_sem_create(&sem, "namedSem", 0, S_FIFO);
> >     > rt_sem_bind(&sem, "namedSem", TM_INFINITE);
> >     > for (;;) sleep (100);
> >     >
> >     > So all ok here.
> >     >
> >     > Now keeping creator.c running in an xterm and trying to bind to
> this
> >     > semaphore from another process (binder.c), from another xterm, it
> does
> >     > not work:
> >     >
> >     > rt_task_shadow (&task, "binderTask", 20, 0);
> >     > rt_sem_bind(&sem, "namedSem", TM_INFINITE);
> >     >
> >     > rt_sem_bind() never binds to the semaphore "namedSem".
> >     > It seams it does not find it.
> >     > If a timeout is set:
> >     >
> >     > err=rt_sem_bind(&sem, "namedSem", TM_INFINITE);
> >     >
> >     > it returns with error -110 (ETIMEDOUT)
> >     >
> >     > But the semaphore exists in registry:
> >     >
> >     > $> cat /var/run/xenomai/anon/4267/alchemy/semaphores/namedSem
> >     > =0
> >     >
> >     > I think on version 2.5.x a named object is global to the system.
> >     > So when creating a semaphore named "namedSem" by a process it is
> >     visible
> >     > for all other processes.
> >     >
> >     > Maybe in 3.x semaphores (and other objects) are local to processes?
> >     > Since they are stored in the registry under the pid of the creator
> >     process?
> >
> >     With 3.x, --enable-pshared must be passed to enable object sharing
> >     between processes. The actual registry is not maintained in kernel
> space
> >     anymore, so the support libraries have to know whether they should
> >     maintain it.
> >
> >     --
> >     Philippe.
> >
> >
> >
> >
> > --
> > Helder Daniel
> > UALG - FCT
> > DEEI
> >
> > http://w3.ualg.pt/~hdaniel
>
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
