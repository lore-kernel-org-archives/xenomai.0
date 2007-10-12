Message-ID: <470F5753.5020809@domain.hid>
Date: Fri, 12 Oct 2007 13:15:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
In-Reply-To: <20071012110054.GA26325@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>, Xenomai-core@domain.hid

Stelian Pop wrote:
> On Fri, Oct 12, 2007 at 11:14:43AM +0200, Jan Kiszka wrote:
> 
>> Hmm, that's not too different from my own test setup.
> 
> I'm attaching the .config and dmesg in case you see something strange.
> 
>> /proc/xenomai/timerstat/master may provide further hints about the state
>> of the host timer (please keep my patch applied for this).
> 
> /proc/xenomai/timerstat/master says:
> 
> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
> 0    1           1           -          -          NULL         [host-timer]
> 
>> Also, you
>> could take an I-pipe trace around the timer takeover and the following
>> few milliseconds, using the new trigger feature:
>>
>> echo rthal_timer_request > /proc/ipipe/trace/trigger
> 
> It gives this:
> 
> root@domain.hid# cat /proc/ipipe/trace/max

/frozen holds the result. Also, a bit more post_trace_points may help to
see what goes on after that function is called.

> 
>> BTW, does the latency test of Xenomai work?
> 
> No. It hangs after "warming up". I'm able to interrupt with ^C and then
> it prints a single line showing a max latency of 208983.492 ms (same value
> on several invocations).

Ah, then we may fail to program the APIC appropriately. That would need
a closer look if you want to dig into this. /me is going to be
distracted from this for now.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

