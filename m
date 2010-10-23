Message-ID: <4CC35937.8060001@domain.hid>
Date: Sat, 23 Oct 2010 23:52:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1287845650.32319352@domain.hid>
	<4CC30152.6060208@domain.hid>	<1287850862.74211776@domain.hid>
	<1287851184.14497074@domain.hid>
	<1287859578.113425004@domain.hid>
In-Reply-To: <1287859578.113425004@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> But no cigar...
> 
> Latency at 4491us, trace attached
> 
> I've supposedly got SMI disabled, MTRRs are disabled, ACPI processor
> disabled, CPU frequency scaling disabled, MSI and MSI-X disabled. I
> can't disable USB legacy in the BIOS because the option is grayed out
> (and no other options seem to make it work. I'm running through the
> troubleshooting file to see if there's anything else I can try but I
> can't see anything.
> 
> The BIOS has a ridiculous number of options, I have gone through and
> disabled most of them even though in many cases I'm really not sure
> what it is that they do - I just hope they don't cause anything to
> melt:
> 
> CRID, disabled memory thermal management, turned off lots of ACPI and

Pay attention not to disable ACPI completely, as this enables APM, the
legacy power management, and this one causes high latencies.

> power options - C2, C3, S4 wakeup from RTC, Trusted Execution


> Technology, P-States, Thermal Mode, C-States, C-State Pop Up Mode,
> C-State Pop Down Mode, DeepC4, Hard C4E, C6 Enhanced Multi Threaded
> Thermal Monitoring (EMTTM), Bi-directional PROCHOT, Dynamic FSB
> Switching, Turbo Mode, ACPI 3.0 T-States, CPU Digital Thermal Sensor,
> PCI Clock Run, Storage Break Event, PCIE Break Event, PCI Break
> Event, EHCI Break Event, UHCI Break Event, HDA Break Event, ACPI S3,
> wake on PME and set "ACPI Selection" from Acpi3.0 to Acpi1.0B in the
> hope it will be better supported.
> 
> I'm at a bit of a loss. Next I will try to figure out how to read the
> traces. The latency consistently jumps from <20us (normally around
> 14/15) to just under 4500us each time I run the test, so I am
> wondering if it is some specific thing that takes this long. I will
> also try to read the LTP output to see what it's doing when it fails,
> and see if this is consistent.
> 
> Gilles, I really appreciate all the help, thank you.

You are welcome, no problem. A few things to try: could you try and use
the latest I-pipe for 2.6.35? Just to rule out anything which would have
been fixed since 2.6.32.

Something else, did you try to run your system completely without
framebuffer and X-window? In good old text mode?

I do not know what more to suggest. The traces you sent show
consistently ipipe_check_context at the point where you have the issue,
I do not know whether this is a coincidence. Do you get any I-pipe
message in the kernel logs after the latency peak happens?

-- 
                                                                Gilles.

