MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18508.6580.612681.20967@domain.hid>
Date: Sun, 8 Jun 2008 19:41:08 +0200
In-Reply-To: <484C17E1.20808@domain.hid>
References: <484C17E1.20808@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Xenomai v2.4.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > 
 > Here is the fourth maintenance release for the v2.4.x branch.  Short
 > log follows:
 > 
 > 	[nucleus]
 > 
 > 	* Prevent drifts between large calculated versus measured dates.
 > 	* Fix potential deadlock on SMP when ptracing shadow threads.
 > 	* Thaw timers when a ptraced shadow thread exits.
 > 	* Fix race introduced by xnsynch ownership preemption.
 > 	* Fix RPI update.
 > 	* Fix priority propagation issue with mixed interfaces.
 > 	* Fix compilation issues with uClibc.
 > 
 > 	[native]
 > 
 > 	* Output outstanding number of heap mappings from the registry.
 > 	* Fix tiny memory leak for rt_task_self().
 > 	* Ensure rt_task_suspend() returns -EINTR upon signal receipt.
 > 	* Allow rt_task_sleep_until() to sleep indefinitely
 >           (TM_INFINITE).
 > 	* Fix rt_task_send() in the non-blocking case (TM_NONBLOCK).
 > 	* Documentation updates.
 > 
 > 	[posix]
 > 
 > 	* Fix pthread_cond_init(), pthread_mutex_init() for NULL
 >           attributes.
 > 	* Restart silently upon EINTR error.
 > 	* Fix signal handling when directed at shadow threads.
 > 	* Fix recursion count of mutex after suspension on a condvar.
 > 
 > 	[psos]
 > 
 > 	* Fix calendar date to ticks conversion.
 > 	* Return ERR_NOBUF when	required.
 > 	* Fix system call number of tm_evevery service.
 > 
 > 	[vxworks]
 > 
 > 	* Make sem_give() a conforming syscall.
 > 	* Make semaphore support callable from non-VxWorks tasks.
 > 	* Rework mutex support.
 > 	* Provide taskInfoGet() service.
 > 	* Fix byte count in msgQReceive() wrapper.
 > 
 > 	[powerpc]
 > 
 > 	* Upgrade to kernel 2.6.25.
 > 	* Add legacy ppc/ branch support to 2.6.20.
 > 
 > 	[arm]
 > 
 > 	* Upgrade to kernel 2.6.25.

A special note for Roland: the configure script now allows configuring
Xenomai on ARM for a "generic" machine, which should be suitable for
generating Debian packages for ARM.

-- 


					    Gilles.

