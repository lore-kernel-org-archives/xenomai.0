Message-ID: <4E57E7FD.2050809@domain.hid>
Date: Fri, 26 Aug 2011 20:37:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E5792CE.8080307@domain.hid> <4E579A32.8040208@domain.hid>
	<4E57E0C4.8070600@domain.hid> <4E57E3A9.2000400@domain.hid>
In-Reply-To: <4E57E3A9.2000400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai 2.6.0, or -rc1?
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

On 08/26/2011 08:19 PM, Jan Kiszka wrote:
> On 2011-08-26 20:07, Gilles Chanteperdrix wrote:
>> On 08/26/2011 03:05 PM, Jan Kiszka wrote:
>>> On 2011-08-26 14:34, Gilles Chanteperdrix wrote:
>>>>
>>>> Hi,
>>>>
>>>> I think it is about time we release Xenomai 2.6.0. Has anyone anything
>>>> pending (maybe Alex)? Should we release an -rc first?
>>>
>>> No patches ATM, but [1] is still an open bug - a bug that affects the ABI.
>>>
>>> Jan
>>>
>>> [1] http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/8343
>>>
>>
>> I had forgotten about this one. So, the only real problem is if a
>> SCHED_NOTOTHER thread switches to SCHED_OTHER, this appears to be a
>> corner case, so, I wonder if you should not simply add a special
>> treatment, only for this corner case.
>>
>> What I have in mind is keeping a list of xnsynch in kernel-space (this
>> basically means having an xnholder_t more in the xnsynch structure), and
>> when we trip the corner case (thread with SCHED_FIFO switches to
>> SCHED_OTHER), walk the list to find how many xnsynch the thread is the
>> owner, we have that info in kernel-space, and set the refcnt accordingly.
>>
>> Or does it still sound overkill?
>>
> 
> Mmh, need to think about it. Yeah, we do not support
> PTHREAD_MUTEX_INITIALIZER, so we do not share that part of the problem
> with futexes.

Actually, we could implement PTHREAD_MUTEX_INITIALIZER: when the magic
is wrong, just issue a pthread_mutex_init syscall, and try locking
again. But the problem is that this particular call to
pthread_mutex_lock would be much heavier than locking an initialized
mutex for reasons which are not obvious (besides, we would have to
handle concurrency by some way, like having a pthread_once_t in
pthread_mutex_t). I find not having PTHREAD_MUTEX_INITIALIZER more
clear, even if this makes us not really posix compliant.

> 
> If we have all objects and can explore ownership, we can also implement
> robust mutexes this way, i.e. waiter signaling when the owner dies.
> 
> Jan
> 


-- 
                                                                Gilles.

