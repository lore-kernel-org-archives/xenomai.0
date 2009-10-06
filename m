Message-ID: <4ACB5920.4040501@domain.hid>
Date: Tue, 06 Oct 2009 16:50:08 +0200
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid>
	<4AC5F49E.3070608@domain.hid>	<4AC5FEAD.7000608@domain.hid>
	<4AC77576.9070700@domain.hid>	<4AC9E655.5090006@domain.hid>
	<4AC9ED6B.4050004@domain.hid>	<4AC9F4FA.5070409@domain.hid>
	<4ACA013F.8040602@domain.hid> <4ACB4389.10109@domain.hid>
	<4ACB4C70.80406@domain.hid>
In-Reply-To: <4ACB4C70.80406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On 6.10.2009 15:56, Jan Kiszka wrote:
> Roman Pisl wrote:
>> ...
>>>
>>> Is there a chance to grab the panic log via serial line? The first of
>>> your two screenshots indicate that there might have happened something
>>> interesting before the NMI triggered, but it's scrolled out of sight.
>>>
>>> Jan
>>>
>>
>> Hello,
>> here I send kernel panic (triggered by rt_task_sleep and latency test)
>> grabbed via serial line.
>
> Hmm, still only NMI alarms...
>
>>
>> I'm ready to help with resolving this issue.
>
> Could you try enabling the I-pipe tracer with function tracing? It
> should dump a trace of the functions that were executed before the
> watchdog triggered. You may need to extend the number of tracepoints a
> bit, try "echo 1000>  /proc/ipipe/trace/back_trace_points".
>
> Jan
>

Unfortunately I get no kernel panic when both I-pipe tracer and NMI 
watchdog are enabled. The machine just totally freezes on both 
rt_task_sleep and latency test :( I tried serial console, text console, 
even tried disabling fb.

Roman

