From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sat, 19 Aug 2006 18:17:55 +0200
Message-Id: <1156004275.4718.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2.1
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


Here is the first maintenance release for the v2.2.x branch.  Short
log follows:

	[x86, powerpc] Upgrade Adeos support.

	[nucleus] Fix resource stealing in synchronization management
	code.
	Ignore migration requests from threads blocked on the
	startup	barrier.
	Do not force migration upon dormant threads.

	[posix] Iron process cleanup code.
	Fix user-space mutex attribute handling.
	Fix cancellation request handling.
	Ensure child processes bind to the skin upon fork.

	[native] Fix rt_queue_read() argument handling when called
	from user-space.
	Do not send SIGKILL to dormant threads upon termination.

	[uvm] Mark as deprecated. Will be removed from v2.3.

	[irqbench] Fix 2.4 build.

Please see the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.2.1.tar.bz2

-- 
Philippe.



