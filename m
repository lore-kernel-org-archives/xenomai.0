Message-ID: <4E7612AE.8000900@domain.hid>
Date: Sun, 18 Sep 2011 17:47:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E6C927F.3070901@domain.hid> <4E6CC49C.1020403@domain.hid>
	<4E6CC5CC.5020204@domain.hid> <4E73AE00.3040002@domain.hid>
	<4E73B403.1060706@domain.hid>
	<1316354565.2169.20.camel@domain.hid> <4E760186.3040907@domain.hid>
	<1316358615.2169.21.camel@domain.hid> <4E760A16.8080907@domain.hid>
	<4E760AA9.5090605@domain.hid> <4E760BCC.4080003@domain.hid>
	<4E760D20.9040802@domain.hid>
In-Reply-To: <4E760D20.9040802@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 09/18/2011 05:24 PM, Jan Kiszka wrote:
> On 2011-09-18 17:18, Gilles Chanteperdrix wrote:
>> What about:
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index 21cc191..7fe44a1 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -2756,9 +2756,12 @@ static inline void do_setsched_event(struct task_struct *p, int priority)
>>  	union xnsched_policy_param param;
>>  	struct xnsched *sched;
>>  
>> -	if (!thread || p->policy != SCHED_FIFO)
>> +	if (!thread || (p->policy != SCHED_FIFO && p->policy != SCHED_OTHER))
>>  		return;
>>  
>> +	if (p->policy == SCHED_OTHER)
>> +		priority = 0;
>> +
>>  	/*
>>  	 * Linux's priority scale is a subset of the core pod's
>>  	 * priority scale, so there is no need to bound the priority
> 
> No other policies can be issued against the Linux part of a shadow? Then
> it's OK. I just don't recall the details here ATM.
> 
> Jan
> 

This should be OK, according to the comment:
	 * BIG FAT WARNING: Change of scheduling parameters from the
	 * Linux side are propagated only to threads that belong to
	 * the Xenomai RT scheduling class. Threads from other classes
	 * are remain unaffected, since we could not map this
	 * information 1:1 between Linux and Xenomai.
	 */


-- 
                                                                Gilles.

