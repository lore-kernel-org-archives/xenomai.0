Message-ID: <43F31A6F.3060807@domain.hid>
Date: Wed, 15 Feb 2006 13:11:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
References: <43F1C095.8030805@domain.hid>
	<43F2161D.9000906@domain.hid>	<43F219C9.2030903@domain.hid>
	<43F21F56.4080602@domain.hid> <43F2FABE.7070305@domain.hid>
In-Reply-To: <43F2FABE.7070305@domain.hid>
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
>>>Philippe Gerum wrote:
>>>
>>>
>>>>Jan Kiszka wrote:
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>while XENO_OPT_DEBUG is generally a useful switch for tracing potential
>>>>>issues in the core and the skins, it also introduces high latencies via
>>>>>the queue debugging feature (due to checks iterating over whole
>>>>>queues).
>>>>>
>>>>>This patch introduces separate control over queue debugging so that you
>>>>>can have debug checks without too dramatic slowdowns.
>>>>>
>>>>
>>>>Maybe it's time to introduce debug levels, so that we could reuse them
>>>>in order to
>>>>add more (selectable) debug instrumentation; queue debugging could then
>>>>be given a
>>>>certain level (likely something like CONFIG_XENO_DEBUG_LEVEL=8712 for
>>>>this one...), instead of going for a specific conditional each time we
>>>>introduce new checks?
>>>>
>>>
>>>
>>>Hmm, this means someone have to define what should be printed at which
>>>level - tend to be hard decisions... Often it is at least as much useful
>>>to have debug groups so that specific parts can be excluded from
>>>debugging. I'm pro such groups (one would be those queues e.g.) but
>>>contra too many levels (2, at most 3).
>>>
>>
>>Ack, selection by increasingly verbose/high-overhead groups is what I
>>have in mind.
>>
>>
>>>At this chance, I would also suggest to introduce some ASSERT macro (per
>>>group, per level). That could be used to instrument the core with
>>>runtime checks. But it could also be quickly removed at compilation
>>>time, reducing the code size (e.g. checks at the nucleus layer against
>>>buggy skins or at RTDM layer against rough drivers).
>>>
>>
>>I'm not opposed to that, if we keep the noise / signal ratio of those
>>assertions at the reasonable low-level throughout the code, and don't
>>use this to enforce silly parametrical checks.
>>
> 
> 
> Then let's discuss how to implement and control this. Say we have some
> macros for marking code as "depends on debug group X":
> 
> #if XENO_DEBUG_GROUP(group)
> code;
> #endif /* XENO_DEBUG_GROUP(group) */
> 
> XENO_IF_DEBUG_GROUP(group, code);
> 
> (or do you prefere XNPOD_xxx?)
> 

This debug code may span feature/component boundaries, so XENO_ is better.

> Additionally, we could introduce that assertion macro:
> 
> XENO_ASSERT(group, expression, failure_code);
> 
> But how to control the groups now? Via Kconfig bool options?

Yes, I think so. From some specialized Debug menu in the generic portion. We would 
need this to keep the (unused) debug code out of production systems.

  And what
> groups to define? Per subsytem? Or per disturbance level (latency
> regression)? If we control the group selection via Kconfig, we could
> define pseudo bool options like "All debug groups" or "Low-intrusive
> debug groups" that select the fitting concrete groups.
>

We won't be able to anticipate on each and every debug spots we might need in the 
future, and in any case, debug triggers may well span multiple sub-systems. I'd go 
for defining levels depending on the throroughness/complexity of their checks.

> Alternatively, we could make the group selection a runtime switch,
> controlled via a global bitmask that can be modified through /proc e.g.
> Only switching of CONFIG_XENO_OPT_DEBUG would then remove all debugging
> code, otherwise the execution of the checks would depend on the current
> bitmask content.

We could cumulate this with the static selection.

> 
> Jan
> 


-- 

Philippe.

