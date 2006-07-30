From: Julien Heyman <bidsonux@domain.hid>
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
Date: Sun, 30 Jul 2006 19:29:06 +0200
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607282317.34990.bidsonux@domain.hid>
	<17610.33363.809376.253641@domain.hid>
In-Reply-To: <17610.33363.809376.253641@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301929.08176.bidsonux@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Friday 28 July 2006 23:32, Gilles Chanteperdrix wrote:
> Julien Heyman wrote:
>  > > Losing too many ticks!
>  > > TSC cannot be used as a timesource. ~
>  > > Possible reasons for this are:
>  > > ~ You're running with Speedstep,
>  > > ~ You don't have DMA enabled for your hard disk (see hdparm),
>  > > ~ Incorrect TSC synchronization on an SMP system (see dmesg).
>  > > Falling back to a sane timesource now.
>  > >
>  > > Do you see such message in kernel logs ?
>  >
>  > No, I don't get any of these.
>  >
>  > > If this is the issue you are having, then you may try passing
>  > > idle=poll on kernel boot line. Or recompile the kernel selecting a
>  > > processor that has no tsc (for example 486), xenomai will then use the
>  > > 8254 counter to emulate the tsc.
>  >
>  > I tried to rebuild with CPU=486, but it gives the same result.
>
> Did you try booting with the idle=poll option ? Also, could you try
> re-enabling ACPI, except the "processor" module ?

I tried both, without success.
My quest goes on... :/

By the way, there is something I don't understand : I get the following error 
message at boot time :
Incompatible timer mode found (aperiodic, need periodic)
VxWorks skin init failed, code -16

whereas I do have periodic timer enabled, I think :

bids@domain.hid$ cat .config | grep PERIO
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=0

(or am I checking the wrong setting ? Also, it "0" a legitimate value for the 
timing period ?)

Julien Heyman




