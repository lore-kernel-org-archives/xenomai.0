Message-ID: <55897039.6040902@siemens.com>
Date: Tue, 23 Jun 2015 16:42:01 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
 <5588FA58.2080403@siemens.com>
 <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
 <20150623141142.GK17436@csclub.uwaterloo.ca> <55896A1A.2030408@siemens.com>
 <CAOL1OyNELX_6g8fOSS8wuJ+6-TzrBXjoxn3wH-Gb8u-HKHFqSw@mail.gmail.com>
In-Reply-To: <CAOL1OyNELX_6g8fOSS8wuJ+6-TzrBXjoxn3wH-Gb8u-HKHFqSw@mail.gmail.com>
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
To: Antoine Durand <wanipof@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

[restoring cc list]

On 2015-06-23 16:25, Antoine Durand wrote:
> I can "repair" the linux system time by forcing clock source from
> refined-jiffies to tsc
> 
> $ echo tsc >
> /sys/devices/system/clocksource/clocksource0/current_clocksource
> 
> Linux used refined-jiffies due to those messages at boot :
> 
> tsc: Fast TSC calibration using PIT
> tsc: Detected 2100.042 MHz processor
> PTP clock support registered
> Switched to clocksource refined-jiffies
> Switche to clocksource tsc
> rtc_cmos: setting system clock to 2015-06-23 17:28:56 UTC (1435080536)
> Clocksource tsc unstable (delta = 128069998 ns)
> Switched to clocksource refined-jiffies

jiffies - that is not good and explains the unstable timebase.

> 
> I don't know why.
> I've a modern core i7 CPU with constant_tsc flag (in /proc/cpuinfo)
> 
> 
> here are my HZ config:
> 
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_NO_HZ=y

OK, CONFIG_NO_HZ, but that is set here as well. I was thinking of
NO_HZ_FULL when Lennart mentioned it. That's not tested and may cause
troubles.

> # CONFIG_RCU_FAST_NO_HZ is not set
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> 

We don't have the full picture of your config yet: Do you use CPU
frequency scaling? Or some specific powersaving modes?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

