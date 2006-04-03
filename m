Message-ID: <2cf1ee820604022235q28acf8cfh756a46cdc7e3f46c@domain.hid>
Date: Mon, 3 Apr 2006 08:35:12 +0300
From: "emin ak" <eminak71@domain.hid>
Subject: Re: [Xenomai-help] Kernel Panic at boot 2.6.15
In-Reply-To: <6ee4c8380604021056q15faf58udc083b8bb13dcb50@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ee4c8380604021056q15faf58udc083b8bb13dcb50@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Brian L." <bluczkie@domain.hid>
Cc: xenomai@xenomai.org

I had this problem before, disabling power management (APIC ) on
kernel configuration solved the problem (but I dont know why?),Maybe a
previous topic named 'Crashing at boot with 2.6.15.4' was related with
this problem that fixed in the newest version, you can have a look at
it.
emin
2006/4/2, Brian L. <bluczkie@domain.hid>:
> I just patched 2.6.15 using the prepare-kernel script and adeos patch
> included in xenomai 2.1.0. I configured the kernel in a sensible way
> for the hardware, but didn't touch anything in the real-time section.
>
> When I boot the kernel, I get a kernel panic. Here's some important
> bits (everything above this is cut off and obviously, unscrollable):
>
> Pricess swapper (pid: 1, threadinfo=3Dc12900000, task=3Dc1283a30)
> Stack: ...
> Call Trace:
> [<c025f5f0>] rthalbroadcast_to_local_timers+0x0/0x30
> [<c0143cf8>] xnpod_get_time+0x8/0x20
> [<c0143c84>] xnpod_set_time+0x44/0xb0
> [<c0144275>] xnpod_start_timer+0x1a5/0x260
> [<c01443d0>] xnpod_announce_tick+0x0/0x100
> [<c01443d0>] xnpod_announce_tick+0x0/0x100
> [<c0140d3a>] xnpod_init+0x46a/0x510
> [<c01443d0>] xnpod_announce_tick+0x0/0x100
> [<c0118500>] __ipipe_flush_printk+0x80/0xa0
> [<c0148bea>] xncore_attach+0x4a/0x60
> [<c014bc9c>] __native_skin_init+0xc/0xf0
> [<c036e8ec>] do_initcalls+0x2c/0xd0
> [<c01002d0>] init+0x0/0x170
> [<c010030c>] init+0x3c/0x170
> [<c01010e9>] kernel_thread_helper+0x5/0xc
> Code: ...
> <0>Kernel panic - not syncing: Attempted to kill init!
>
> ------
>
> The hardware is a UP 440bx with a celeron 566 coppermine.
> CPU/memory/mainboard have been ruled out as failure points. Kernel is
> configured as celeron/coppermine and xenomai as i686.
>
> I trudged through the archives a bit and it seems that this problem is
> somewhat tragically unique. Any xenomai-kernel-internals hackers want
> to give this a go? Is there anywhere I should look first? I'm an
> rtlinux refugee, so my knowledge of adeos/rtai internals is limited.
>
> Thanks,
> Brian
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

