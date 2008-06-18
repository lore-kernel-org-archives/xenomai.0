Message-ID: <4859424F.1030400@domain.hid>
Date: Wed, 18 Jun 2008 19:13:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48568E78.5000606@domain.hid>	<485695AE.7030509@domain.hid>	<485794CC.3030102@domain.hid>	<485799E6.2060602@domain.hid>	<48579C9B.1070402@domain.hid>
	<4857B41B.5060300@domain.hid>	<4857B670.9060107@domain.hid>
	<4858E524.7040902@domain.hid>
In-Reply-To: <4858E524.7040902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] latency fix for 2.6.25?
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Pierangelo Masarati <masarati@domain.hid>
Cc: adeos-main@gna.org

Pierangelo Masarati wrote:
> Philippe Gerum wrote:
> 
>>>> Ok, you were talking about the _previous_ implementation, right?
>>> Yes.  It's been running for a few hours today, so your fix seems to be 
>>> fine; in any case, the tests will run overnight, and I'll let you know 
>>> tomorrow.  I believe this issue could not be easily pointed out by just 
>>> a simple latency check.
>>>
>> Agreed, we need to create a load that makes races on seqlocks more likely, and
>> ideally with lots of readers delaying a single writer.
> 
> The testing of your fix ran overnight without problems, so we'd consider 
> it fine.

Ok, thanks. Will issue -03 asap.

  Another possible fix to preserve linux timings is to use
> local_irq_disable_hw() after halt.  It seems to create no significant 
> latency.
> 

The only way to fully preserve the timings would involve running
sched_clock_idle_wakeup_event() with hw interrupts off, which grabs a spinlock
on the current runqueue; I'm worried about latencies introduced by sporadic
contention on that lock due to task migrations.

OTOH, the scheduler tick handler implements a counter-measure against underflows
of the per-runqueue clocks, so even if the RTOS preempts often or for a long
time the idling code, it should resync reasonably well. Hopefully.

-- 
Philippe.

