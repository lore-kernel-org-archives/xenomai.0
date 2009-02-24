Message-ID: <49A40BFA.1010701@domain.hid>
Date: Tue, 24 Feb 2009 16:02:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49A3F793.3010204@domain.hid> <49A3FB6E.2090509@domain.hid>
In-Reply-To: <49A3FB6E.2090509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix gatekeeper affinity
Reply-To: rpm@xenomai.org
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> As the xnsched structures get initialized later, during xnpod_init,
>> xnsched_cpu always returned 0 in the gatekeeper_thread prologue. That
>> caused binding of all gatekeepers to CPU 0.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>
>>  ksrc/nucleus/shadow.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index 1dedd85..2243c0e 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -823,11 +823,14 @@ static int gatekeeper_thread(void *data)
>>  	struct task_struct *this_task = current;
>>  	DECLARE_WAITQUEUE(wait, this_task);
>>  	struct xnsched *sched = data;
>> -	int cpu = xnsched_cpu(sched);
>>  	struct xnthread *target;
>>  	cpumask_t cpumask;
>> +	int cpu;
>>  	spl_t s;
>>  
>> +	/* sched not fully initialized, xnsched_cpu does not work yet */
>> +	cpu = sched - nkpod_struct.sched;
>> +
>>  	this_task->flags |= PF_NOFREEZE;
>>  	sigfillset(&this_task->blocked);
>>  	cpumask = cpumask_of_cpu(cpu);
> 
> This does not look good, it means that the gatekeeper accesses the sched
> structure before it is initialized.

Fortunately, no, this can't be. The gatekeeper only refers to the semaphore and
the sync barrier and only that. Since the semaphore is initialized when the gk
starts, the gk sets up the barrier on entry, and the barrier can't be signaled
until the nucleus has fully initialized in xnpod_init(), we used to be safe.

 So, IMO, the proper fix would be to
> start the gatekeepers only after the sched structure has been initialized.
> 

-- 
Philippe.

