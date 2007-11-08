Message-ID: <47339157.1010403@domain.hid>
Date: Thu, 08 Nov 2007 23:44:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4732C546.90602@domain.hid> <4733535E.4070700@domain.hid>
	<47336447.8090203@domain.hid> <47336D6D.2020203@domain.hid>
	<473382AB.6040708@domain.hid> <473386E6.4090204@domain.hid>
In-Reply-To: <473386E6.4090204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Testing LTTng: first insights
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
>> sysinfo.tmfreq was meant to be such value.
> 
> Well, then it is totally mis-initialised on x86 so far, same on powerpc.
> In fact, there it is the _clock_ frequency, not the timer frequency. So
> what is meant by this? One comment actually call it "Timebase frequency"
> (powerpc). This naming looks rather inconsistent.
>

That's the issue I just pointed out. Normally, tmfreq _should have been_
used as the timer frequency (or timebase frequency for powerpc), and
initialized that way. Because no Xenomai port actually cared, all ports
ended up doing the same thing as x86, i.e. setting this field to the CPU
freq because internally, x86 over APIC uses TSC values to program the
local timer. The same way, ia64 passes values from the on-chip clock
(ITC) to the ITM, and so on. Agreed 100%, it's lame, but since nobody
actually never used tmfreq the right way, it always ended up being set
the wrong way.

I suggest to use it the right way from now on.

>>  But to play cleanly, we would have to critical_enter first,
>>> look up the currently used clock_event_device, maybe even validate that
>>> it was hijacked, and then return its frequency. The problem with this
>>> API is, that it is by nature unsynchronised with ipipe_request_tickdev,
>>> thus would not always be able to return a valid frequency.
>>>
>> You get no special guarantee from getting the frequency out of the
>> request_tickdev call, because if the point is to prevent anyone from
>> changing/removing such device while you are using such value at Xenomai
>> level, then we can't, by design.
>>
>> So we may as well read per_cpu(ipipe_tick_cpu_device) from
>> ipipe_get_sysinfo() to access the current tick device installed, without
>> any downside. After all, the timer is something which has to be
>> considered as a reasonably stable property of the system. Btw, we don't
>> currently handle any change of frequency of the underlying hw timer, so
>> changing the device would not actually work, I guess.
>>
>> The next question may be, should we handle such situation? I tend to
>> think that we should not, because we just cannot accept any flaky
>> situation due to a misbehaving time source which would make the kernel
>> downgrade the current clock device, even temporarily, anyway. We have to
>> be confident in the current time source when operating.
>>
>>> Actually, we would only exclude a few patches when going the
>>> ipipe_request_tickdev way: those few that were clockevent-aware up to
>>> today. For all others (namely 2.6.20 on i386 and up to 2.6.23 on
>>> x86_64), we would simply fall back to our current inaccurate approach. I
>>> think this is more acceptable than an ipipe_get_sysinfo extension.
>>>
>> The archdep section from the sysinfo struct has been meant to be
>> extended, really, so I think it's actually cleaner to use it - if
>> possible - for this purpose, instead of adding new ad hoc interfaces for
>> dealing with a particular kernel feature.
> 
> The timer frequency is coupled with the process of requesting a specific
> tick device (I'm only talking about GENERIC_CLOCKEVENTS now, because
> this is what matters mid-term). Only after deciding what event source to
> use, one can obtain its frequency, thus passing it along the request
> process appears more than logical and clean to me. Providing this
> information "out of band" is broken IMHO, specifically as we need this
> value within a very well-define time window (after switching the
> clock_event, before using it).
> 

Ok, I'm not going to argue about cleanliness or brokenness about this
issue, because it's first and foremost a matter of taste. The main
point, I think, is this one: is the clock device something which may be
changed on-the-fly during real-time operations, in such a way that we
would have to atomically switch the device and get its frequency?
Moreover, would this all-in-one approach guarantee anything when we use
the frequency value to rescale timeout values, much later, long after
the atomic section has been exited?

Because the answer is no, then I would not go for yet another interface
breaking backward compatibility (even if I agree that we could live with
a few patches being obsoleted), just for the purpose of getting the
frequency in some atomic fashion, a guarantee which would not leave
beyond the return point from ipipe_request_tickdev(), and above all, a
guarantee we have no actual use of. This is where "cleanliness" may bite
harder than perceived "brokenness".

> However, that may not prevent us from doing something different for
> legacy kernels and not-yet CLOCKEVENT'ized archs, but only temporarily.
> 
> Jan
> 


-- 
Philippe.

