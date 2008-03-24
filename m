Message-ID: <47E7E096.4030306@domain.hid>
Date: Mon, 24 Mar 2008 18:10:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4.3
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


Here is the third maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* Do not terminate the entire process upon shadow deletion.
	* Assume a CPU migration may happen before xnshadow_start() is
	  issued for an emerging thread.
	* Backport synchronous I/O multiplexing support (e.g. select()
          for RTDM file descriptors).
	* Introduce private stack pool for kernel threads.

	[native]

	* Mark rt_task_delete() as a low stage call as required by the
          implementation.
	* Make sure pthread resources are claimed upon task
          self-deletion.
	* Fix severe issues in rt_cond_wait().

	[vxworks]

	* Add missing auto-cleanup support for message queues and
          semaphores.
	* Fix error path in taskSpawn().

	[posix]

	* Fix error path for mq_notify().
	* Add select() service.

	[rtdm]

	* Add support for monitoring multiple file descriptors
          synchronously.

	[x86]

	* Update Adeos support to 2.6.24-2.0-04.

	[arm]

	* Upgrade Adeos support to 2.6.24-1.9-01.

	[powerpc]

	* Assume that CPU_FTR_SPE may not exist in outdated kernels.
	* Do not scatter main heap memory over 128Kb anymore (allows
	  large system heap within a single contiguous address space).
	* Upgrade Adeos support to 2.6.20-1.7-13, 2.6.24-2.1-01.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.3.tar.bz2

-- 
Philippe.

