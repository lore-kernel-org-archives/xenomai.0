Message-ID: <4ACB4C70.80406@domain.hid>
Date: Tue, 06 Oct 2009 15:56:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid>
	<4AC5F49E.3070608@domain.hid>	<4AC5FEAD.7000608@domain.hid>
	<4AC77576.9070700@domain.hid>	<4AC9E655.5090006@domain.hid>
	<4AC9ED6B.4050004@domain.hid>	<4AC9F4FA.5070409@domain.hid>
	<4ACA013F.8040602@domain.hid> <4ACB4389.10109@domain.hid>
In-Reply-To: <4ACB4389.10109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> ...
>>
>> Is there a chance to grab the panic log via serial line? The first of
>> your two screenshots indicate that there might have happened something
>> interesting before the NMI triggered, but it's scrolled out of sight.
>>
>> Jan
>>
> 
> Hello,
> here I send kernel panic (triggered by rt_task_sleep and latency test)
> grabbed via serial line.

Hmm, still only NMI alarms...

> 
> I'm ready to help with resolving this issue.

Could you try enabling the I-pipe tracer with function tracing? It
should dump a trace of the functions that were executed before the
watchdog triggered. You may need to extend the number of tracepoints a
bit, try "echo 1000 > /proc/ipipe/trace/back_trace_points".

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

