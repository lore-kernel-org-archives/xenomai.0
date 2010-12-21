Date: Tue, 21 Dec 2010 18:30:34 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

Hi,

thanks for the quick response regarding the irritating warning.

My next problem appears while debugging an application on a Blackfin target
with gdbserver + gdb. Debugging hangs when the first rt_task_create is reached.

Starting in my application:

153     int prio = T_HIPRIO/2;
154     int r = rt_task_create(&thread, thread_name.c_str(), 128*1024, prio, T_FPU|T_JOINABLE);

...

Single-stepi'ing the call, gdb loses contact shortly after clone() in
http://git.uclibc.org/uClibc/tree/libpthread/linuxthreads.old/pthread.c
It looks like this could be related to a manager thread?

These are the last lines from gdb (using stepi)

45  in libc/sysdeps/linux/bfin/clone.c
0x00e4cb00 in clone (fn=@0xec235c: 0xed5a64 <__pthread_manager_event>, child_stack=0xefb5cc, flags=3840, arg=0x0)
     at libc/sysdeps/linux/bfin/clone.c:45
45  in libc/sysdeps/linux/bfin/clone.c
0x00ed8734 in __pthread_initialize_manager () at libpthread/linuxthreads.old/pthread.c:600
600 libpthread/linuxthreads.old/pthread.c: No such file or directory.
     in libpthread/linuxthreads.old/pthread.c
606 in libpthread/linuxthreads.old/pthread.c
0x00ed8738  606 in libpthread/linuxthreads.old/pthread.c
615 in libpthread/linuxthreads.old/pthread.c
614 in libpthread/linuxthreads.old/pthread.c
0x00ed8740  614 in libpthread/linuxthreads.old/pthread.c
616 in libpthread/linuxthreads.old/pthread.c
612 in libpthread/linuxthreads.old/pthread.c
615 in libpthread/linuxthreads.old/pthread.c
616 in libpthread/linuxthreads.old/pthread.c
617 in libpthread/linuxthreads.old/pthread.c
620 in libpthread/linuxthreads.old/pthread.c
0x00ed8754  620 in libpthread/linuxthreads.old/pthread.c
0x00ed4066 in ?? ()
    from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/libpthread.so.0
0x00ed406a in ?? ()
    from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/libpthread.so.0
0x00ed406e in ?? ()
    from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/libpthread.so.0



I need to find out how to prepare the uClibc source so that gdb can find it for further details. But maybe someone yet has an idea about a possible cause (and remedy)?

Kolja





