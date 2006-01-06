Message-ID: <43BE5507.3040805@domain.hid>
Date: Fri, 06 Jan 2006 12:31:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43BC4FFB.8040709@domain.hid> <43BCF891.1080402@domain.hid>
	<43BCFFBB.1080303@domain.hid>
In-Reply-To: <43BCFFBB.1080303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] Re: [PATCH] latency tracer update
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>Hi again,
>>>
>>>here comes the first update of the new latency tracer.
>>>
>>> arch/i386/kernel/entry.S      |   27 +++
>>
>>
>>Is there any good reason to patch the callers of __ipipe_handle_irq
>>instead of instrumenting the callee directly?
>>
> 
> 
> To capture the invocation delay of __ipipe_handle_irq itself.
> 

Ok.

> 
>>> arch/i386/kernel/ipipe-root.c |    4
>>> include/asm-i386/system.h     |   70 +++++++++
>>> include/linux/ipipe_trace.h   |    3
>>> kernel/ipipe/Kconfig          |   18 ++
>>> kernel/ipipe/tracer.c         |  247 +++++++++++++++++++++++-----------
>>> 6 files changed, 288 insertions(+), 81 deletions(-)
>>>
>>
>>
> 
> Meanwhile I found a solution for the described unterminated trace (put
> an explicite trace_end at the end of __ipipe_unstall_iret_root),
> 

Yeah, sorry for the delay in answering. That's indeed the way to do it.

included the irq number in the begin/end report, and stumbled over some
> other remaining unterminated trace on a different machine. So, no need
> to hurry with the merge (not the review! ;) ), I will publish a second
> revision first.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

