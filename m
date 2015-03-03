MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F58A4C.7030006@xenomai.org>
 <CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>
 <54F5BE3F.4010008@xenomai.org> <54F5C020.8090102@xenomai.org>
 <CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>
Date: Tue, 3 Mar 2015 15:03:06 +0000
Message-ID: <CAKk99t0EwxWeXZQ89QNSEjQO3759W1c7CkYpc06xKqXmAD0sVQ@mail.gmail.com>
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

PS:

When I said above "(possibly a bad patch)" I meant a bad patching
application.
I must be doing something wrong.
I am trying again to apply the ipipe patch and configure kernel from
scratch now on a physical machine.

thank for all your help,

Helder

On 3 March 2015 at 14:58, Helder Daniel <hdaniel@ualg.pt> wrote:

>
>> No actually, you don't need that if sysregd still appears in
>> $prefix/sbin as built.
>>
>> Please send the output of "strace -f" on the latency executable.
>>
>> Ok. I tried putting sbin in the search path and gave the same error.
>
> I am running these test now on an installation of Mercury (already on an
> AMD Sempron physical system).
>
> /usr/xenomai/bin/latency runs fine on this installation (the issue with
> latency not running is with Cobalt installation)
>
> I think I have 2 different problems:
>
> 1) can not use Xenomai registry in Mercury and Cobalt.
>
> 2) actually I can not run anything at all in Cobalt installation (possibly
> a bad patch)
>
> To test registry in Mercury I tried to run a simple app, that gives the
> registry daemon error:
>
> ./hello
>    3"002.332| WARNING: [main] cannot connect to registry daemon
>    3"002.425| BUG: [main] initialization failed, EAGAIN
>
> The code is just that below. It makes no calls to Xenomai libs:
>
> #include <stdio.h>
> main() {
>     puts ("Hello");
>     return 0;
> }
>
> But it was compiled with Xenomai support. Makefile:
>
> target =  hello
>
> CFLAGS  := $(shell xeno-config --skin=$(skin) --cflags)
> LDFLAGS := $(shell xeno-config --skin=$(skin) --ldflags)
>
> $(target): $(target).c
>     $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>
> The strace -f of this simple app is below.
> (After this trace is also the strace -f of latency, which runs fine in
> Mercury, but I guess you might want the starce of the not running latency
> executable in Cobalt?)
>
> $> strace -f ./hello
> execve("./hello", ["./hello"], [/* 18 vars */]) = 0
> brk(0)                                  = 0x97bf000
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7705000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=74726, ...}) = 0
> mmap2(NULL, 74726, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76f2000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libalchemy.so.0", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200=\0\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=66781, ...}) = 0
> mmap2(NULL, 77164, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb76df000
> mmap2(0xb76ec000, 4096, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc) = 0xb76ec000
> mmap2(0xb76ed000, 19820, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76ed000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/usr/xenomai/lib/libcopperplate.so.0", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0pW\0\0004\0\0\0"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=111928, ...}) = 0
> mmap2(NULL, 98184, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb76c7000
> mmap2(0xb76dd000, 4096, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16) = 0xb76dd000
> mmap2(0xb76de000, 3976, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76de000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libpthread.so.0", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220L\0\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=117010, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb76c6000
> mmap2(NULL, 98816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb76ad000
> mmap2(0xb76c2000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb76c2000
> mmap2(0xb76c4000, 4608, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76c4000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/librt.so.1", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30\0\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=30684, ...}) = 0
> mmap2(NULL, 33360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb76a4000
> mmap2(0xb76ab000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb76ab000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/libfuse.so.2", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`_\0\0004\0\0\0"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=211296, ...}) = 0
> mmap2(NULL, 209924, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
> = 0xb7670000
> mmap2(0xb769a000, 40960, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a) = 0xb769a000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libc.so.6", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240o\1\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1446056, ...}) = 0
> mmap2(NULL, 1456504, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
> = 0xb750c000
> mmap2(0xb766a000, 12288, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15e) = 0xb766a000
> mmap2(0xb766d000, 10616, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb766d000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libdl.so.2", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\n\0\0004\0\0\0"..., 512)
> = 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=9844, ...}) = 0
> mmap2(NULL, 12408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb7508000
> mmap2(0xb750a000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb750a000
> close(3)                                = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7507000
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7506000
> set_thread_area({entry_number:-1 -> 6, base_addr:0xb75066d0,
> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) = 0
> mprotect(0xb750a000, 4096, PROT_READ)   = 0
> mprotect(0xb766a000, 8192, PROT_READ)   = 0
> mprotect(0xb769a000, 36864, PROT_READ)  = 0
> mprotect(0xb76ab000, 4096, PROT_READ)   = 0
> mprotect(0xb76c2000, 4096, PROT_READ)   = 0
> mprotect(0xb7724000, 4096, PROT_READ)   = 0
> munmap(0xb76f2000, 74726)               = 0
> set_tid_address(0xb7506738)             = 4037
> set_robust_list(0xb7506740, 0xc)        = 0
> futex(0xbff4bb00, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1, NULL,
> bff4bb10) = -1 EAGAIN (Resource temporarily unavailable)
> rt_sigaction(SIGRTMIN, {0xb76b16e0, [], SA_SIGINFO}, NULL, 8) = 0
> rt_sigaction(SIGRT_1, {0xb76b1b70, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
> uname({sys="Linux", node="LinuxSTR", ...}) = 0
> clock_gettime(CLOCK_MONOTONIC, {1865, 334707182}) = 0
> futex(0xb76ddaa8, FUTEX_WAKE_PRIVATE, 2147483647) = 0
> gettid()                                = 4037
> brk(0)                                  = 0x97bf000
> brk(0x97e0000)                          = 0x97e0000
> mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7702000
> mmap2(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7405000
> socket(PF_FILE, SOCK_SEQPACKET, 0)      = 3
> connect(3, {sa_family=AF_FILE, path=@"DEF365BC-xenomai"}, 19) = -1
> ECONNREFUSED (Connection refused)
> close(3)                                = 0
> rt_sigaction(SIGCHLD, {SIG_IGN, [], 0}, NULL, 8) = 0
> vfork(Process 4038 attached
> )                                 = 4038
> [pid  4037] rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> [pid  4037] rt_sigaction(SIGCHLD, NULL, {SIG_IGN, [], 0}, 8) = 0
> [pid  4037] nanosleep({1, 0},  <unfinished ...>
> [pid  4038] execve("NONE/sbin/sysregd", ["sysregd", "--daemon", "--root",
> "/var/run/xenomai/anon"], [/* 18 vars */]) = -1 ENOENT (No such file or
> directory)
> [pid  4038] exit_group(1)               = ?
> Process 4038 detached
> <... nanosleep resumed> 0xbff4b8c4)     = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> rt_sigaction(SIGCHLD, {0xb76d66d0, [], SA_RESTART}, NULL, 8) = 0
> socket(PF_FILE, SOCK_SEQPACKET, 0)      = 3
> connect(3, {sa_family=AF_FILE, path=@"DEF365BC-xenomai"}, 19) = -1
> ECONNREFUSED (Connection refused)
> close(3)                                = 0
> rt_sigaction(SIGCHLD, {SIG_IGN, [], 0}, NULL, 8) = 0
> vfork(Process 4039 attached
> )                                 = 4039
> [pid  4037] rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> [pid  4037] rt_sigaction(SIGCHLD, NULL, {SIG_IGN, [], 0}, 8) = 0
> [pid  4037] nanosleep({1, 0},  <unfinished ...>
> [pid  4039] execve("NONE/sbin/sysregd", ["sysregd", "--daemon", "--root",
> "/var/run/xenomai/anon"], [/* 18 vars */]) = -1 ENOENT (No such file or
> directory)
> [pid  4039] exit_group(1)               = ?
> Process 4039 detached
> <... nanosleep resumed> 0xbff4b8c4)     = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> rt_sigaction(SIGCHLD, {0xb76d66d0, [], SA_RESTART}, NULL, 8) = 0
> socket(PF_FILE, SOCK_SEQPACKET, 0)      = 3
> connect(3, {sa_family=AF_FILE, path=@"DEF365BC-xenomai"}, 19) = -1
> ECONNREFUSED (Connection refused)
> close(3)                                = 0
> rt_sigaction(SIGCHLD, {SIG_IGN, [], 0}, NULL, 8) = 0
> vfork(Process 4040 attached
> )                                 = 4040
> [pid  4037] rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> [pid  4037] rt_sigaction(SIGCHLD, NULL, {SIG_IGN, [], 0}, 8) = 0
> [pid  4037] nanosleep({1, 0},  <unfinished ...>
> [pid  4040] execve("NONE/sbin/sysregd", ["sysregd", "--daemon", "--root",
> "/var/run/xenomai/anon"], [/* 18 vars */]) = -1 ENOENT (No such file or
> directory)
> [pid  4040] exit_group(1)               = ?
> Process 4040 detached
> <... nanosleep resumed> 0xbff4b8c4)     = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> rt_sigaction(SIGCHLD, {0xb76d66d0, [], SA_RESTART}, NULL, 8) = 0
> clock_gettime(CLOCK_MONOTONIC, {1868, 344105213}) = 0
> rt_sigprocmask(SIG_BLOCK, [RT_10], [], 8) = 0
> write(2, "   3\"009.398| ", 14   3"009.398| )         = 14
> write(2, "WARNING: ", 9WARNING: )                = 9
> write(2, "[main] ", 7[main] )                  = 7
> write(2, "cannot connect to registry daemo"..., 33cannot connect to
> registry daemon) = 33
> write(2, "\n", 1
> )                       = 1
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> clock_gettime(CLOCK_MONOTONIC, {1868, 344487920}) = 0
> rt_sigprocmask(SIG_BLOCK, [RT_10], [], 8) = 0
> write(2, "   3\"009.780| ", 14   3"009.780| )         = 14
> write(2, "BUG: ", 5BUG: )                    = 5
> write(2, "[main] ", 7[main] )                  = 7
> write(2, "initialization failed, EAGAIN", 29initialization failed, EAGAIN)
> = 29
> write(2, "\n", 1
> )                       = 1
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> exit_group(1)                           = ?
>
>
>
> =================
> The strace -f of latency
> =================
>
> This is the output to STDIN (so its running on Mercury but not in Cobalt)
> Below is the strace (STDERR output)
>
> strace -f latency 2> t
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> RTD|     33.361|     35.795|   1835.884|      47|     0|     33.361|
> 1835.884
> RTD|     33.354|     38.507|   6591.060|     219|     0|     33.354|
> 6591.060
> (...)
>
> STRACE:
>
> $> head stderr.output -n 150
> execve("/usr/xenomai/bin/latency", ["latency"], [/* 18 vars */]) = 0
> brk(0)                                  = 0x902a000
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7720000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=74726, ...}) = 0
> mmap2(NULL, 74726, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb770d000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/libfuse.so.2", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`_\0\0004\0\0\0"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=211296, ...}) = 0
> mmap2(NULL, 209924, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
> = 0xb76d9000
> mmap2(0xb7703000, 40960, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a) = 0xb7703000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libpthread.so.0", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220L\0\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=117010, ...}) = 0
> mmap2(NULL, 98816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb76c0000
> mmap2(0xb76d5000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb76d5000
> mmap2(0xb76d7000, 4608, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76d7000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/librt.so.1", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30\0\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=30684, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb76bf000
> mmap2(NULL, 33360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb76b6000
> mmap2(0xb76bd000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb76bd000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libm.so.6", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2604\0\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=148996, ...}) = 0
> mmap2(NULL, 151680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
> = 0xb7690000
> mmap2(0xb76b4000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x23) = 0xb76b4000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libc.so.6", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240o\1\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1446056, ...}) = 0
> mmap2(NULL, 1456504, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
> = 0xb752c000
> mmap2(0xb768a000, 12288, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15e) = 0xb768a000
> mmap2(0xb768d000, 10616, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb768d000
> close(3)                                = 0
> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
> directory)
> open("/lib/i386-linux-gnu/i686/cmov/libdl.so.2", O_RDONLY) = 3
> read(3,
> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\n\0\0004\0\0\0"..., 512)
> = 512
> fstat64(3, {st_mode=S_IFREG|0644, st_size=9844, ...}) = 0
> mmap2(NULL, 12408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0xb7528000
> mmap2(0xb752a000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb752a000
> close(3)                                = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7527000
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb7526000
> set_thread_area({entry_number:-1 -> 6, base_addr:0xb75266c0,
> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) = 0
> mprotect(0xb752a000, 4096, PROT_READ)   = 0
> mprotect(0xb768a000, 8192, PROT_READ)   = 0
> mprotect(0xb76b4000, 4096, PROT_READ)   = 0
> mprotect(0xb76bd000, 4096, PROT_READ)   = 0
> mprotect(0xb76d5000, 4096, PROT_READ)   = 0
> mprotect(0xb7703000, 36864, PROT_READ)  = 0
> mprotect(0xb773f000, 4096, PROT_READ)   = 0
> munmap(0xb770d000, 74726)               = 0
> set_tid_address(0xb7526728)             = 4215
> set_robust_list(0xb7526730, 0xc)        = 0
> futex(0xbffec710, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1, NULL,
> bffec720) = -1 EAGAIN (Resource temporarily unavailable)
> rt_sigaction(SIGRTMIN, {0xb76c46e0, [], SA_SIGINFO}, NULL, 8) = 0
> rt_sigaction(SIGRT_1, {0xb76c4b70, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
> uname({sys="Linux", node="LinuxSTR", ...}) = 0
> time(NULL)                              = 1425394452
> brk(0)                                  = 0x902a000
> brk(0x904b000)                          = 0x904b000
> rt_sigprocmask(SIG_BLOCK, [HUP INT ALRM TERM], NULL, 8) = 0
> fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 0), ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> = 0xb771f000
> write(1, "== Sampling period: 100 us\n", 27) = 27
> write(1, "== Test mode: periodic user-mode"..., 69) = 69
> mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
> mmap2(NULL, 8392704, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xb6d25000
> mprotect(0xb6d25000, 4096, PROT_NONE)   = 0
> clone(Process 4216 attached
> child_stack=0xb7525494,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0xb7525bd8, {entry_number:6, base_addr:0xb7525b70,
> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}, child_tidptr=0xb7525bd8) = 4216
> [pid  4215] sched_get_priority_min(SCHED_FIFO) = 1
> [pid  4215] sched_get_priority_max(SCHED_FIFO) = 99
> [pid  4215] mmap2(NULL, 8392704, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0 <unfinished ...>
> [pid  4216] set_robust_list(0xb7525be0, 0xc) = 0
> [pid  4216] prctl(PR_SET_NAME, 0xb7525328, 0x804d2e4, 0, 0xb76c1614) = 0
> [pid  4216] statfs("/dev/shm",  <unfinished ...>
> [pid  4215] <... mmap2 resumed> )       = 0xb6524000
> [pid  4216] <... statfs resumed> {f_type=0x1021994, f_bsize=4096,
> f_blocks=494345, f_bfree=494246, f_bavail=494246, f_files=221793,
> f_ffree=221780, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
> [pid  4216] futex(0xb76d81a4, FUTEX_WAKE_PRIVATE, 2147483647) = 0
> [pid  4216] unlink("/dev/shm/sem.dispsem-4215") = -1 ENOENT (No such file
> or directory)
> [pid  4216] gettimeofday({1425394452, 324990}, NULL) = 0
> [pid  4216] lstat64("/dev/shm/sem.i6kEQQ", 0xb7525180) = -1 ENOENT (No
> such file or directory)
> [pid  4216] open("/dev/shm/sem.i6kEQQ", O_RDWR|O_CREAT|O_EXCL, 0666) = 3
> [pid  4216] write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) = 16
> [pid  4216] mmap2(NULL, 16, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =
> 0xb771e000
> [pid  4216] link("/dev/shm/sem.i6kEQQ", "/dev/shm/sem.dispsem-4215") = 0
> [pid  4216] fstat64(3, {st_mode=S_IFREG|0644, st_size=16, ...}) = 0
> [pid  4216] unlink("/dev/shm/sem.i6kEQQ") = 0
> [pid  4216] close(3)                    = 0
> [pid  4216] time(NULL)                  = 1425394452
> [pid  4216] write(1, "warming up...\n", 14) = 14
> [pid  4216] futex(0xb771e000, FUTEX_WAIT, 0, NULL <unfinished ...>
> [pid  4215] mprotect(0xb6524000, 4096, PROT_NONE) = 0
> [pid  4215] sched_get_priority_min(SCHED_FIFO) = 1
> [pid  4215] sched_get_priority_max(SCHED_FIFO) = 99
> [pid  4215] clone(Process 4217 attached
> child_stack=0xb6d24494,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0xb6d24bd8, {entry_number:6, base_addr:0xb6d24b70,
> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}, child_tidptr=0xb6d24bd8) = 4217
> [pid  4215] sched_setscheduler(4217, SCHED_FIFO, { 99 } <unfinished ...>
> [pid  4217] set_robust_list(0xb6d24be0, 0xc) = 0
> [pid  4217] futex(0xb6d24d84, FUTEX_WAIT_PRIVATE, 2, NULL <unfinished ...>
> [pid  4215] <... sched_setscheduler resumed> ) = 0
> [pid  4215] futex(0xb6d24d84, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
> [pid  4217] <... futex resumed> )       = 0
> [pid  4217] futex(0xb6d24d84, FUTEX_WAKE_PRIVATE, 1) = 0
> [pid  4217] prctl(PR_SET_NAME, 0xb6d24370, 0, 0, 0xb768bff4) = 0
> [pid  4217] timerfd_create(CLOCK_MONOTONIC, 0) = 3
> [pid  4217] clock_gettime(CLOCK_MONOTONIC, {2209, 404514401}) = 0
> [pid  4217] timerfd_settime(3, TFD_TIMER_ABSTIME, {it_interval={0,
> 100000}, it_value={2209, 405514401}}, NULL) = 0
> [pid  4217] read(3,  <unfinished ...>
> [pid  4215] <... futex resumed> )       = 1
> [pid  4215] rt_sigtimedwait([HUP INT ALRM TERM], NULL, NULL, 8 <unfinished
> ...>
> [pid  4217] <... read resumed> "\1\0\0\0\0\0\0\0", 8) = 8
> [pid  4217] clock_gettime(CLOCK_MONOTONIC, {2209, 405588957}) = 0
> [pid  4217] read(3, "\1\0\0\0\0\0\0\0", 8) = 8
> [pid  4217] clock_gettime(CLOCK_MONOTONIC, {2209, 405652882}) = 0
> [pid  4217] read(3, "\1\0\0\0\0\0\0\0", 8) = 8
> [pid  4217] clock_gettime(CLOCK_MONOTONIC, {2209, 405749665}) = 0
> [pid  4217] read(3, "\1\0\0\0\0\0\0\0", 8) = 8
> [pid  4217] clock_gettime(CLOCK_MONOTONIC, {2209, 405849010}) = 0
> [pid  4217] read(3, "\1\0\0\0\0\0\0\0", 8) = 8
> [pid  4217] clock_gettime(CLOCK_MONOTONIC, {2209, 405948555}) = 0
> [pid  4217] read(3, "\1\0\0\0\0\0\0\0", 8) = 8
> (...)
> It continues ....
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
