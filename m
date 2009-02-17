Message-ID: <499AF82A.20406@domain.hid>
Date: Tue, 17 Feb 2009 18:47:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>
	<20090217170419.1425.15313.stgit@domain.hid>
	<499AF09F.8040402@domain.hid> <499AF3C9.2040502@domain.hid>
	<499AF5DC.6010602@domain.hid>
In-Reply-To: <499AF5DC.6010602@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> @@ -192,6 +192,9 @@ static void *__pthread_trampoline(void *arg)
>>>>  
>>>>  	param.sched_priority = iargs->prio;
>>>>  	policy = iargs->policy;
>>>> +	if (policy == SCHED_RR)
>>>> +		/* Restrict round-robin scheduling to the Xenomai domain. */
>>>> +		policy = SCHED_FIFO;
>>> Should not there be the same thing in __wrap_pthread_setschedparam ?
>> Yes, and setschedparam_ex, here we go:
> 
> Actually, I am wondering if we can not get rid of these calls to
> __real_pthread_setschedparam, now that propagating kernel-space priority
> to user-space is done by a signal ?

Not with the existing code, as that only forwards prio changes, but no
policy changes.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

