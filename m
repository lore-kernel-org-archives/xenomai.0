Message-ID: <45DF02B0.4090406@domain.hid>
Date: Fri, 23 Feb 2007 16:05:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>	<45DEF605.2060402@domain.hid>
	<45DEF6AA.5030609@domain.hid> <45DEFB2F.10103@domain.hid>
In-Reply-To: <45DEFB2F.10103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

Steven Scholz wrote:
> Hi,
> 
> 
>>>schedule. Anyway, I think the tracer will give better results than a
>>>simple backtrace.
>>
>>Ok. Thanks.
>>
>>So what exactly shell I do? I have never worked with "the tracer".
> 
> 
> Just enabled
> 
> CONFIG_IPIPE_DEBUG=y
> CONFIG_IPIPE_TRACE=y
> CONFIG_IPIPE_TRACE_ENABLE=y
> CONFIG_IPIPE_TRACE_MCOUNT=y
> CONFIG_IPIPE_TRACE_IRQSOFF=y
> CONFIG_IPIPE_TRACE_SHIFT=15
> # CONFIG_IPIPE_TRACE_VMALLOC is not set
> CONFIG_IPIPE_TRACE_ENABLE_VALUE=1
> 
> but get
> 
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/asm/bitops.h: In function `____atomic_set_bit':
> include/asm/bitops.h:40: warning: implicit declaration of function `local_test_iflag_hw'

At first sight, replacing local_test_iflag_hw with
raw_irqs_disabled_flags should work.

-- 
                                                 Gilles Chanteperdrix

