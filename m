Date: Tue, 28 Dec 2010 19:21:35 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D1A135E.7060005@domain.hid>
Message-ID: <alpine.DEB.1.10.1012281853500.23472@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<4D1A135E.7060005@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait
Reply-To: Kolja Waschk <xenoka09@domain.hid>
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
Cc: Xenomai GNA <xenomai@xenomai.org>

Hi,

> posix-cond-torture test case to verify that what was supposed to be

When run standalone, it seems to pass; the output is

mple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
Test OK

When started via gdbserver, I get a NULL pointer access immediately after gdb
attaches to the target. I cannot say if that's related or if it just proves
some kind of inconsistency in my setup. Maybe the trace can shed some light on
it. I again tried to keep my posting compact by not quoting the full exception
context but if you think I missed some important info, I have the full log
still available

...
  RETS: <0x016f6eda> [ /lib/libpthread.so.0 + 0x6eda ]
  PC  : <0x016f6f10> [ /lib/libpthread.so.0 + 0x6f10 ]
DCPLB_FAULT_ADDR: <0x00000000> /* Maybe null pointer? */
ICPLB_FAULT_ADDR: <0x016f6f10> [ /lib/libpthread.so.0 + 0x6f10 ]
> libpthread/linuxthreads.old/signals.c:127
...
       FAULT : <0x016f6f10> [ /lib/libpthread.so.0 + 0x6f10 ] P1 = [P3]
      Source : <0x016f6f0e> [ /lib/libpthread.so.0 + 0x6f0e ] P3 = [P2]
    5 Target : <0x016f6eee> [ /lib/libpthread.so.0 + 0x6eee ]
      Source : <0x016f6ee2> [ /lib/libpthread.so.0 + 0x6ee2 ] IF CC JUMP pcrel (BP)
    6 Target : <0x016f6eda> [ /lib/libpthread.so.0 + 0x6eda ]
      Source : <0x016f6e64> [ /lib/libpthread.so.0 + 0x6e64 ] RTS
    7 Target : <0x016f6e60> [ /lib/libpthread.so.0 + 0x6e60 ]
      Source : <0x016f6e3c> [ /lib/libpthread.so.0 + 0x6e3c ] JUMP.S
    8 Target : <0x016f6e18> [ /lib/libpthread.so.0 + 0x6e18 ]
      Source : <0x016f6ed6> [ /lib/libpthread.so.0 + 0x6ed6 ] CALL pcrel
    9 Target : <0x016f6ec8> [ /lib/libpthread.so.0 + 0x6ec8 ]
      Source : <0xffa00d12> { __common_int_entry + 0xce } RTI
   10 Target : <0xffa00cb0> { __common_int_entry + 0x6c }
      Source : <0xffa00f80> { _evt_system_call + 0x64 } JUMP.S
   11 Target : <0xffa00f80> { _evt_system_call + 0x64 }
      Source : <0xffa00982> { _system_call + 0xee } RTS
   12 Target : <0xffa0097c> { _system_call + 0xe8 }
      Source : <0x000031fe> { _do_notify_resume + 0x52 } RTS
   13 Target : <0x000031fa> { _do_notify_resume + 0x4e }
      Source : <0x000031dc> { _do_notify_resume + 0x30 } IF CC JUMP pcrel (BP)
   14 Target : <0x000031ce> { _do_notify_resume + 0x22 }
      Source : <0x000031aa> { _do_signal + 0x126 } RTS
   15 Target : <0x000031a0> { _do_signal + 0x11c }
      Source : <0x00003118> { _do_signal + 0x94 } IF CC JUMP pcrel (BP)
...
Return addresses in stack:
     address : <0x016f5f66> [ /lib/libpthread.so.0 + 0x5f66 ]
> libpthread/linuxthreads.old/mutex.c:316

For reference again the OS info, it's blackfin-linux-dist 2010R1-RC5 which, as
far as the lib names tell, uses linuxthreads.old of uClibc-0.9.29. I-Pipe is
updated to 1.15-01 in dist's kernel 2.6.34 and Xenomai was updated to 2.5.5.2.

Originally, I-Pipe 1.14-02 comes with the dist and Xenomai 2.5.3. I updated them because the
latter always showed an "kernel is anterior to 2.5.2" warning at startup and
2.5.5.2 looked like it would change something in that regard on NOMMU, and in
order to have at least Xenomai at a version that might be worth examining.

Thanks for looking at this issue
Kolja


