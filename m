MIME-Version: 1.0
In-Reply-To: <5588FA58.2080403@siemens.com>
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
 <5588FA58.2080403@siemens.com>
From: Antoine Durand <wanipof@gmail.com>
Date: Tue, 23 Jun 2015 12:09:09 +0200
Message-ID: <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Hi,

I found a new problem that must be the root cause of the others (I hope)
the linux system time is wrong, one second last 31 real seconds !

ftrace timing are wrong and may be nmi watchdog is fired because of that
wrong time too.

however the time run normally in /proc/driver/rtc
(the CPU board get a Dallas DS12887 / Motorola MC146818 compatible RTC)

I use the CLOCK_MONOTONIC clock in xenomai periodic task and it works well.
I-Pipe tracer timing are correct too.

in /proc/interrupts :
IRQ0 (timer) counter is not counting
LOC (local timer interrupts) is counting

in /proc/xenomai/irq :
[timer/0] is counting (following LOC value)

I'm trying to find why IRQ0 never happen.

Thanks.



2015-06-23 8:19 GMT+02:00 Jan Kiszka <jan.kiszka@siemens.com>:

> On 2015-06-22 22:47, Antoine Durand wrote:
> > Thank you,
> >
> > I really better understand the differences between the two traces
> sources.
> > Indeed I am more interrested in ftrace datas for the moment.
> >
> > I use a x86_64 CPCI cpu board with linux-3.16.7 and
> > xenomai-3.0-rc4 with I-Pipe tracer Options On
>
> The first thing is to switch the I-pipe tracer off, at least during
> runtime. You don't need that overhead if you do ftrace event tracing.
> But I suspect the issue elsewhere.
>
> >
> > My problem may comes from trace-cmd actually, because it uses nearly two
> > cores full time during ftrace collect.
> > I don't known what for ! I used it to be able to plot datas in
> kernelshark
> > but its overhead is too much.
> >
> > I will try with no external tools, (just /sys/kernel/debug/tracing/*
> > controls).
>
> I'm using trace-cmd without such problems. Can you share your .config?
> Could you also try 3.14.44-x86-9 (that's where I ran ftrace recently).
>
> >
> > I had to disable nmi (echo 0 > /proc/sys/kernel/nmi_watchdog) at boot to
> > avoid hard Lockup kernel crash when system load is high (running dohell
> for
> > exemple). I don't think it can be linked.
>
> Shouldn't happen either. Maybe related, and the system is in a general
> bad shape due to configuration or patch issues.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
>
