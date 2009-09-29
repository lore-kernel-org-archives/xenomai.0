Message-ID: <4AC248FD.7050707@domain.hid>
Date: Tue, 29 Sep 2009 19:50:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RFC: primary mode signals design.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Hi,

During my flights and connections, I had a thought about this primary
mode signals issue.

Since the needs in term of primary mode signals greatly depends on what
the skins want to do with it (native wants hooks, posix wants posix
conformant signals), I think as much work as possible should be done in
the nucleus and skins implementation, not in the I-pipe (as usual). So,
I propose to:
1- add an I-pipe SIGNAL_PENDING event
2- add a bit somewhere in the task_struct or thread_info stuctures
indicating that signals are pending
3- add a service to mark the bit, like:
int ipipe_mark_signal_pending(struct task_struct *task);
4- in entry.S, when going back to user-space, test and clear the bit is
set, and if it was set, trigger the event
5- implement services allowing to run a callback with some cookie when
returning to user-space, we may also need to be able to push on stack
some arguments that should be passed to the callback, (we need this
service internally anyway to push the pt_regs structure on stack, so
that the calling context can be restored after execution of the
callback, and we need a little help from user-space for this
restoration, probably in bind.h).

6- The nucleus would then propose to register per-skin callbacks,
subscribe to the SIGNAL_PENDING event, and dispatch a pending signal to
all the skins which are currently expecting it. The skins would do the
callbacks housekeeping at their level.

The critical point is clearly point 5, and it is still a bit fuzzy. At
least, I think I know how I would do it on ARM, but I do not know how to
package the services in such a way that it would tolerate differences
between platform. It is unclear, for instance whether some or all
platforms may need an additional syscall to restore the original context
due to the need of running in privileged mode to restore some registers
value. Ok, now that I think about it, an additional syscall would be the
most portable way, but also a bit slow.

What do you think?

-- 
					    Gilles.

