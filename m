Message-ID: <43F21F56.4080602@domain.hid>
Date: Tue, 14 Feb 2006 19:20:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
References: <43F1C095.8030805@domain.hid> <43F2161D.9000906@domain.hid>
	<43F219C9.2030903@domain.hid>
In-Reply-To: <43F219C9.2030903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Hi,
>>>
>>>while XENO_OPT_DEBUG is generally a useful switch for tracing potential
>>>issues in the core and the skins, it also introduces high latencies via
>>>the queue debugging feature (due to checks iterating over whole queues).
>>>
>>>This patch introduces separate control over queue debugging so that you
>>>can have debug checks without too dramatic slowdowns.
>>>
>>
>>Maybe it's time to introduce debug levels, so that we could reuse them
>>in order to
>>add more (selectable) debug instrumentation; queue debugging could then
>>be given a
>>certain level (likely something like CONFIG_XENO_DEBUG_LEVEL=8712 for
>>this one...), instead of going for a specific conditional each time we
>>introduce new checks?
>>
> 
> 
> Hmm, this means someone have to define what should be printed at which
> level - tend to be hard decisions... Often it is at least as much useful
> to have debug groups so that specific parts can be excluded from
> debugging. I'm pro such groups (one would be those queues e.g.) but
> contra too many levels (2, at most 3).
> 

Ack, selection by increasingly verbose/high-overhead groups is what I have in mind.

> At this chance, I would also suggest to introduce some ASSERT macro (per
> group, per level). That could be used to instrument the core with
> runtime checks. But it could also be quickly removed at compilation
> time, reducing the code size (e.g. checks at the nucleus layer against
> buggy skins or at RTDM layer against rough drivers).
>

I'm not opposed to that, if we keep the noise / signal ratio of those assertions 
at the reasonable low-level throughout the code, and don't use this to enforce 
silly parametrical checks.

> Jan
> 


-- 

Philippe.

