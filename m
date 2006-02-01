Message-ID: <43E10708.3030109@domain.hid>
Date: Wed, 01 Feb 2006 20:07:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fix pthread cancellation in native skin
References: <43DB3AB1.5090004@domain.hid>	<17373.63969.941760.677529@domain.hid>	<17376.43570.396834.405041@domain.hid>
	<43E0FCB8.1050902@domain.hid>
In-Reply-To: <43E0FCB8.1050902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
> 
>> Gilles Chanteperdrix wrote:
>>  > This is not the only situation where a thread with a nucleus 
>> suspension
>>  > bit need to run shortly in secondary mode: it also occurs when
>>  > suspending with xnpod_suspend_thread() a thread running in secondary
>>  > mode; the thread receives the SIGCHLD signal and need to execute 
>> shortly
>>  > with the suspension bit set in order to cause a migration to primary
>>  > mode.
>>  >  > So, the only case when we are sure that a user-space thread can 
>> not be
>>  > scheduled by Linux seems to be when this thread does not have the
>>  > XNRELAX bit.
>>
>> From all the bits in XNTHREAD_BLOCK_BITS, only when the XNPEND bit is
>> set, a thread can not be running in secondary mode. Hence the proposed
>> patch.
>>
> 
> Almost ok, but XNDELAY might also be set alone, indicating a purely 
> timed wait state (i.e. without sync object to pend on, so XNPEND is off).
> 

Forget about this: XNDELAY might also be a transient bit like XNSUSP, so you are 
right, we cannot test it there.

>>
>>
>> ------------------------------------------------------------------------
>>
>> Index: ksrc/nucleus/shadow.c
>> ===================================================================
>> --- ksrc/nucleus/shadow.c    (revision 507)
>> +++ ksrc/nucleus/shadow.c    (working copy)
>> @@ -1543,14 +1543,25 @@
>>  
>>  #ifdef CONFIG_XENO_OPT_DEBUG
>>      {
>> -    xnflags_t status = threadin->status & ~XNRELAX;
>> +    xnflags_t status = threadin->status;
>>      int sigpending = signal_pending(next);
>>  
>> -        if (!(next->ptrace & PT_PTRACED) &&
>> +        if (!testbits(status, XNRELAX))
>> +            {
>> +            show_stack(xnthread_user_task(threadin),NULL);
>> +            xnpod_fatal("Hardened thread %s[%d] running in Linux 
>> domain?! (status=0x%lx, sig=%d, prev=%s[%d])",
>> +            threadin->name,
>> +            next->pid,
>> +            status,
>> +            sigpending,
>> +            prev->comm,
>> +            prev->pid);
>> +        }
>> +        else if (!(next->ptrace & PT_PTRACED) &&
>>          /* Allow ptraced threads to run shortly in order to
>>             properly recover from a stopped state. */
>>          testbits(status,XNSTARTED) &&
>> -        testbits(status,XNTHREAD_BLOCK_BITS))
>> +        testbits(status,XNPEND))
>>          {
>>          show_stack(xnthread_user_task(threadin),NULL);
>>              xnpod_fatal("blocked thread %s[%d] rescheduled?! 
>> (status=0x%lx, sig=%d, prev=%s[%d])",
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> 
> 
> 


-- 

Philippe.

