Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608120333j7cd4ef35q7ed00bafab35753d@domain.hid>
References: <44D7EDCF.9010409@domain.hid> <44D90C41.5070307@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<1155247988.4297.52.camel@domain.hid>
	<b647ffbd0608120333j7cd4ef35q7ed00bafab35753d@domain.hid>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 23:14:12 +0200
Message-Id: <1155417252.4381.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sat, 2006-08-12 at 12:33 +0200, Dmitry Adamushko wrote:
>         
>         The problem is triggered by synch->owner being cleared in
>         xnsynch_flush(), as a result of the receiver task to exit
>         (called from 
>         the native task deletion hook, i.e.
>         xnsynch_destroy(&task->msendq)). 
>  
>  
> As I understood it didn't work in all cases and not only when a
> receiver exits. What's wrong with the case Jan revealed?
>  
> I mean rt_task_reply() makes use of a direct call to
> xnpod_resume_thread() to avoid a change of the owner while a sender
> finds itself being woken up in xnsynch_sleep_on() - the PRIO + PIP
> branch - and the first thing it does is a check for (synch->owner !=
> thread) and it's obviously that the sender is not the owner (but the
> receiver).
> 
> No?

Yes, but there is even more than this, which will require some fixing.

There is a design issue regarding how we deal with the lifetime of the
RT_TASK::msendq member: if the embodying task (i.e. the server task)
exits after the client task has been replied to, but before such task
has had a chance to return from xnsynch_sleep_on(), then the latter
routine would use a _destroyed_ synch. object inside the return path.

Due to the object stealing feature, xnsynch_sleep_on() now relies on the
assumption that the pended synch object still exists upon return from
xnpod_suspend_thread(), and this is really, really bad. The only thing
that may be accessed safely on this return path is the resuming thread's
control block itself (obviously), and _not_ what it was pending on. It's
the caller's business to find out whether the awaited resource is still
usable, but the nucleus should not rely on this assumption, given that a
rescheduling is likely to have taken place in xnsynch_sleep_on(), and
lots of things might have happended since then which are way outside of
its knowledge.

IOW, a construct like "if (synch-> ...." when returning from suspension
is the root of all evil. We must not depend on anything requiring such
dereference when resuming the thread. A way to fix this would be to
introduce a new thread status flag which gets raised whenever some
object ownership is stolen, so that we would not have to inspect the
synch object anymore to know about such situation, and rely on
potentially wrong information from the ->owner field. We would only have
to inspect the status flags of the thread that got "robbed" (i.e. the
one that resumes) and act accordingly. I will post a patch implementing
this, after I have solved all the related issues.

PS: note that in the particular case of the message passing services,
object stealing cannot happen, since we never call synch wakeup services
that transfer ownership but rather resume the thread bluntly, so the
PENDING bit never gets raised, thus preventing any stealing.

> 
>  
> > --
> >
> > Philippe.
>  
> -- 
> Best regards,
> Dmitry Adamushko 
-- 
Philippe.



