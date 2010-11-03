Message-ID: <4CD1BA29.9000303@domain.hid>
Date: Wed, 03 Nov 2010 20:38:17 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>
	<4CD18782.7090607@domain.hid>
	<4CD191EE.7000604@domain.hid> <4CD1936E.50203@domain.hid>
In-Reply-To: <4CD1936E.50203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Am 03.11.2010 17:46, Anders Blomdell wrote:
>> Anders Blomdell wrote:
>>> Anders Blomdell wrote:
>>>> Jan Kiszka wrote:
>>>>> additional barrier. Can you check this?
>>>>>
>>>>> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
>>>>> index df56417..66b52ad 100644
>>>>> --- a/include/nucleus/sched.h
>>>>> +++ b/include/nucleus/sched.h
>>>>> @@ -187,6 +187,7 @@ static inline int xnsched_self_resched_p(struct 
>>>>> xnsched *sched)
>>>>>    if (current_sched != (__sched__))    {                \
>>>>>        xnarch_cpu_set(xnsched_cpu(__sched__), 
>>>>> current_sched->resched);    \
>>>>>        setbits((__sched__)->status, XNRESCHED);                \
>>>>> +      xnarch_memory_barrier();                        \
>>>>>    }                                    \
>>>>>  } while (0)
>>>> In progress, if nothing breaks before, I'll report status tomorrow 
>>>> morning.
>>> It still breaks (in approximately the same way). I'm currently putting a 
>>> barrier in the other macro doing a RESCHED, also adding some tracing to 
>>> see if a read barrier is needed.
>> Nope, no luck there either. Will start interesting tracepoint 
>> adding/conversion :-(
> 
> Strange. But it was too easy anyway...
> 
>> Any reason why xn_nucleus_sched_remote should ever report status = 0?
> 
> Really don't know yet. You could trigger on this state and call
> ftrace_stop() then. Provided you had the functions tracer enabled, that
> should give a nice pictures of what happened before.

Isn't there a race betweeen these two (still waiting for compilation to 
be finished)?

static inline int __xnpod_test_resched(struct xnsched *sched)
{
	int resched = testbits(sched->status, XNRESCHED);
#ifdef CONFIG_SMP
	/* Send resched IPI to remote CPU(s). */
	if (unlikely(xnsched_resched_p(sched))) {
		xnarch_send_ipi(sched->resched);
		xnarch_cpus_clear(sched->resched);
	}
#endif
	clrbits(sched->status, XNRESCHED);
	return resched;
}

#define xnsched_set_resched(__sched__) do {                   \
   xnsched_t *current_sched = xnpod_current_sched();           \
   setbits(current_sched->status, XNRESCHED);                  \
   if (current_sched != (__sched__))     {                     \
       xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched); \
       setbits((__sched__)->status, XNRESCHED);                \
       xnarch_memory_barrier();                                \
   }                                                           \
} while (0)

I would suggest (if I have got all the macros right):

static inline int __xnpod_test_resched(struct xnsched *sched)
{
	int resched = testbits(sched->status, XNRESCHED);
	if (unlikely(resched)) {
#ifdef CONFIG_SMP
		/* Send resched IPI to remote CPU(s). */
		xnarch_send_ipi(sched->resched);
		xnarch_cpus_clear(sched->resched);
#endif
		clrbits(sched->status, XNRESCHED);
	}
	return resched;
}

/Anders


