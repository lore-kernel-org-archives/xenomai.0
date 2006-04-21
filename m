Message-ID: <4449513C.3040308@domain.hid>
Date: Fri, 21 Apr 2006 23:40:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>	<4448B81E.3090605@domain.hid>	<17480.63623.600656.828303@domain.hid>	<4448FE86.4050503@domain.hid>	<17481.417.382690.108221@domain.hid>	<44490B3D.2060600@domain.hid>
	<17481.6439.664844.663463@domain.hid>
	<44491B68.5080905@domain.hid> <4449220E.5000900@domain.hid>
In-Reply-To: <4449220E.5000900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
> Philippe Gerum wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>Philippe Gerum wrote:
>>> > What I suggested was to let people create normal threads using  >
>>>pthread_create (likely conforming to the SCHED_OTHER policy), then use
>>> > the redirected pthread_setschedparam syscall (i.e. always applied
>>>to the  > current thread) to promote them as Xenomai shadows, but
>>>leave them in  > their original scheduling class. The same goes for
>>>rt_task_shadow. This  > would be explicit actions that would not leave
>>>much room for "surprises".
>>>
>>>If I understand correctly, you mean that one should not be able to
>>>create real-time threads with pthread_create. My question was about what
>>>to do of explicit scheduling parameters passed to pthread_create through
>>>thread creation attributes.
>>
>>Nope, this is obviously not what I meant... :o>
>>
>>This is how one would create hybrids, without changing anything else to
>>the current interface:
>>
>>    pthread_attr_init(&attr);
>>    ...
>>    pthread_attr_setschedpolicy(&attr,SCHED_OTHER);
>>    ...
>>    pthread_create(...,&attr,&foo,NULL);
>>
>>and,
>>
>>void *foo (void *cookie)
>>{
>>    /* The following call maps a shadow thread to "current", but
>>              currently only accepts SCHED_FIFO, and would be changed to
>>                                   allow SCHED_OTHER/NORMAL. */
>>    pthread_setschedparam(...,SCHED_OTHER,...);
>>    /* OR, for the native API */
>>    rt_task_shadow(...,pri=0,...);
>>}
>>
> 
> 
> I think it melts down to the question: which kind of SCHED_OTHER threads
> will be more common in applications, the hybrid or the normal ones?
> Remember that we also still have the __real_pthread_create interface for
> creating /really/ normal threads...
> 
> The advantage of making hybrids default, even for the attr=NULL case,
> would be that the user will be able to interact with real-time
> SCHED_FIFO/RR threads without further coding effort (might be
> interesting for porting existing apps...).
> 

That's POSIX centric and seems acceptable, but the question remains open 
for the native API. Passing a null priority to rt_task_create would be 
way too confusing (i.e. a priority value should be an attribute of the 
scheduling class, not the other way around), hence the use of 
rt_task_shadow for this particular purpose.

> How much overhead would default-shadowing introduce when it is not used
> actively? Is it just the kernel pthread structure? Maybe we should
> consider allocating that structure from normal kernel memory to save
> rt-memory resources (under memory pressure, there is a risk in failing
> to create the Linux mate anyway).

Memory is not an issue anyway, since we need a full shadow TCB to allow 
the underlying thread to wait for sync objects, and generally speaking, 
to use the RT infrastructure to its full extent. IOW, there is nothing 
to save here, an hybrid thread would just be a regular Xenomai shadow 
that _only_ happens to undergo the SCHED_OTHER policy.

  I could also imagine that SCHED_OTHER
> threads will get started in relaxed mode by default so that the Xenomai
> scheduler will not be additionally loaded.
> 

Yes, we could do that. But in any case, an hybrid would be allowed to 
switch to primary for the purpose of pending on synchronization objects, 
which in turn would give hybrids a higher priority than regular Linux 
SCHED_FIFO threads (i.e. threads not mapped to a Xenomai shadow) in this 
mode.

-- 

Philippe.

