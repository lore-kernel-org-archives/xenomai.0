From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1254490485.2703.306.camel@domain.hid>
References: <4AC5E895.8010107@domain.hid> <4AC5F49E.3070608@domain.hid>
	<4AC5FEAD.7000608@domain.hid>  <1254490485.2703.306.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 15:36:38 +0200
Message-Id: <1254490598.2703.307.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-10-02 at 15:34 +0200, Philippe Gerum wrote:
> On Fri, 2009-10-02 at 15:22 +0200, Roman Pisl wrote:
> > On 2.10.2009 14:39, Gilles Chanteperdrix wrote:
> > > Roman Pisl wrote:
> > >> Hello,
> > >> I just tried x86-64 SMP Linux/Xenomai on my workstation (Intel Core2
> > >> Quad) but it freezes immediately after latency test or clocktest is
> > >> started. It freezes even during the boot, when Xenomai debbuging is
> > >> enabled.
> > >>
> > >> The same kernel binary runs seamlessly in KVM on the same machine.
> > >>
> > >> When I completely disable ACPI, the kernel recognizes only one CPU and
> > >> the latency test works.
> > >>
> > >> The same configuration but for 32bit x86 also runs without freeze.
> > >>
> > >> Do you have any ideas?
> > >
> > > Yes. As we repeated many times.
> > > Tell us the versions of Xenomai and of the I-pipe patch you use.
> > > Send us your .config
> > > Manage to get the kernel console output (using a serial cable connected
> > > to another PC, or the netconsole, some people even used to send us
> > > photos about kernel crashes).
> > >
> > 
> > I send dmesg output for both 32 and 64 bit. Unfortunately it just 
> > freezes with no kernel panic output. When Xenomai debugging is enabled, 
> > the kernel freezes after Xenomai is initialized (last message: Xenomai: 
> > starting RTDM services).
> 
> To dig this issue further, try disabling all Xenomai skins
> (CONFIG_XENO_SKIN_NATIVE, _RTDM, _POSIX), only keeping the real-time
> nucleus in. The klog should say after reboot:
> 
> [    2.371256] Xenomai: hal/x86_64 started.
> [    2.371363] Xenomai: scheduling class idle registered.
> [    2.371454] Xenomai: scheduling class rt registered.
> [    2.373676] Xenomai: real-time nucleus v2.5-rc3 (Flying In A Blue
> Dream) loaded.
> 
> without any further Xenomai message.
> 
> If that still does not work, try disabling CONFIG_XENOMAI entirely, only
> keeping the interrupt pipeline active. This way we may better understand
> which software stack is causing issue.

Forget about this, I misread your message.

> 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



