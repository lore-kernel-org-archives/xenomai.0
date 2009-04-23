Date: Wed, 22 Apr 2009 18:43:20 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49EF5149.9090609@domain.hid>
Message-ID: <Pine.LNX.4.64.0904221805420.16285@domain.hid>
References: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
	<49ECBEE6.2060201@domain.hid>
	<Pine.LNX.4.64.0904201444200.26654@domain.hid>
	<49EF5149.9090609@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Success! (was Re: Tests with 2.5rc1)
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
Cc: xenomai@xenomai.org


On Wed, 22 Apr 2009, Gilles Chanteperdrix wrote:
>...
> We must tell everyone on this list that high-res timers work for the
> current hardware we run our tests on, so that people do not conclude
> that hi-res timers do not work with Xenomai.
>
> So, I see from previous posts that you have PM-timers enabled, could you
> try to re-enable high_res_timers, and disable PM-timers ?

Yes, enabling HIGH_RES_TIMERS and disabling X86_PM_TIMER also fixes
the problem. In detail, after I re-enabled HIGH_RES_TIMERS, and
enabled EMBEDDED so that I could change the X86_PM_TIMER option, I
recompiled the kernel 4 times, toggling just the state of the
X86_PM_TIMER option. The results were as follows:

In the two cases where X86_PM_TIMER was enabled, the normal dd test
reliably hung the computer after about half a minute, leaving the
computer completely unresponsive to the keyboard and to pings from
other machines. Leading up to these hangs, top reported that dd was
getting very little CPU time, even though nothing else was running. I
limited dd to copying 5.1GB at a time, by setting its count argument
to 10000000, and was thus able to verify that dd eventually completed,
and that at that point, the system returned to normal, except that the
clock resumed from where it had been when the hang started, and was
thus left running slow. In other words, dd ran normally, but the clock
that would have otherwise allowed the scheduler to switch to other
tasks, stalled until dd finished.

In the two cases where X86_PM_TIMER was disabled, the system worked
fine. The dd process reliably got at least 95% of the CPU time when
nothing else was running, and never hung the computer.

Martin

