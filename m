Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200607301929.08176.bidsonux@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607282317.34990.bidsonux@domain.hid>
	<17610.33363.809376.253641@domain.hid>
	<200607301929.08176.bidsonux@domain.hid>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 19:49:07 +0200
Message-Id: <1154281747.4970.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Heyman <bidsonux@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sun, 2006-07-30 at 19:29 +0200, Julien Heyman wrote:
> On Friday 28 July 2006 23:32, Gilles Chanteperdrix wrote:
> > Julien Heyman wrote:
> >  > > Losing too many ticks!
> >  > > TSC cannot be used as a timesource. ~
> >  > > Possible reasons for this are:
> >  > > ~ You're running with Speedstep,
> >  > > ~ You don't have DMA enabled for your hard disk (see hdparm),
> >  > > ~ Incorrect TSC synchronization on an SMP system (see dmesg).
> >  > > Falling back to a sane timesource now.
> >  > >
> >  > > Do you see such message in kernel logs ?
> >  >
> >  > No, I don't get any of these.
> >  >
> >  > > If this is the issue you are having, then you may try passing
> >  > > idle=poll on kernel boot line. Or recompile the kernel selecting a
> >  > > processor that has no tsc (for example 486), xenomai will then use the
> >  > > 8254 counter to emulate the tsc.
> >  >
> >  > I tried to rebuild with CPU=486, but it gives the same result.
> >
> > Did you try booting with the idle=poll option ? Also, could you try
> > re-enabling ACPI, except the "processor" module ?
> 
> I tried both, without success.
> My quest goes on... :/
> 
> By the way, there is something I don't understand : I get the following error 
> message at boot time :
> Incompatible timer mode found (aperiodic, need periodic)
> VxWorks skin init failed, code -16
> 

It's because the VxWorks skin requires periodic timing whilst the
native/POSIX ones require aperiodic setup. This error is raised whenever
multiple skins with conflicting timing requirements are built statically
into the kernel. The best way to handle this is to enable skins as
modules.

> whereas I do have periodic timer enabled, I think :

> bids@domain.hid$ cat .config | grep PERIO
> CONFIG_XENO_OPT_TIMING_PERIODIC=y
> CONFIG_XENO_OPT_TIMING_PERIOD=0
> 
> (or am I checking the wrong setting ? Also, it "0" a legitimate value for the
>  
> timing period ?)

Yes. The skins requiring periodic timing will substitute their own
default values.

> 
> Julien Heyman
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



