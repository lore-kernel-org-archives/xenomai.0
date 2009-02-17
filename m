Message-ID: <499B0028.2090402@domain.hid>
Date: Tue, 17 Feb 2009 18:21:28 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>
	<20090217170419.1425.15313.stgit@domain.hid>
	<499AF09F.8040402@domain.hid> <499AF3C9.2040502@domain.hid>
	<499AF5DC.6010602@domain.hid> <499AF82A.20406@domain.hid>
	<499AF8E7.5000304@domain.hid> <499AFA8D.3080302@domain.hid>
	<499AFF38.5030509@domain.hid> <499AFFC6.1030207@domain.hid>
In-Reply-To: <499AFFC6.1030207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 1/4] POSIX: Fix SCHED_RR thread
	creation
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> @@ -192,6 +192,9 @@ static void *__pthread_trampoline(void *arg)
>>>>>>>>>  
>>>>>>>>>  	param.sched_priority = iargs->prio;
>>>>>>>>>  	policy = iargs->policy;
>>>>>>>>> +	if (policy == SCHED_RR)
>>>>>>>>> +		/* Restrict round-robin scheduling to the Xenomai domain. */
>>>>>>>>> +		policy = SCHED_FIFO;
>>>>>>>> Should not there be the same thing in __wrap_pthread_setschedparam ?
>>>>>>> Yes, and setschedparam_ex, here we go:
>>>>>> Actually, I am wondering if we can not get rid of these calls to
>>>>>> __real_pthread_setschedparam, now that propagating kernel-space priority
>>>>>> to user-space is done by a signal ?
>>>>> Not with the existing code, as that only forwards prio changes, but no
>>>>> policy changes.
>>>> If we map SCHED_RR to SCHED_FIFO, are there any policy changes?
>>> Yes, the initial one. Keep in mind that not all pthread implementations
>>> may respect the pthread_attr or have problems assigning SCHED_FIFO to
>>> threads of non-root users.
>> Ok. What about calling xnshadow_renice in xnshadow_map ?
> 
> Sorry, I can't follow. xnshadow_renice does not help user space to find
> the right policy, or what do you mean?

xnshadow_renice sends a signal to the user-space thread which in turn
calls __real_pthread_setschedparam.

The advantage of this solution is that it avoids calling
__real_pthread_setschedparam in many places in the user-space skins.

-- 
                                                 Gilles.

