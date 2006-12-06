From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Crash using userspace interrupts
Date: Wed, 6 Dec 2006 12:02:52 +0100
References: <200612051557.44787.s.zimmermann@domain.hid>
	<45758AF3.6010907@domain.hid>
In-Reply-To: <45758AF3.6010907@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061202.52456.s.zimmermann@domain.hid>
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

Am Dienstag, 5. Dezember 2006 16:06 schrieb Jan Kiszka:
> Stephan Zimmermann wrote:
> > Hello List,
> > I am facing a crashing kernel when I use some rt_interupt_xxx funtions in
> > my application.
> >
> > System: Dualcore AMD with Debian 3.1, kernel 2.7.17.14 with Xenomai SVN
> > rev 1920.
> >
> > Kernel crashes, leaving the following last words in syslog, the system
> > keeps responding, but I am unable to restart my application.
> >
> > <syslog>
> > I-pipe: Domain Xenomai registered.
> > Dec  5 15:24:07 localhost kernel: Xenomai: hal/x86 started.
> > Dec  5 15:24:07 localhost kernel: Xenomai: real-time nucleus v2.3-rc1
> > (Baroque) loaded.
>
> #1920 implies -rc2. Something is probably inconsistent in your build.

Well you where right, my build was broken somehow. I reinstalled 
everything (Kernel, Xenomai) from clean sources, leading to a build 
which claims to be rc2. Nevertheless my system crashes, giving 
the same errormessages in syslog. 
Things change if I run the same program on a single-cpu machine 
or compile my kernel without SMP support, then everything seems to work fine.

Thanks again, Stephan

<syslog>
I-pipe: Domain Xenomai registered.
Dec  6 11:38:08 localhost kernel: Xenomai: hal/x86 started.
Dec  6 11:38:08 localhost kernel: Xenomai: real-time nucleus v2.3-rc2 (Baroque) loaded.
Dec  6 11:38:08 localhost kernel: Xenomai: starting native API services.
Dec  6 11:39:13 localhost kernel:        waiter = kernel/xenomai/nucleus/intr.c:627 (xnintr_attach(), CPU #1)
Dec  6 11:39:13 localhost kernel:        owner  = <NULL>:0 (<NULL>(), CPU #0)
Dec  6 11:39:13 localhost kernel:        d8e31e88 c02d426e c02dfcdd f96a3385 00000000 00000000 00000000 00000000
Dec  6 11:39:13 localhost kernel:        00000000 c03bf080 db303124 00000000 f966af7b db30312c db303120 00000000
Dec  6 11:39:13 localhost kernel:        00000001 00000000 00000001 00000000 00000000 00000000 db303120 00000007
Dec  6 11:39:13 localhost kernel: Call Trace:
Dec  6 11:39:13 localhost kernel:  <f96a3385> xnintr_attach+0xd1/0x287 [xeno_nucleus]  <f966af7b> rt_intr_create+0x941/0x988 [xeno_native]
Dec  6 11:39:13 localhost kernel:  <f965efba> __rt_intr_create+0xaf/0xf6 [xeno_native]  <f965eec5> rt_intr_handler+0x0/0x46 [xeno_native]
Dec  6 11:39:13 localhost kernel:  <f9664227> rt_mutex_release+0x323/0x32f [xeno_native]  <f96c87b3> hisyscall_event+0x13e/0x251 [xeno_nucleus]
Dec  6 11:39:13 localhost kernel:  <f96c8675> hisyscall_event+0x0/0x251 [xeno_nucleus]  <c0135c55> __ipipe_dispatch_event+0xd6/0x1dc
Dec  6 11:39:13 localhost kernel:  <c011075a> __ipipe_syscall_root+0x9e/0x147  <c0102ad6> sysenter_past_esp+0x3b/0x67
Dec  6 11:39:13 localhost kernel: Xenomai: watchdog triggered -- killing runaway thread 'CAN-ISR-2'
</syslog>

