Date: Tue, 25 Jan 2011 10:50:34 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E97D5.3050609@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251049460.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Some Xenomai code is executed before the main function is called. What I
> do not understand is why gdb does not stop at the place of the segfault?

One step further.  After issuing "sharedlibrary" the syms are read. The backtrace then is

#0  0x01666f10 in pthread_sighandler_rt (signo=28, si=0x13bd374, uc=0x13bd3f4)
     at libpthread/linuxthreads.old/signals.c:127
#1  <signal handler called>
#2  0x0160cf1e in __syscall_rt_sigaction (signum=<value optimized out>, act=0x13bd580, oldact=0x13bd4f4, size=8)
     at libc/sysdeps/linux/common/__syscall_rt_sigaction.c:17
#3  0x0162f482 in __libc_sigaction (sig=28, act=0x13bd638, oact=0xb8995c) at libc/signal/sigaction.c:58
#4  0x01666fba in *___GI_sigaction (sig=28, act=0x13bd6e8, oact=0xb8995c) at libpthread/linuxthreads.old/signals.c:163
#5  0x00b71c9a in xeno_sigshadow_install () at ../../../../xenomai-2.5.5.2/src/skins/common/sigshadow.c:70
#6  0x01665f66 in __pthread_once (once_control=0xb89958, init_routine=@0x1545bc4: 0xb71c64 <xeno_sigshadow_install>)
     at libpthread/linuxthreads.old/mutex.c:315
#7  0x016c4132 in __wrap_pthread_setschedparam (thread=1024, policy=0, param=0x13bf9c8)
     at ../../../../xenomai-2.5.5.2/src/skins/posix/thread.c:71
#8  0x016c376a in __init_posix_interface () at ../../../../xenomai-2.5.5.2/src/skins/posix/init.c:90
#9  0x016c8234 in __do_global_ctors_aux ()
    from /opt/uClinux-2010R1-RC5_tools-RC4/blackfin-linux-dist/staging/usr/lib/libpthread_rt.so.1
#10 0x016c2cb6 in _init () from /opt/uClinux-2010R1-RC5_tools-RC4/blackfin-linux-dist/staging/usr/lib/libpthread_rt.so.1
#11 0x019c41b6 in _dl_get_ready_to_run (tpnt=0xb8836c, load_addr=<value optimized out>, auxvt=0x13bfda0, envp=0x13bfe6c,
     argv=0x13bfe64, dl_boot_progmap=0x13bff40, dl_boot_got_pointer=21056480) at ldso/ldso/ldso.c:836
#12 0x019c44a4 in ?? ()
    from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/ld-uClibc.so.0
#13 0x019c0cb0 in _dl_boot () at ./ldso/ldso/bfin/dl-inlines.h:31
Cannot access memory at address 0x16ffc78


Kolja

