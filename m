Message-ID: <5588FA58.2080403@siemens.com>
Date: Tue, 23 Jun 2015 08:19:04 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
In-Reply-To: <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Durand <wanipof@gmail.com>, xenomai@xenomai.org

On 2015-06-22 22:47, Antoine Durand wrote:
> Thank you,
> 
> I really better understand the differences between the two traces sources.
> Indeed I am more interrested in ftrace datas for the moment.
> 
> I use a x86_64 CPCI cpu board with linux-3.16.7 and
> xenomai-3.0-rc4 with I-Pipe tracer Options On

The first thing is to switch the I-pipe tracer off, at least during
runtime. You don't need that overhead if you do ftrace event tracing.
But I suspect the issue elsewhere.

> 
> My problem may comes from trace-cmd actually, because it uses nearly two
> cores full time during ftrace collect.
> I don't known what for ! I used it to be able to plot datas in kernelshark
> but its overhead is too much.
> 
> I will try with no external tools, (just /sys/kernel/debug/tracing/*
> controls).

I'm using trace-cmd without such problems. Can you share your .config?
Could you also try 3.14.44-x86-9 (that's where I ran ftrace recently).

> 
> I had to disable nmi (echo 0 > /proc/sys/kernel/nmi_watchdog) at boot to
> avoid hard Lockup kernel crash when system load is high (running dohell for
> exemple). I don't think it can be linked.

Shouldn't happen either. Maybe related, and the system is in a general
bad shape due to configuration or patch issues.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

