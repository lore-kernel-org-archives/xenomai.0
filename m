MIME-Version: 1.0
Date: Thu, 13 Jun 2013 16:07:47 +0200
Message-ID: <CAONLcG02QkWuaC=HvZZAptTPN+8ga1JVw5XSQpr71vgaf2zi6A@mail.gmail.com>
From: Tom Philips <tom.philips1311@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] [xenomai-forge] psos interface: t_setpri keeps threadobj
 mutex locked
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

There seems to be a mutex problem when using psos call t_setpri()
There is one case where a threadobj_lock() is not matched with a
threadobj_unlock()

Here's the normal call sequence:
+++
t_setpri()
  get_psos_task_or_self()
    threadobj_lock()
  threadobj_set_priority()
    threadobj_unlock()
+++

But in threadobj_set_priority() (Mercury version), the case below has no
threadobj_unlock()
+++
  if (thobj->status & __THREAD_S_NOPREEMPT) {
    thobj->core.prio_unlocked = prio;
    thobj->core.policy_unlocked = prio ? SCHED_RT : SCHED_OTHER;
    /****** No threadobj_unlock() *****/
    return 0;
  }
+++

This causes other threads to hang on a threadobj_lock()

Regards,
Tom
