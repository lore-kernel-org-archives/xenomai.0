Message-ID: <444FA217.70102@domain.hid>
Date: Wed, 26 Apr 2006 18:38:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: Adeos-cvs Digest, Vol 10, Issue 11
References: <E1FYmA5-0003S9-00@domain.hid> <444F9BDB.200@domain.hid>
	<444F9DDA.7000400@domain.hid> <444F9FBE.8030506@domain.hid>
In-Reply-To: <444F9FBE.8030506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>adeos-cvs-request@domain.hid wrote:
>>>
>>>
>>>>...
>>>>Commit from rpm (2006-04-26 17:41 CEST)
>>>>---------------
>>>>
>>>>Make IPIPE_TRACE_PATHS configurable
>>>>
>>>> ipipe  v2.6/common/kernel/ipipe/tracer.c       1.10
>>>> ipipe  v2.6/common/kernel/ipipe/Kconfig.trace  1.4
>>>
>>>
>>>From a quick glance it appears to me you provided a nice interface to
>>>break some stuff :). At least the explanation is not correct.
>>>
>>>Those four paths are required to 1) always have an active path at hand
>>>for recording, 2+3) keep the latest max or frozen path, and 4) escape
>>>with to an alternative slot during max/frozen updates in case the
>>>previous one is currently locked for output or whatever and cannot
>>>become the new active path.
>>>
>>>So, the absolute minimum is 3 when there is definitely no concurrent
>>>usage of ipipe_trace_begin/end vs. ipipe_trace_freeze (remember that
>>>users may want to define their own begin/end points if
>>>IPIPE_TRACE_IRQSOFF is not set). Raising it above 4 is of no practical
>>>use so far.
>>>
>>
>>Oh, wait, you've just explained why passing -f to the latency test
>>freezes my board! Thanks :o)
>>
> 
> 
> Famous last words while reaching out the finger:
> 
> "Hey, what is this knob for?" :)
> 

Yeah, hopefully, next time I'm naive and optimistic, the fine print on 
the button won't say "ejection seat"...

-- 

Philippe.

