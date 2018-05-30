References: <799ac855-b6ed-f9b3-72b4-bcb614a75922@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <11524d56-14d2-23ae-f4b1-44baa2f52291@xenomai.org>
Date: Wed, 30 May 2018 19:02:36 +0200
MIME-Version: 1.0
In-Reply-To: <799ac855-b6ed-f9b3-72b4-bcb614a75922@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Application startup deadlock over debug backtrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 05/30/2018 12:19 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> I just managed to lock up my application using the next branch and, ok,
> a number of custom patches. However, the backtrace itself does not seem
> to point to those changes:
> 
> #0  0x00007f90232975fb in __lll_lock_wait_private () from /lib64/libc.so.6
> #1  0x00007f9023223bfa in _L_lock_10389 () from /lib64/libc.so.6
> #2  0x00007f9023221735 in malloc () from /lib64/libc.so.6
> #3  0x00007f90241d004a in local_strdup () from /lib64/ld-linux-x86-64.so.2
> #4  0x00007f90241d3343 in _dl_map_object () from /lib64/ld-linux-x86-64.so.2
> #5  0x00007f90241dd925 in dl_open_worker () from /lib64/ld-linux-x86-64.so.2
> #6  0x00007f90241d97e4 in _dl_catch_error () from /lib64/ld-linux-x86-64.so.2
> #7  0x00007f90241dd33b in _dl_open () from /lib64/ld-linux-x86-64.so.2
> #8  0x00007f90232c0432 in do_dlopen () from /lib64/libc.so.6
> #9  0x00007f90241d97e4 in _dl_catch_error () from /lib64/ld-linux-x86-64.so.2
> #10 0x00007f90232c04cf in dlerror_run () from /lib64/libc.so.6
> #11 0x00007f90232c0541 in __libc_dlopen_mode () from /lib64/libc.so.6
> #12 0x00007f9023297ea5 in init () from /lib64/libc.so.6
> #13 0x00007f9023762420 in pthread_once () from /lib64/libpthread.so.0
> #14 0x00007f9023297fbc in backtrace () from /lib64/libc.so.6
> #15 0x00007f9023b88d80 in cobalt_sigshadow_handler (sig=sig@entry=28, 
>     si=si@entry=0x7ffceea715b0, ctxt=ctxt@entry=0x7ffceea71480)
>     at ../../../lib/cobalt/sigshadow.c:55
> #16 0x00007f9023b88dca in sigshadow_handler (sig=28, si=0x7ffceea715b0, 
>     ctxt=0x7ffceea71480) at ../../../lib/cobalt/sigshadow.c:80
> #17 <signal handler called>
> #18 0x00007f902328718a in mmap64 () from /lib64/libc.so.6
> #19 0x00007f90232204dd in _int_malloc () from /lib64/libc.so.6
> #20 0x00007f9023221740 in malloc () from /lib64/libc.so.6
> #21 0x00007f9023972925 in __real_malloc (size=<optimized out>)
>     at ../../../lib/cobalt/malloc-nowrap.c:23
> #22 0x00007f9023da76cc in heapobj_pkg_init_private ()
>     at ../../../lib/copperplate/heapobj-heapmem.c:80
> #23 0x00007f9023da30c4 in copperplate_init ()
>     at ../../../lib/copperplate/init.c:199
> #24 0x00007f9023b8efc3 in __xenomai_init (argcp=argcp@entry=0x7ffceea71af4, 
>     argvp=argvp@entry=0x7ffceea71af8, me=me@entry=0x7f9023b9333d "program")
>     at ../../../lib/boilerplate/setup.c:605
> #25 0x00007f9023b8f5ca in xenomai_init (argcp=argcp@entry=0x7ffceea71af4, 
>     argvp=argvp@entry=0x7ffceea71af8) at ../../../lib/boilerplate/setup.c:660
> #26 0x0000000000400d32 in call_init (argvp=0x7ffceea71af8, 
>     argcp=0x7ffceea71af4) at ../../../../lib/boilerplate/init/bootstrap.c:105
> #27 xenomai_bootstrap () at ../../../../lib/boilerplate/init/bootstrap.c:169
> #28 0x000000000040106d in __libc_csu_init (argc=1, argv=0x7ffceea71c48, 
>     envp=0x7ffceea71c58) at elf-init.c:88
> #29 0x00007f90231c7a95 in __libc_start_main () from /lib64/libc.so.6
> #30 0x0000000000400d89 in _start () at ../sysdeps/x86_64/start.S:118
> 
> Xenomai libs where configured with --enable-dlopen-libs, 
> --enable-lazy-setsched and --enable-debug, the kernel with
> CONFIG_XENO_OPT_DEBUG_TRACE_RELAX (which is what enables that
> sighshadow-based tracing, right?).
> 
> My feeling is that there is generic issue produced here.
> 

It looks like backtrace() is dlopening libgcc_s.so at first call. Some
preload during the process startup may work around this issue.
cobalt_corectl() can be tell us dynamically whether
CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is enabled in the kernel
(_CC_COBALT_DEBUG_TRACE_RELAX).


-- 
Philippe.

