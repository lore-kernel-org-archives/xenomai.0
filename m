From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 19:25:34 +0200
Message-Id: <1157304334.5000.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2.2
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


Here is the second maintenance release for the v2.2.x branch.  Short
log follows:

	[nucleus]
	* Fix PI chain walk.
	* Fix priority update for threads sleeping on a resource by
	priority without undergoing PI.
	* Fix potential FPU corruption in rare thread initialization
	case.
	* Iron domain transition upon signal receipt.
	* Re-evaluate the timeout value as we iterate over the message
	acquisition.
	* Display thread period in /proc/xenomai/sched.

	[posix]
	* Read wrapping directives from a linker file.
	* Dedicate SCHED_OTHER to non-realtime shadow management.
	* Update timer services.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.2.2.tar.bz2

-- 
Philippe.



