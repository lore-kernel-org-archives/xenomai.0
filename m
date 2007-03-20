From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 20 Mar 2007 09:39:10 +0100
Message-Id: <1174379951.5068.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.3.1
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


Here is the first maintenance release for the v2.3.x branch.  Short
log follows:

	[nucleus]
	* Use ondemand-mapping disable feature if present (I-pipe).
	* Allow creation of anonymous interrupt objects from kernel
	  space.
	* Allow sleeping scheduler lock.
	* Fully rework priority tracking between schedulers (RPI).
	* Provide for non-restartable syscalls upon signal receipt.
	* Fix timer indexing in binary heap mode (timeout lossage).
	* Fix synchronization issues regarding interrupt objects while
	  reading /proc/xenomai/stat.
	* Synchronize message pipe reading and streaming operations.

	[psos]
	* Add timer-related calls to the user-space interface.
	* Fix ev_receive().
	* Combine supervisor and user stack sizes in t_create().

	[native]
	* Fix rt_queue_delete(), rt_queue_unbind(), rt_heap_delete().
	* Fix rt_cond_wait() upon signal receipt (grab mutex anew).

	[posix]
	* Fix pthread_cond_wait() upon signal receipt (grab mutex
	  anew).

	[rtai]
	* Fix rt_task_make_periodic().

	[rtdm]
	* Support in-place re-initialisation of IPC objects.

	[can]
	* Fix delays in periodic mode.
	* Implement either-or filtering of standard vs. extended frames.
	* Stop device before unregistering it.

	[arm]
	* Add support for Atmel AT91-based platforms.
	* Update support for IMX21 platforms.
	* Upgrade 2.6.14 and 2.6.15 support to I-pipe 1.5 series.
	* Upgrade to kernel 2.6.19 (I-pipe 1.6 series).
	* Add support for GCC 4.1.

	[powerpc]
	* Upgrade to kernel 2.6.19.

	[i386]
	* Use regular IPI support code to broadcast the timer IRQ.
	* Upgrade to kernel 2.6.20.


See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.3.1.tar.bz2

-- 
Philippe.



