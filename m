From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
References: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Sep 2010 16:18:59 +0200
Message-ID: <1283955539.24088.55.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] question about priorities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Clerdan <charles.clerdan@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-09-08 at 13:45 +0200, Charles Clerdan wrote:
> Hi,
> 
> 
> I have a technical question about priorities under Xenomai.
> 
> According to my research, Xenomai use priority levels from 0 to 99. 99
> is the highest effective priority and 0 the lowest. 

To be precise, the Xenomai core can handle up to 258 priority levels
(0(lowest)-257(highest)). Within this range, skins/APIs set their own
sub-range, remapping levels internally to fit their specs. E.g. for
real-time threads, the native and posix skins use 1-99 , the VxWorks
skin uses 255-1, pSOS uses 1-255. All keep level 0 for special
Xenomai-enabled non-RT threads.

> But Linux uses levels from 0 to 139. For current task it uses levels
> 100 to 139 where 100 is highest priority than 139, and for "real time"
> threads 0 to 99 where 0 is highest than 99.s

SCHED_FIFO is 1-99 for static priorities. We are only interested in
remapping SCHED_FIFO and SCHED_RR over our priority scale. Other non-RT
scheduling classes managed by Linux are out of scope for Xenomai.

>  
> So when a task jumps in secondary modes is there a conversion of its
> own priority (100 - primary_mode_priority) or does she keep the same
> number.

SCHED_FIFO/SCHED_RR threads share the same priority scales both in Linux
and Xenomai domains.

> When two tasks with two different priorities are in secondary modes,
> is there a priority inversion between them or a crossed convertion of
> the priorities?

The priority of threads is not the issue. The issue here is that Linux
would run as the idle task of Xenomai, so a RT thread moving to
secondary mode - i.e. scheduled by Linux - would not compete anymore
with RT threads still scheduled by the Xenomai nucleus.

To work around this priority inversion, there is a mechanism to make the
Linux activity as a whole inherit the Xenomai priority of the Xenomai
thread which currently runs in secondary mode; it is enabled by default
(XENO_OPT_PRIOCPL). However, this mechanism only prevents a low-priority
Xenomai thread in primary mode from preempting a high-priority Xenomai
thread running in secondary mode; it does not give back all real-time
guarantees to the latter though.

> 
> Regards,
> 
> Charles
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



