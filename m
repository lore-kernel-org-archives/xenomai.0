Message-ID: <b647ffbd0705140242oeb8bbfah5ab6b21a41d9ef05@domain.hid>
Date: Mon, 14 May 2007 11:42:24 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Scheduler: Strange priority handling with
	multiple tasks waiting for one semaphore
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
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

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

That's how our semaphores work indeed. It has nothing to do with the scheduler.

First of all, note that a semaphore doesn't support PIP (Priority
Inheritance Protocol). It would be not that straightforward to
implement as a semaphore basically has a few "owners". So we don't
track who "owns" a semaphore at the moment as we do for a mutex.
Hence, "resource stealing" is not possible.

The later works for a mutex. We always know an owner in this case and
can steal a resource in case the owner has been scheduled (1) but
doesn't get a CPU yet (2) and in the mean time (between (1) and (2)) a
high-priority task gets control and asks for a mutex (if (2) is not
met, we would do priority boosting for an owner).

rt_sem_v() just wakes up a waiter. If one is available, it doesn't
increase an internal counter (which tracks how many tasks can get a
semaphore) -> aside of this fact, we don't know who "owns" a
semaphore.

Now when a high priority task asks for it again immediately (here we
are in the situation (1)-(2) I described above), we only know it's
busy - we don't know any "owners" -> can't steal it. That's it.

Maybe you can use a mutex in your program (in case a counter of your
semaphore is 1 anyway) and lock sections are not long, time-wise?


-- 
Best regards,
Dmitry Adamushko

