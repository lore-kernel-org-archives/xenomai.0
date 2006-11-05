From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 19:13:01 +0100
Message-Id: <1162750381.7285.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.3-rc1
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
To: xenomai@xenomai.org


Here is the first candidate release for the v2.3.x branch, which
should lead us to 2.3 final, after some iterations. A RTDM-compliant
CAN driver stack is likely the most significant addition to this
release, along with tons of local improvements and bugfixes all over
the map. Short (and non-exhaustive) log follows:

	[nucleus]

	* Introduce the aperiodic timer wheel as an alternative to
	binary heaps for efficiently handling a significant number of
	outstanding timers.

	* Don't send migration or deletion signals to dormant threads.

	* Check for wait abort in xnsynch_sleep_on(). Fully refactor
	the resource stealing feature.

	* Make sure xnsynch_flush() does not alter ownership.

	* Allow sharing the timer IRQ (basically for ARM).

	* Iron mode transition using the TASK_NOWAKEUP support
	whenever available from the I-pipe.

	* Optimize syscall propagation using the new PF_EVNOTIFY
	per-task filter.

	* Streamline nucleus SMP lock implementation.

	* Introduce generic support for runtime statistics (xnstat).

	* Refactor locking code in interrupt support. Improve
	shared interrupt code. Use generic support for runtime
	accounting.

	* Rework the watchdog support.

	[uvm]

	* Feature removed.

	[testsuite]

	* Add IRQ benchmark program.

	* Improve tests output.

	[scripts]

	* Fix modular build for 2.4.

	[hal]

	* x86: Prevent the 2.4 speaker support from perturbating
	Xenomai's TSC emulation code.

	* ppc: Port over 2.6.18.

	* arm: Upgrade Adeos support.

	[native]

	* Fix rt_queue_read() timeout.

	* Fix rt_queue_send() upon null broadcast (wrong reference
	count).

	[rtdm]

	* Enhance non-RT locking during /proc access.

	* Add rtdm_iomap_to_user() service.

	[posix]

	* Fix mutex attribute handling from user-space.

	* Properly handle cancellation requests in
	pthread_cond_wait().

	* Add the --enable-posix-auto-mlockall option to the main
	configure script.

	* Allow sched_yield() to pick secondary mode threads when
	SCHED_OTHER is in effect.

	* Make the timer management better conform to the
	POSIX spec.

	* Make pthread_join() callable from module init/cleanup
	routines.

	[drivers]

	* Refactor RTDM types for timeout and dates.

	* Add RT-Socket-CAN, a RTDM compliant driver for CAN devices.


As a sidenote, please note that this branch will be the first one to
support the latest Linux kernels (>= 2.6.18).

See the ChangeLog for details.

http://download.gna.org/xenomai/testing/xenomai-2.3-rc1.tar.bz2

-- 
Philippe.



