Message-ID: <49A40219.1020305@domain.hid>
Date: Tue, 24 Feb 2009 15:20:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49A3F793.3010204@domain.hid> <49A3FB6E.2090509@domain.hid>
	<49A3FCD4.90900@domain.hid> <49A3FF9E.5000206@domain.hid>
In-Reply-To: <49A3FF9E.5000206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix gatekeeper affinity
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> As the xnsched structures get initialized later, during xnpod_init,
>>>> xnsched_cpu always returned 0 in the gatekeeper_thread prologue. That
>>>> caused binding of all gatekeepers to CPU 0.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>> ---
>>>>
>>>>  ksrc/nucleus/shadow.c |    5 ++++-
>>>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>> index 1dedd85..2243c0e 100644
>>>> --- a/ksrc/nucleus/shadow.c
>>>> +++ b/ksrc/nucleus/shadow.c
>>>> @@ -823,11 +823,14 @@ static int gatekeeper_thread(void *data)
>>>>  	struct task_struct *this_task = current;
>>>>  	DECLARE_WAITQUEUE(wait, this_task);
>>>>  	struct xnsched *sched = data;
>>>> -	int cpu = xnsched_cpu(sched);
>>>>  	struct xnthread *target;
>>>>  	cpumask_t cpumask;
>>>> +	int cpu;
>>>>  	spl_t s;
>>>>  
>>>> +	/* sched not fully initialized, xnsched_cpu does not work yet */
>>>> +	cpu = sched - nkpod_struct.sched;
>>>> +
>>>>  	this_task->flags |= PF_NOFREEZE;
>>>>  	sigfillset(&this_task->blocked);
>>>>  	cpumask = cpumask_of_cpu(cpu);
>>> This does not look good, it means that the gatekeeper accesses the sched
>>> structure before it is initialized. So, IMO, the proper fix would be to
>>> start the gatekeepers only after the sched structure has been initialized.
>>>
>> I briefly thought about moving xnshadow_mount into xnpod_init. But given
>> the fact that it worked like this before and that I was not able to
>> quickly exclude new regressions when reordering things, I decided to
>> restore the old pattern.
> 
> Ok. What about passing cpu as the gatekeeper argument, and using
> xnpod_sched_slot(cpu) to find the sched pointer ?
> 

Something like this? Same result, but looks indeed a bit nicer.

----------->

As the xnsched structures get initialized later, during xnpod_init,
xnsched_cpu always returned 0 in the gatekeeper_thread prologue. That
caused binding of all gatekeepers to CPU 0.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 1dedd85..6822fcb 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -822,8 +822,8 @@ static int gatekeeper_thread(void *data)
 {
 	struct task_struct *this_task = current;
 	DECLARE_WAITQUEUE(wait, this_task);
-	struct xnsched *sched = data;
-	int cpu = xnsched_cpu(sched);
+	int cpu = (long)data;
+	struct xnsched *sched = xnpod_sched_slot(cpu);
 	struct xnthread *target;
 	cpumask_t cpumask;
 	spl_t s;
@@ -2600,8 +2600,8 @@ int xnshadow_mount(void)
 		sema_init(&sched->gksync, 0);
 		xnarch_memory_barrier();
 		sched->gatekeeper =
-		    kthread_create(&gatekeeper_thread, sched, "gatekeeper/%d",
-				   cpu);
+		    kthread_create(&gatekeeper_thread, (void *)(long)cpu,
+				   "gatekeeper/%d", cpu);
 		wake_up_process(sched->gatekeeper);
 		down(&sched->gksync);
 	}

