Message-ID: <4BF267D3.4040500@domain.hid>
Date: Tue, 18 May 2010 12:11:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF251EC.7040605@domain.hid>
In-Reply-To: <4BF251EC.7040605@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Steve Deiters wrote:
>>> Periodically setting the time is risky if timed jobs depend 
>>> on Xenomai's real-time clock - it may jump in all directions...
>>>
>>>> Any other suggestions for providing timestamps to real time 
>>> tasks in 
>>>> this case?
>>> Do you just need precise timestamps from with real-time 
>>> tasks, or do you have to synchronize timer events of the 
>>> Xenomai core on an external clock?
>>>
>>> For the former case (precisely our scenario), we laid the 
>>> ground to extend Xenomai 2.5 with RT-safe syscalls to obtain 
>>> Linux's view on gettimeofday. It "just" needs some polishing 
>>> to post this for upstream.
>>> Wolfgang (CC'ed) is working on this.
>> I'm just looking to get timestamps in the real time task.  At least in
>> my case being able to call gettimeofday from the real time thread would
>> be exactly what I need.
> 
> then you might want to try the attached patches for Ipipe and
> Xenomai. For upstream submission, they still need a bit of
> cleaning up as Jan mentioned, and I'll also prepare a proper
> series then. Testing is very welcome, however.

Ok. The following points should be fixed before submission:
- gettimeofday should not have another timebase than
clock_gettime(CLOCK_REALTIME): in other word, the whole clock system
should be based on the ntp clock.
- you should not use vread, you should use __xn_rdtsc directly in
user-space, otherwise, your code would only work on x86. Of course this
means that the I-pipe should create a clocksource with whatever hardware
counter the architecture is providing to Xenomai. This also means that
the I-pipe should declare a clocksource using whatever hardware counter
is provided by the architecture with highest priority than other
clocksources, to ensure that Linux is using the same clock source as
Xenomai, and that NTP is correcting that clock source. This would also
remove the issue with Linux declaring the tsc unstable.
- why the transactionnal mechanism at all? Why not simply using seqlocks
with an ipipe_spinlock, and do the update with irqs off? the locking
section is much shorter than, say, xnpod_schedule, so it will not have
any influence on the worst case latency, and the reader side will still
be lockless.
- the NTP event should trigger an ipipe event with ipipe_dispatch_event.

-- 
					    Gilles.

