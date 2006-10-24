Date: Mon, 23 Oct 2006 18:28:09 -0600
From: Sunny <sbhuller@domain.hid>
Subject: RE: [Xenomai-help] rt_queue_read switch to secondary mode
In-reply-to: <1161389393.4988.203.camel@domain.hid>
Message-id: <001101c6f703$4f4a9bd0$6400a8c0@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi Philippe,

	I think I have solved the problem.  I was running

Linux v2.6.17.6  i686
Xenomai: v2.2.0
Adeos: adeos-ipipe-2.6.17.i386-1.3-08
Hardware: Pentium - M 


	Here is what I ended up doing:

1. Upgraded to Xenomai 2.2.4, but the problem still existed.  I ran gdb and
here is the backtrace result:
	------ GDB Backtrace w/ user space debug

	(gdb) r
	Starting program: /root/ipas/apps/skel/test
	[Thread debugging using libthread_db enabled]
	[New Thread -1211242816 (LWP 20349)]
	[New Thread -1208923216 (LWP 20352)]

	Program received signal SIGXCPU, CPU time limit exceeded.
	[Switching to Thread -1208923216 (LWP 20352)]
	0xb7ee5b8b in rt_queue_read (q=0xbfe6ab70, buf=0xb7f14000,
size=1024, timeout=18446744073709551615) at queue.c:164
	164             return XENOMAI_SKINCALL4(__native_muxid,
	Current language:  auto; currently c
	(gdb) bt
	#0  0xb7ee5b8b in rt_queue_read (q=0xbfe6ab70, buf=0xb7f14000,
size=1024, timeout=18446744073709551615) at queue.c:164
	#1  0x08048852 in task_procedure (arg=0xbfe6ab70) at test.cpp:23
	#2  0xb7ee6070 in rt_task_trampoline (cookie=0xbfe6ab70) at
task.c:89
	#3  0xb7eee0fb in start_thread () from /lib/tls/libpthread.so.0
	#4  0xb7d9699e in clone () from /lib/tls/libc.so.6


2. Installed adeos-ipipe-2.6.17-1.5-01
3. Set kernel option CONFIG_PREEMPT


	I no longer get the SIGXCPU switch.  Thanks for all of your help!

-- Sunny



-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org] 
Sent: Friday, October 20, 2006 6:10 PM
To: sbhuller@domain.hid
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_queue_read switch to secondary mode

On Fri, 2006-10-20 at 17:37 -0600, Sunny Bhuller wrote:
> Hi Philippe,
> 
>   I don't think the signal is occuring due to pthread_exit().  If you put
the rt_queue_read call in a loop you will see that the signal occurs on
every call to rt_queue_read.  
> 
> ...
> 	while (1)
>  	{
> 		rt_queue_read( msq_q, &data, sizeof ( some_data ),
TM_NONBLOCK);
> 		rt_task_sleep((RTIME) 100000);
> 	}
> ...

This code does not generate any mode switch here. Could you
display /proc/xenomai/stat once while the program runs?

Additionally, you may want to rebuild your user-space support by passing
--enable-debug to the configure script, so that we have better
backtraces.

Btw, what's your:
- platform?
- Adeos release?
- Xenomai version?

