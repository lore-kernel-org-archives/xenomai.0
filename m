Date: Tue, 25 Jan 2011 12:22:41 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E9D71.7040008@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251215520.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
	<alpine.DEB.1.10.1101251049460.12329@domain.hid>
	<4D3E9D71.7040008@domain.hid>
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

Hi,

> If not, recompile xenomai with --enable-debug, try and put a breakpoint
> on the function xeno_sigshadow_handler.  If you hit the breakpoint, try
> and execute the function step by step, looking whether a pointer could

The breakpoint isn't hit...

With following setup:

# continue to "_dl_get_ready_to_run" to be able to load symbols
break *($pc - 0xC60 + 0x41B6)
cont

sharedlibrary
break xeno_sigshadow_handler
break main

... the output is as quoted below. Should xeno_sigshadow_handler be called as an
immediate result of xeno_sigshadow_install? If I break on xeno_sigshadow_install,
the fault doesn't occur and execution continues without problems to main()...

Breakpoint 1, 0x017ac1b6 in ?? ()
Breakpoint 2 at 0x1745d58: file ../../../../xenomai-2.5.5.2/src/skins/common/sigshadow.c, line 41.
Breakpoint 3 at 0x161f646: file a.c, line 3.
(gdb) cont
Continuing.
[New Thread 329]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 329]
0x01796f10 in pthread_sighandler_rt (signo=28, si=0x177d3ac, uc=0x177d42c) at libpthread/linuxthreads.old/signals.c:127
127	libpthread/linuxthreads.old/signals.c: No such file or directory.
 	in libpthread/linuxthreads.old/signals.c
(gdb) bt
#0  0x01796f10 in pthread_sighandler_rt (signo=28, si=0x177d3ac, uc=0x177d42c)
     at libpthread/linuxthreads.old/signals.c:127
#1  <signal handler called>
#2  0x017ccf1e in __syscall_rt_sigaction (signum=<value optimized out>, act=0x177d5b8, oldact=0x177d52c, size=8)
     at libc/sysdeps/linux/common/__syscall_rt_sigaction.c:17
#3  0x017ef482 in __libc_sigaction (sig=28, act=0x177d670, oact=0x159a95c) at libc/signal/sigaction.c:58
#4  0x01796fba in *___GI_sigaction (sig=28, act=0x177d720, oact=0x159a95c) at libpthread/linuxthreads.old/signals.c:163
#5  0x01745c9a in xeno_sigshadow_install () at ../../../../xenomai-2.5.5.2/src/skins/common/sigshadow.c:70
.... as before

Kolja


