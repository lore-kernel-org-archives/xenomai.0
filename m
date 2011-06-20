Message-ID: <4DFF8775.7080704@domain.hid>
Date: Mon, 20 Jun 2011 19:46:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid> <4DFDCBEA.6010905@domain.hid>
	<4DFDDAB8.4090709@domain.hid> <4DFDF2E1.1060106@domain.hid>
	<4DFF7E4A.3070807@domain.hid>
In-Reply-To: <4DFF7E4A.3070807@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/20/2011 07:07 PM, Jan Kiszka wrote:
>>  static inline void do_cleanup_event(struct mm_struct *mm)
>>  {
>> +	struct task_struct *p = current;
>> +	struct mm_struct *old;
>> +
>> +	old = xnshadow_mm(p);
>> +	xnshadow_mmptd(p) = mm;
>> +
>>  	ppd_remove_mm(mm, &detach_ppd);
>> +
>> +	xnshadow_mmptd(p) = old;
> 
> I don't have the full picture yet, but that feels racy: If the context
> over which we clean up that foreign mm is also using xnshadow_mmptd,
> other threads in that process may dislike this temporary change.

This mmptd is only used by xnshadow_ppd_get (which never dereferences it
by the way). And if the current thread is running the cleanup event, it
is not running any other service at the same time. So, this is safe.

An alternative implementation would be to use some global per-cpu
variable and disable the preemption during cleanup. But that would not
fix the case of the shadow cleanups where current->mm is already null.

The remaining problem is an irq interrupting the cleanup, and using
xnshadow_ppd_get. But I would not expect that to happen. I mean,
xnshadow_ppd_get is more a service to be used for implementation of
system calls.

>> diff --git a/ksrc/skins/posix/mutex.c b/ksrc/skins/posix/mutex.c
>> index 6ce75e5..cc86852 100644
>> --- a/ksrc/skins/posix/mutex.c
>> +++ b/ksrc/skins/posix/mutex.c
>> @@ -219,10 +219,6 @@ void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
>>  	xnlock_put_irqrestore(&nklock, s);
>>  
>>  #ifdef CONFIG_XENO_FASTSYNCH
>> -	/* We call xnheap_free even if the mutex is not pshared; when
>> -	   this function is called from pse51_mutexq_cleanup, the
>> -	   sem_heap is destroyed, or not the one to which the fastlock
>> -	   belongs, xnheap will simply return an error. */
> 
> I think this comment is not completely obsolete. It still applies /wrt
> shared/non-shared.

If we apply this patch after the one changing the ppd cleanup order,
everything falls in place (I can even put a warning in xnheap_destroy if
the heap has some bytes still in use when destroyed).

> If we can resolve that potential race, this looks like a nice solution.

It may look a bit overkill, since it uses an adeos ptd. On the other
hand, who else uses them anyway ;-)

-- 
                                                                Gilles.

