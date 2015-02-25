Message-ID: <54EE15E0.10302@xenomai.org>
Date: Wed, 25 Feb 2015 19:35:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
In-Reply-To: <54EE07A9.4040702@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 02/25/2015 06:34 PM, Philippe Gerum wrote:
> On 02/25/2015 05:22 PM, Lowell Gilbert wrote:
>> Thanks for the help, even if I'm not making much progress yet.
>>
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
>>
>>> On Tue, Feb 24, 2015 at 06:01:18PM -0500, Lowell Gilbert wrote:
>>
>>> To have a real basic configuration, you should use Xenomai 2.6.4 and
>>> with the latest I-pipe patch for Linux 3.14. Unmodified.
>>
>> I went ahead and did that, just to be sure. Results were the same.
>>
>>>> put the i-pipe TSC code back into smp_twd.c
>>>> to get a high-resolution clock.
>>>
>>> The TSC code in smp_twd.c conflicts with Linux global timer driver.
>>> Simply enable the global timer driver if you want to use the global
>>> timer as tsc.
>>
>> Got it. Thanks.
>>
>>
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> -	return 0;
>>> +	return RTDM_IRQ_HANDLED;
>>
>> Yes, that bug crept in when I was building the simplified test case.
>> My original driver used the correct return values.
>>
>>
>> I'm still confused by the fact that the thread wakes up fine if it's
>> signalled (or unblocked, etc.) from a driver operation. But if the ISR
>> tries to do the same, it fails. In fact, if I use rtdm_task_unblock(), I
>> get an error (0) returned to the ISR.
>>
>>
> 
> We need to know what happens in the kernel from the ISR then all along
> the IRQ exit path. To this end, please enable CONFIG_IPIPE_TRACE in the
> kernel configuration. Assuming you run Xenomai 2.6.4, you will need to
> patch this snippet into the Xenomai kernel code:
> 
> diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
> index ef36036..08ee192 100644
> --- a/ksrc/nucleus/intr.c
> +++ b/ksrc/nucleus/intr.c
> @@ -433,6 +433,9 @@ static inline int xnintr_irq_detach(xnintr_t *intr)
> 
>  #endif /* !CONFIG_XENO_OPT_SHIRQ */
> 
> +int debug_event_signal;
> +EXPORT_SYMBOL(debug_event_signal);
> +
>  /*
>   * Low-level interrupt handler dispatching non-shared ISRs -- Called with
>   * interrupts off.
> @@ -504,6 +507,9 @@ static void xnintr_irq_handler(unsigned irq, void
> *cookie)
>  	}
> 
>  	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
> +
> +	if (debug_event_signal)
> +		ipipe_trace_freeze(0xfefefefe);
>  }
> 
>  int __init xnintr_mount(void)
> 

This patch assumes that CONFIG_XENO_OPT_SHIRQ is _disabled_ in your
Kconfig, which is the default setup.

-- 
Philippe.

