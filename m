From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
References: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 14 May 2007 12:00:52 +0200
Message-Id: <1179136852.5045.76.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Scheduler: Strange priority handling
	with	multiple tasks waiting for one semaphore
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-05-14 at 10:40 +0200, M. Koehrer wrote:
> Hi everybody,
> 
> I see strange effect that I do not understand.
> What happens when multiple tasks (with different priority) are waiting for a single semaphore?
> Assume the following situation:
> Task H (High prio) and Task L (low prio) are waiting both for the same semaphore.
> A third task does the rt_sem_v() to grant access.
> Now H passes its rt_sem_p() and runs. 
> A few statements later H calls rt_sem_v() to grant access to the semaphore protected part.
> What happens now? As H is high priority there should be no reschedule, i.e. H continues to run.
> What happens now if H wants to enter again via rt_sem_p() (on the same semaphore)?
> I expect to allow H again the access as it has a higher priority than L.
> However, a small demo application for this use case shows me that this not the case.
> The heart of my demo application is the following task code fragment:
> 
> void mytask(void *cookie)
> {
>     int id = (int)cookie;
>     int cnt = 0;
> 
>     while (!end)
>     {
>         rt_sem_p(&sem, TM_INFINITE);
>         (....)
>         rt_sem_v(&sem);
>     }
> 
>     printf("task %i: cnt %i\n", id, cnt);
> }
> There are two tasks with different priorities that execute this code.
> I expected to have only the higher priority task to be run, however they run alternately.
> What is happening here? It looks as if the Xenomai scheduler does not handle the priority 
> correctly in this case.

Note: when problems of that sort arises, this is almost _never_ a
scheduler issue; a priority fixed FIFO scheduler is damned stupid piece
of code actually (ok, I know how to be really stupid too, but still, the
argument stands...). Strangenesses, if any, are usually caused by some
synchronization objects implementation that would misbehave blatantly,
so in this case, the culprit would have been the native sema4
implementation, and not the scheduler that just applies the decisions of
the latter.

> I have enclosed the C code of this application to this mail.
> 

T0: H grabs sem
T1: H releases sem, depletes it and wakes up L atomically
T2: H goes sleeping on the depleted sem
T3: L runs
T4: L releases sem, depletes it and wakes up H atomically
T5: H preempts L and runs
goto T1

The point is that semaphores have no ownership, e.g. once H transfers
the sema4 resource to L, it can't steal it back while L is sleeping like
we actually do for mutexes (who do maintain the notion of ownership),
because it just have no mean to know who owns the resource it has
released after returning from the sem_release call. Therefore, L must
run and release the sema4 before H has a chance to get back in control.
If you try with a mutex, you should see another behaviour.

To sum up, I see no issue. Did I miss your point?

> Thanks for any feedback on this.
> 
> Regards
> 
> Mathias
> 
> 
> 
> -- 
> Mathias Koehrer
> mathias_koehrer@domain.hid
> 
> 
> Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
> ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: günstig
> und schnell mit DSL - das All-Inclusive-Paket für clevere Doppel-Sparer,
> nur  39,85 €  inkl. DSL- und ISDN-Grundgebühr!
> http://www.arcor.de/rd/emf-dsl-2
> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



