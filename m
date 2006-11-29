Message-ID: <456D66F4.7050100@domain.hid>
Date: Wed, 29 Nov 2006 11:54:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid>
	<456C8961.7060906@domain.hid>	<456C97B9.1000402@domain.hid>
	<456D4C7D.2040100@domain.hid>	<456D4ED4.5040405@domain.hid>
	<456D5399.4040901@domain.hid> <456D5871.6040401@domain.hid>
	<456D60D7.4090202@domain.hid>
In-Reply-To: <456D60D7.4090202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>Jan Kiszka wrote:
>>>
>>>>OK. So you are suggesting to read out the affinity mask from task_struct
>>>>instead of passing it as an additional argument?
>>>>
>>>
>>>Unless I am wrong, it is the way it currently works.
>>>
>>
>>Yes, for the posix skin. But native is different due to the spilt-up
>>create/start and its own affinity API. And that caused problems when
>>applying nkaffinity.
>>
>>Nevertheless, I should try to combine the cleanup of xnshadow_map with
>>passing the mask ALWAYS in task_struct. Let's see how this works out,
>>most likely with less patching.
> 
> 
> sched_setaffinity is 2.6 only. So we would have to push the mask
> application into kernel space for the native skin anyway. Hmm.
> 
> What are posix skin users supposed to do over 2.4?


Right, I did not think about the 2.4 kernel, but I am not sure there are
many people using the 2.4 kernel on SMP machines anyway.

As for the native skin, it already allows to pass the affinity to
rt_task_create, using T_CPU.


> Upgrade to 2.6? BTW, do you plan to support pthread_attr_setaffinity_np somehow?

pthread_attr_setaffinity_np is implemented in kernel space, and the
pthread_attr_t is passed unchanged by __wrap_pthread_create to
__real_pthread_create. So pthread_attr_setaffinity_np should be already
working provided that you use a libc that supports it.

> 
> Jan
> 


-- 
                                                 Gilles Chanteperdrix

