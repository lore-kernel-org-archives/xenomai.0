Date: Fri, 14 Aug 2009 11:05:40 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] T_WARNSW ignored?
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm trying to detect some remaining unwanted mode switches in an
application using the native Xenomai app. In one task (that is meant to
stay in RT domain all the time) I set the T_WARNSW bit and run the
program via gdb, but - although /proc/xenomai/stat shows some 1000 MSW
per second for that task - no SIGXCPU ever occurs. Only after I interrupt
it in the terminal where gdbserver was started, the gdb client shows
SIGINT, and after "cont", SIGXPCU.

I also tried the examples/native/sigxcpu.c with the same compiler flags.
There, SIGXCPU occurs and is reported by GDB immediately. What may cause
this, did I miss something?

It's on Blackfin, uclinux-dist 2009R1-RC2, Xenomai 2.4.7, Kernel 2.6.28.10 with
adeos-ipipe-2.6.28.10-blackfin.git-1.10-00.patch.

This is how it looks when the program is interrupted after some time:

Program received signal SIGINT, Interrupt.
[Switching to Thread 270]
0x00710042 in rt_sem_p (sem=0xf69028, timeout=81067177008952732) at
../../../../xenomai-2.4.7/src/skins/native/sem.c:43
43		return XENOMAI_SKINCALL2(__native_muxid, __native_sem_p,
sem, &timeout);
Current language:  auto; currently c
(gdb) cont
Continuing.

Program received signal SIGXCPU, CPU time limit exceeded.
[Switching to Thread 273]
0x0070fc20 in rt_dev_ioctl (fd=0, request=4) at
../../../../xenomai-2.4.7/src/skins/rtdm/core.c:60
60		return XENOMAI_SKINCALL3(__rtdm_muxid,
(gdb)

Kolja


