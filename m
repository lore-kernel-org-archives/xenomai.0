Message-ID: <48F34501.6040802@domain.hid>
Date: Mon, 13 Oct 2008 14:54:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F2118A.7010608@domain.hid>
In-Reply-To: <48F2118A.7010608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Using SIGWINCH to trigger priority change.
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> I am working on using SIGWINCH to trigger priority changes in
> user-space. And I am afraid it will never really work:
> - Xenomai makes a difference between the base priority of a thread and
> its current priority. But pthread_getschedparam should return the base
> priority, not the current priority, so, we need a way to change the
> current priority of a thread without changing its base priority.
> - I do not know at what time we should trigger a signal to the thread
> whose priority is changing:
>   . if we send it as soon as we return to user-space (at the same time
> as when we handle LO_RENICE_REQ), if the thread whose priority is
> changing is not the current one, we potentially trigger a
> primary/secondary mode transition for this thread;
>   . if we wait for the target thread to return to secondary mode (via
> xnshadow_relax), any other thread in the same process which would read
> the target thread priority with pthread_getschedparam would not see that
> the priority has changed;
>   . we could do it as soon as a thread of the same process returns to
> secondary mode, but it looks complicated, and besides,
> pthread_getschedparam can safely be called from primary mode, so we
> still have the same issue as for the previous point.
> 
> This is where I stopped thinking about this idea.
> Thanks in advance for any help.
> 

Please go ahead with your ongoing implementation. AFAICT from the latest
discussions, it is correct. The point is about how and when a change of thread
priority level should be visible, nothing else. This means that:

- we have to make sure that all Xenomai services will return the same priority
value for any given thread at any point in time, which may have been set by a
previous call to xnpod_renice_thread(), issued from whatever skin wrapper.

- we have to make sure that for any given thread whose priority is changed from
the Xenomai side, the glibc will reflect the priority change.

- BUT, we can't guarantee that a priority change affecting a Xenomai RT thread
that is done from _within_ the Xenomai realm, will be immediately visible from
_outside_ of that realm; this means that if pthread_setschedparam() from the
POSIX skin is used to change the priority of a RT thread, there is no guarantee
that a call to __real_pthread_getschedparam() will see the change _immediately_
after. However, pthread_getschedparam() from the POSIX skin will see that change
immediately. What we should guarantee though, is that a priority propagation
will take place asap, when the affected thread moves back to secondary mode, so
that our priority management remains logically correct. (*)

In short, we have two kernels, and only asynchronous ways of propagating the
changes between them, so there is no point in chasing wild gooses trying to have
immediate visibility in all cases.

(*) Btw, if you happen to export the current thread state via the shared heap to
userland for the fast mutexes, I guess that we could to use it as well to
implement a smarter pthread_setschedparam/rt_task_set_priority, doing something
like:

	if (in_secondary_mode(ptid))
		__real_pthread_setschedparam(...);
	else
		XENOMAI_SKINCALL(...);

When running in secondary mode, we should be able to rely on the automatic
propagation the nucleus does in do_setsched_event(), if the underlying priority
scale is POSIX-compatible, which will work for the native skin as well.

-- 
Philippe.

