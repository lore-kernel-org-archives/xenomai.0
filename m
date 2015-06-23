From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 23 Jun 2015 10:11:42 -0400
Message-ID: <20150623141142.GK17436@csclub.uwaterloo.ca>
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
 <5588FA58.2080403@siemens.com>
 <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Tue, Jun 23, 2015 at 12:09:09PM +0200, Antoine Durand wrote:
> I found a new problem that must be the root cause of the others (I hope)
> the linux system time is wrong, one second last 31 real seconds !
> 
> ftrace timing are wrong and may be nmi watchdog is fired because of that
> wrong time too.
> 
> however the time run normally in /proc/driver/rtc
> (the CPU board get a Dallas DS12887 / Motorola MC146818 compatible RTC)

Normally the RTC is only used to get time at boot and save it when the
system is off.  It usually has nothing at all to do with system time
while the system is running.

So having the rtc correct but system time wrong is perfectly plausible
if whatever is used for system time is broken.

> I use the CLOCK_MONOTONIC clock in xenomai periodic task and it works well.
> I-Pipe tracer timing are correct too.
> 
> in /proc/interrupts :
> IRQ0 (timer) counter is not counting
> LOC (local timer interrupts) is counting
> 
> in /proc/xenomai/irq :
> [timer/0] is counting (following LOC value)
> 
> I'm trying to find why IRQ0 never happen.

Are you running NO_HZ config?

-- 
Len Sorensen

