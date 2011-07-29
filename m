From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <509DA52866E38F47878413CF102D751FD42077949E@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FD42077949E@poseidon.nexus-ag.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jul 2011 10:26:54 +0200
Message-ID: <1311928014.3656.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai VxWorks Skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Cc: Antonio Gambin <antonio.gambin@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, 2011-07-29 at 09:56 +0200, Sambasiva Rao Manchili wrote:
> Hallo  Xenomai Experts,
> We used Xenomai to quickly port our VxWorks code to Linux. Changes
> that we need to do for successful compilation and linking were minimal
> because of Xenomai.Most of our tasks spawned are running with help of
> Xenomai on Linux 2.6.37. 
>  

Which CPU architecture?

> Once we had problem of task being crashed(Thread Segfault) with one of
> our tasks spawned by a process and after two weeks of debugging and
> re-verifying every thing found that "stacksize parameter" in the
>  taskSpawn  function that was normally running in VxWorks was not
> enough in the Xenomai Linux environment.  After increasint the stack
> size segmentation fault of taskSpawn was solved.
>  
> Now again I see SIGABORT in another task. I increase the stack size
> from 32k to 8MB but still crashes.

That is not a good idea anyway. Since your app data segment must be
locked in RAM to run in the Xenomai context, you are basically throwing
away 8Mb of RAM space minus a few tenths of Kb, which nobody will ever
use. Check mlockall().

>  I am thinking now here in this case increasing stacksize value is not
> right.  Do you have any hints for such problem 

Do you have any message along with SIGABRT on your console? It is
commonly raised by glibc/malloc when something goes wrong. In any case,
you should run your app over gdb, and ask for a backtrace when that
signal is caught, to spot the faulty code.

If using gdb live is not an option for whatever reason, then let the
kernel trigger a core dump (running "ulimit -s <hugevalue>" once for the
startup shell may be required before launching the app to enable such
dump), then ask gdb for a post-mortem analysis of this core image.

e.g. gdb /path/to/app /path/to/core

then again, from gdb just run "bt" to get a backtrace. Hopefully that
backtrace won't be trashed as it might happen with SIGABRT on some
platforms unfortunately.

>  
> Thanks in advance.
> Samba.
>  
>  
>  
> (gdb) where
> #0  0xffffe424 in __kernel_vsyscall ()
> #1  0x4b0a1df0 in raise () from /lib/libc.so.6
> #2  0x4b0a3701 in abort () from /lib/libc.so.6
> #3  0x4b0da3ab in __libc_message () from /lib/libc.so.6
> #4  0x4b0e33fd in _int_malloc () from /lib/libc.so.6
> #5  0x4b0e4cca in calloc () from /lib/libc.so.6
> #6  0x4b06af0a in _dl_allocate_tls () from /lib/ld-linux.so.2
> #7  0x4b1e0f5d in pthread_create@domain.hid ()
> from /lib/libpthread.so.0
> #8  0xb79ae4d2 in __real_pthread_create ()
> from /usr/xenomai/lib/libvxworks.so.1
> #9  0xb79ad338 in taskInit () from /usr/xenomai/lib/libvxworks.so.1
> #10 0xb79ad49e in taskSpawn () from /usr/xenomai/lib/libvxworks.so.1
> #11 0xb7ff3ccb in create_forth_task (entry=0xb4902098, priority=143,
> special_stack_size=0) at tesarm.c:1774
> #12 0xb7ff58d7 in load_interpreter (toffset=1, filetab_index=0 '\000',
> single=0 '\000') at tesarm.c:851
> #13 0xb7ff5bdf in reply_from_file_loader (msg_ptr=0xb44fcf14) at
> tesarm.c:1400
> #14 0xb7ff3465 in handle_ta_request () at tesataLnx.c:126
> #15 test_admin_task () at tesataLnx.c:400
> #16 0xb79accbe in wind_task_trampoline ()
> from /usr/xenomai/lib/libvxworks.so.1
> #17 0x4b1e0832 in start_thread () from /lib/libpthread.so.0
> #18 0x4b14b45e in clone () from /lib/libc.so.6
> 
>  
> Sambasiva Rao Manchili
> Software Development Engineer 
> ________________________________
>  
> NEXUS TELECOM AG 
> Network and Service Investigation
> 
> Feldbachstrasse 80
> 8634 Hombrechtikon
> Switzerland
> 
> Direct/mobile: +41 78 750 6808
> Main: +41 44 355 6611
> Email: sambasiva.manchili@domain.hid
> Website: www.nexustelecom.com
> 
>  
>  
> 
> 
> ______________________________________________________________________
> This email and any attachment may contain confidential information
> which is intended for use only by the addressee(s) named above. If you
> received this email by mistake, please notify the sender immediately,
> and delete the email from your system. You are prohibited from
> copying, disseminating or otherwise using the email or any attachment.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



