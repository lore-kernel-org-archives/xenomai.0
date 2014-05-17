Message-ID: <537781C1.6050101@xenomai.org>
Date: Sat, 17 May 2014 17:35:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400327350.427.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <1400335101.23289.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1400335101.23289.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Round-robin scheduling on cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/17/2014 03:58 PM, Matthias Schneider wrote:
> ----- Original Message -----
>
>> From: Matthias Schneider <ma30002000@yahoo.de>
>> To: "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Saturday, May 17, 2014 1:49 PM
>> Subject: [Xenomai] Round-robin scheduling on cobalt
>>
>> Hi all,
>>
>> When enabling rr schduling on cobalt via threadobj_set_rr(),  the call will be
>> forwarded to the cobalt-specific set_rr(). This function will then call
>> pthread_setschedparam_ex(), which in turn calls libc_setschedparam() for
>> updating the regular kernels view on the rr task. However, when using prios
>>>
>> 99, libc_setschedparam() will clip them for SCHED_COBALT / SCHED_RT, SCHED_TP,
>> SCHED_SPORADIC, SCHED_QUOTA, but not for SCHED_RR, leading to an EINVAL error.
>> Mercury maps rr scheduling to SCHED_FIFO. Shouldnt cobalt also register rr
>> tasks
>> as SCHED_FIFO and clip their prio? i.e. add SCHED_RR to the fall-through case
>> list of in libc_setschedparam()?
>>
>> Thanks in advance,
>>
>> Matthias
>>
>
> My observation is shows a situation slightly more complicate than described
> before. Scheduling policies are being set as follows:
>
> threadobj_init() sets either : SCHED_OTHER when prio = 0 or SCHED_RT otherwise
> (which maps to SCHED_COBALT on cobalt and SCHED_FIFO on mercury).
> set_rr may change the policy to SCHED_RR on cobalt or SCHED_FIFO on mercury.
>
> However, considering cobalt specific prios > 99, it seems that task with prios >
> 99 with SCHED_RT do actually work, but task with SCHED_RR seem to only to run
> into the issue described by my previous email, but also the cobalt core itself
> seems to expect something <=99 here:
>
> get_policy_param():
> [...]
> case SCHED_RR:
> [...]
>    if (prio < XNSCHED_FIFO_MIN_PRIO(1) ||
>        prio > XNSCHED_FIFO_MAX_PRIO(99))
>              return NULL;
>
> but not XNSCHED_RT_MAX_PRIO(257) as I would have expected.
>
> This leads to an EINVAL in the cobalt call for sc_cobalt_thread_setschedparam_ex
> in the same way like libc_setschedparam.
>
> Is the max prio on cobalt only 99 for RR tasks, while non-RR (i.e.
> SCHED_RT/SCHED_COBALT) tasks can go higher?
>

Yes. SCHED_RR and SCHED_FIFO have the same priority scale than their 
counterpart in the host kernel, [1..99]. SCHED_COBALT has access to the 
full range of priorities defined by the Cobalt core, i.e. 257.

-- 
Philippe.

