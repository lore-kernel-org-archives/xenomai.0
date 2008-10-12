Message-ID: <48F2118A.7010608@domain.hid>
Date: Sun, 12 Oct 2008 17:02:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Using SIGWINCH to trigger priority change.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Hi,

I am working on using SIGWINCH to trigger priority changes in
user-space. And I am afraid it will never really work:
- Xenomai makes a difference between the base priority of a thread and
its current priority. But pthread_getschedparam should return the base
priority, not the current priority, so, we need a way to change the
current priority of a thread without changing its base priority.
- I do not know at what time we should trigger a signal to the thread
whose priority is changing:
  . if we send it as soon as we return to user-space (at the same time
as when we handle LO_RENICE_REQ), if the thread whose priority is
changing is not the current one, we potentially trigger a
primary/secondary mode transition for this thread;
  . if we wait for the target thread to return to secondary mode (via
xnshadow_relax), any other thread in the same process which would read
the target thread priority with pthread_getschedparam would not see that
the priority has changed;
  . we could do it as soon as a thread of the same process returns to
secondary mode, but it looks complicated, and besides,
pthread_getschedparam can safely be called from primary mode, so we
still have the same issue as for the previous point.

This is where I stopped thinking about this idea.
Thanks in advance for any help.

-- 
					    Gilles.

