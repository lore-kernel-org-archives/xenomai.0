From: Julien Heyman <bidsonux@domain.hid>
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
Date: Sat, 22 Jul 2006 11:52:33 +0200
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<44BFFC73.9080603@domain.hid>
In-Reply-To: <44BFFC73.9080603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607221152.34298.bidsonux@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Thursday 20 July 2006 23:58, Jan Kiszka wrote:
> Julien Heyman wrote:
> > Hi,
> >
> > I am currently trying to evaluate Xenomai, and my current setup is :
> > VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
> > I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
>
> General advice: especially when starting new, try to pick the latest
> version, at least the latest from the preferred series (here 2.1.2). But
> 2.2 is even better. :)
>

OK. Actually started with Xenomai-2.1.0 then switched to 2.1.1 to fix a kernel 
build error. But anyway, I will start with a fresh install of 2.2 as soon as 
I have figured out the other points :)

> > When I run the latency part of the testsuite (in a console under KDE), I
> > get
> > results that I cannot understand, so I probably did something wrong
> > (execution trace included below).
> > I get reasonable values during the first seconds, then all of a sudden
> > latencies begin to rise, continuously, to very large values.
> > - I did check that DMA transfer is activated on my HD.
> > - I did select "Enable SMI workaround" + "Globally disable SMI" in the
> > Xenomai
> > options while configuring the kernel.
> > - I have disabled power management at BIOS level and disabled ACPI
> > support and
> > CPU frequency scaling during kernel configuration.
> > - I checked that I don't have anything called "legacy USB" in my BIOS. I
> > do have an "OnChip USB" option enable in the BIOS though.
> >
> > Any advice would be appreciated !
>
> Maybe it's related to some other weird on-chip hardware. At work we run
> Xenomai only on a head-less VIA C3 box, i.e. without X. No problems so
> far. I would suggest to try stopping X and run the test from the text mode.

This is interesting : indeed when I switch to console mode (Ctrl+Atl+F1) and 
run the test, the latency values stay right on track.
If I let the test run, switch to X, and switch back to the original console, 
the values have gone wild in the meantime.
So there seems to be a strong link with X. 
What does that say about potential causes of my issue ?

>
> A further tool to analyse such effects in details is the I-pipe tracer.
> It's an additional patch you have to apply to your kernel (see
> http://download.gna.org/adeos/patches/v2.6/i386/tracer). Enable this
> I-pipe option, rebuild your kernel, and start the latency test with -f.
> The test will then capture on every new worst-case delay a backtrace to
> /proc/ipipe/trace/frozen. You may want to play with the number of
> back-trace points or the verbose mode (see /proc/ipipe/trace/*) even
> after the capturing.
>

I had already used an adeos patch during my initial kernel-patching
(adeos-ipipe-2.6.17-i386-1.3-07.patch)
I tried running the latency test using /usr/xenomai/bin/xeno-load latency -f
but I get this error :

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

What am I doing wrong ?

Thanks,
Julien Heyman


> Unless you find something obvious immediately, feel free to post a
> backtrace that includes the problematic delay period before the freeze
> (compress when too large).
>
> Jan

