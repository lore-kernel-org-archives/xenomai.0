Message-ID: <43FF1F62.4070102@domain.hid>
Date: Fri, 24 Feb 2006 15:59:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems solved
References: <C0244E4B.24F4%steve@domain.hid>
In-Reply-To: <C0244E4B.24F4%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
>>Again, the only way to make your point here would be to run the latency test
>>in 
>>user-space, disabling the periodic timing at configuration level (v2.1 only),
>>and 
>>making sure that no SMI source is active. If the results actually show
>>performance 
>>degradation on this board between v2.0 (which is based on the latest fusion
>>code) 
>>and v2.1-rc3, then your conclusion would have more weight.
>>
> 
> 
> Didn't we already figure out that my geode board won't run the latency tests
> because it doesn't support aperiodic mode?

No, we didn't. Geode is no different than any other x86 platform Xenomai-wise, and 
it does obviously support the aperiodic mode; actually all platforms Xenomai 
currently runs on do support aperiodic mode, which is the fundamental one, only 
the periodic mode is optional. When CONFIG_X86_UP_APIC is off, this mode is 
obtained by programming the 8254 PIT in a different way than it is done for the 
periodic one, but it's exactely the same hardware involved; the rest is purely 
software-based. Incidentally, I'm running an MDB acquisition system on a Geode 
266Mhz board, right now, on my desk, just in front of me, so unless I'm badly 
hallucinating, your board should work too.

The key is to go back to a sane setup: first a properly configured kernel for this 
kind of board (no SMI, no APIC, no PM, USB host-side driver enabled), 2.6.14 or 
2.6.15 with -ipipe 1.2-00 or later would do. Then, proper Xenomai configuration: 
basically the default one + SMI detection enabled; during performance measurement, 
you should also leave the nucleus watchdog off unless you really need this for 
debugging. Unless you have a lot more than a handful of threads that actually 
compete for the CPU (i.e. they might be in a runnable state, concurrently, and 
most of the time), the O(1) scheduler is clearly overkill and uselessly increases 
the memory footprint without buying you anything compared to the linear one. It's 
mainly intended for applications that might need a large number of actually 
concurrent threads.

  I get garbage data from the
> latency teests.

This garbage is expected: the latency test _must_ work in aperiodic timing mode; 
what you've been seeing is the effect of jitter accumulation, tick after tick, 
since the periodic mode does not allow to follow a precise timeline by adapting 
the delay between ticks and thus compensate for the past jittery.

  When I tried to disable periodic mode in configuration I get
> an ENODEV on module insert.
> 

Make sure that CONFIG_XENO_OPT_TIMING_PERIODIC is off and 
CONFIG_XENO_OPT_TIMING_PERIOD is 0. The former should imply the latter, but this 
is not the case yet; will fix.

> Steven
> 


-- 

Philippe.