> 
>   The back trace produced the following output for me.
> 
> (gdb) r
> Starting program: /root/ipas/apps/skel/test
> [Thread debugging using libthread_db enabled]
> [New Thread -1211189568 (LWP 15101)]
> [New Thread -1208869968 (LWP 15104)]
> 
> Program received signal SIGXCPU, CPU time limit exceeded.
> [Switching to Thread -1208869968 (LWP 15104)]
> 0xffffe410 in ?? ()
> (gdb) bt
> #0  0xffffe410 in ?? ()
> #1  0xb7f20fe8 in ?? ()
> #2  0x00000400 in ?? ()
> #3  0xb7f21010 in ?? ()
> #4  0xb7ef2c72 in rt_queue_read () from /usr/xenomai/lib/libnative.so.0
> #5  0x08048852 in task_procedure (arg=0xbf93a640) at test.cpp:23
> #6  0xb7ef3141 in rt_task_trampoline () from
/usr/xenomai/lib/libnative.so.0
> #7  0xb7efb0fb in start_thread () from /lib/tls/libpthread.so.0
> #8  0xb7da399e in clone () from /lib/tls/libc.so.6
> (gdb)
> 
> 
>   Let me know if you see something wrong.
> -- Sunny
> 
> 
> 
> 
> 
> ----- Original Message -----
> From: Philippe Gerum <rpm@xenomai.org>
> Date: Friday, October 20, 2006 5:11 pm
> Subject: Re: [Xenomai-help] rt_queue_read switch to secondary mode
> 
> > On Fri, 2006-10-20 at 16:00 -0600, Sunny Bhuller wrote:
> > > Hi Philippe,
> > >   I am including some code below that will produce the problem I 
> > am seeing. 
> > > I must be missing something because if remove the force to 
> > primary mode in the
> > >  function task_procedure the signal will not be caught.  This 
> > tells me that
> > >  without the rt_task_set_mode the task is starting off in 
> > secondary mode.  
> > > 
> > 
> > The backtrace of your program is this one when SIGXCPU is caught:
> > 
> > (gdb) r
> > Starting program: /home/rpm/frags/secondary/main
> > [Thread debugging using libthread_db enabled]
> > [New Thread -1210504992 (LWP 18784)]
> > [New Thread -1209074768 (LWP 18787)]
> > 
> > Program received signal SIGXCPU, CPU time limit exceeded.
> > [Switching to Thread -1209074768 (zombie)]
> > 0xb7f02634 in calloc () from /lib/ld-linux.so.2
> > (gdb) bt
> > #0  0xb7f02634 in calloc () from /lib/ld-linux.so.2
> > #1  0xb7ef9110 in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
> > #2  0xb7ef8b01 in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
> > #3  0xb7e93200 in _dl_open () from /lib/tls/i686/cmov/libc.so.6
> > #4  0xb7efd43f in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
> > #5  0xb7e92c6f in _dl_open () from /lib/tls/i686/cmov/libc.so.6
> > #6  0xb7e9548d in __libc_dlsym () from /lib/tls/i686/cmov/libc.so.6
> > #7  0xb7efd43f in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
> > #8  0xb7e954ee in __libc_dlopen_mode ()
> > from /lib/tls/i686/cmov/libc.so.6
> > #9  0xb7ed7398 in pthread_cancel_init ()
> > from /lib/tls/i686/cmov/libpthread.so.0
> > #10 0xb7ed74c1 in _Unwind_ForcedUnwind ()
> > from /lib/tls/i686/cmov/libpthread.so.0
> > #11 0xb7ed51f1 in __pthread_unwind ()
> > from /lib/tls/i686/cmov/libpthread.so.0
> > #12 0xb7ed1210 in pthread_exit ()
> > from /lib/tls/i686/cmov/libpthread.so.0
> > #13 0xb7ec832a in rt_task_trampoline (cookie=0xbfcbb750)
> >    at /home/rpm/xenomai-2.2.4/src/skins/native/task.c:93
> > #14 0xb7ed0240 in start_thread ()
> > from /lib/tls/i686/cmov/libpthread.so.0
> > #15 0xb7e5e29e in clone () from /lib/tls/i686/cmov/libc.so.6
> > (gdb)
> > 
> > This means that the signal was sent as a result of performing a 
> > calloc()call, during the late binding of some dynamic library on 
> > behalf of
> > pthread_exit(), which gets called as your real-time task exits
> > immediately after the non-blocking call to rt_queue_read(). So 
> > this is
> > ok. The following patch should better illustrate the issue:
> > 
> > --- main.c~	2006-10-21 00:15:19.000000000 +0200
> > +++ main.c	2006-10-21 00:27:52.000000000 +0200
> > @@ -18,7 +18,7 @@
> >         some_data data;
> > 
> >         rt_queue_read( msq_q, &data, sizeof ( some_data ), 
> > TM_NONBLOCK);        
> > -        
> > +	rt_task_suspend(NULL);
> > }
> > 
> > void signal_handler(int sig)
> > 
> > PS: the call to rt_task_set_mode() in the main() function always 
> > fails,since the main routine is not a Xenomai-thread when started. 
> > Therefore,the call - which requires to be invoked by Xenomai 
> > threads - always
> > returns with -EPERM. Note: this behaviour may differ depending on the
> > skin bound to the application; for instance, the POSIX skin
> > automatically promotes the main code as a Xenomai-controlled 
> > thread, but
> > the native skin does not (maybe we should, though).
> > 
> > -- 
> > Philippe.
> > 
> > 
> > 
> 
-- 
Philippe.





