From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 19:09:54 +0100
Message-Id: <1162750194.7285.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2.5
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


Here is the fifth maintenance release for the v2.2.x branch.  Short
log follows:

	[nucleus]

	* Fix period validity check when setting up the timer for
	periodic timing mode.

	[hal]

	* ppc: Define special wrappers to get/put_user macros which
	bypass the might_sleep() checks. Upgrade Adeos support.

	* x86: Upgrade Adeos support.

	* arm: Upgrade Adeos support.

	[native]

	* Fix rt_queue_send() upon null broadcast (wrong reference
	count).

	[posix]

	* Make sure to read interrupt-related macros from the core
	headers when including posix/pthread.h from user-space.


See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2


-- 
Philippe.



