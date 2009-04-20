Date: Mon, 20 Apr 2009 12:16:44 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49ECBEE6.2060201@domain.hid>
Message-ID: <Pine.LNX.4.64.0904201151070.23588@domain.hid>
References: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
	<49ECBEE6.2060201@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Tests with 2.5rc1
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

Hi Gilles,

Thanks for the reply.

On Mon, 20 Apr 2009, Gilles Chanteperdrix wrote:
>>     Is there anything else that I need to do to get the watchdog to
>>     do something?
>
> The watchdog is probably working. The fact that you get the problem with
> the interrupt pipeline enabled but not Xenomai proves that the culprit
> is not Xenomai's timer interception. So, what probably happens is that
> only Linux' timer is not working when you experience "hang ups". You can
> check that by checking the irqs count in /proc/xenomai/irq when latency
> is running.

The irqs count in /proc/xenomai/irq also freezes, and since Linux is
also using the local-APIC timer interrupts for its clock, both the
number shown in /proc/xenomai/irq and the number shown in
/proc/interrupts for LOC, behave the same.

> In any case, you should run without NO_HZ and should try to disable high
> res timers to see if it helps further.

I've been running without NO_HZ, but I haven't tried with the high-res
timers disabled. If the new machines don't get here today, I'll try
turning off hi-res timers. This may seem like a waste of time, but my
boss's opinion was that even if I didn't resolve the issue, trying to
track it down would be good experience.

> Well, trying to solve an issue which happens on a machine with faulty
> RAM is not really interesting. So, unless you are able to test the same
> machine with working RAM, I would suggest to stop spending time on this
> issue.

Understood. I actually tried this with 9 different sticks of RAM,
which were all that I could get hold of. Unfortunately all of them
showed one or two errors when tested for a few hours with memtest86,
even when tested again on 3 different computers. Frustrating!

Thanks for the help,

Martin

