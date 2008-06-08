Message-ID: <484C17E1.20808@domain.hid>
Date: Sun, 08 Jun 2008 19:33:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4.4
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
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


Here is the fourth maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* Prevent drifts between large calculated versus measured dates.
	* Fix potential deadlock on SMP when ptracing shadow threads.
	* Thaw timers when a ptraced shadow thread exits.
	* Fix race introduced by xnsynch ownership preemption.
	* Fix RPI update.
	* Fix priority propagation issue with mixed interfaces.
	* Fix compilation issues with uClibc.

	[native]

	* Output outstanding number of heap mappings from the registry.
	* Fix tiny memory leak for rt_task_self().
	* Ensure rt_task_suspend() returns -EINTR upon signal receipt.
	* Allow rt_task_sleep_until() to sleep indefinitely
          (TM_INFINITE).
	* Fix rt_task_send() in the non-blocking case (TM_NONBLOCK).
	* Documentation updates.

	[posix]

	* Fix pthread_cond_init(), pthread_mutex_init() for NULL
          attributes.
	* Restart silently upon EINTR error.
	* Fix signal handling when directed at shadow threads.
	* Fix recursion count of mutex after suspension on a condvar.

	[psos]

	* Fix calendar date to ticks conversion.
	* Return ERR_NOBUF when	required.
	* Fix system call number of tm_evevery service.

	[vxworks]

	* Make sem_give() a conforming syscall.
	* Make semaphore support callable from non-VxWorks tasks.
	* Rework mutex support.
	* Provide taskInfoGet() service.
	* Fix byte count in msgQReceive() wrapper.

	[powerpc]

	* Upgrade to kernel 2.6.25.
	* Add legacy ppc/ branch support to 2.6.20.

	[arm]

	* Upgrade to kernel 2.6.25.

	[blackfin]

	* Resync on 2008R1 (kernel 2.6.22). Add support for bf54x and
          bf52x.

	[x86]

	* Upgrade to kernel 2.6.25.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.4.tar.bz2

-- 
Philippe.


