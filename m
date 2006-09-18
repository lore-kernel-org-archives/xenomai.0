From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:28:50 +0200
Message-Id: <1158564530.5020.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2.3
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


Here is the third maintenance release for the v2.2.x branch.  Short
log follows:

	[nucleus]

	* Use per-task event filter implemented by recent Adeos
	patches, to reduce the overhead induced by event pipelining.

	* Support partial buffer reading from the message pipe device
	endpoint.

	* Fix spurious wakeup triggered by the periodic handler for
	threads blocked on a resource.

	* x86: Make sure to always restore the FPU context of the root
	thread consistently with the TS bit state.

	[hal]

	* Toggle IRQ_DISABLED appropriately when enabling/disabling an
	interrupt channel.

	[posix]

	* Make pthread_join() usable from module init/cleanup routines.

	[native]

	* Optimize data streaming mode.

	[rtai]

	* Improve compliance of rtf_get().

	* Fix memory leak in rtf_destroy().

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.2.3.tar.bz2

-- 
Philippe.



