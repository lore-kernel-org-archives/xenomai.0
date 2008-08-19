Message-ID: <48AB36EF.1020000@domain.hid>
Date: Tue, 19 Aug 2008 23:11:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.5
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


Here is the fifth maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* xnpipe_poll: fix race (message pipe poll/select support).
	* Fix memory overwrite when reading /proc/xenomai/stat.
	* xnsleep_sleep_on: fix early timeouts (ownership preemption).
	* request_syscall_restart: send SIGXCPU for interrupted
          syscalls as well.
	* Fix type used for stat counters.

	[native]

	* rt_heap_delete, rt_queue_delete: Fix -EBUSY case.

	[psos]

	* tm_get: Fix ticks to date conversion.
	* t_mode: Fix update mask.
	* pt_create: Fix 64bit issue. Fix memory overwrite.

	[vxworks]

	* errnoOfTaskGet/Set(): get/set the per-task errno value (as
          expected).

	[powerpc]

	* Upgrade to kernel 2.6.26.
	* Add support for MPC836x.

	[arm]

	* Upgrade to kernel 2.6.26.

	[x86]

	* Upgrade to kernel 2.6.26.

	[can]

	* Fix conflict with 2.6.26 kernels ("can_clock" module
          parameter).

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.5.tar.bz2

-- 
Philippe.

