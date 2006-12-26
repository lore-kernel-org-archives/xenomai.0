From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 26 Dec 2006 12:03:59 +0100
Message-Id: <1167131039.4148.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.3
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


Here is Xenomai v2.3. Five months work, 660 commits since v2.2 which
brought the following:

o RTDM-based CAN implementation.

o A lot of PowerPC work (major I-pipe upgrade to kernel 2.6.18).

o A lot of ARM work (I-pipe tracer, board support for the Samsung
S3C24xx series).

o A lot of Blackfin work (I-pipe tracer, major I-pipe upgrade to
kernel 2.6.18 for the BF53x boards).

o A lot of x86 work (major I-pipe upgrades to kernels 2.6.19 and
2.4.34).

o Direct syscall interface to the pSOS skin for running real-time
applications in regular user-space context.

o Nucleus updates in various areas (aperiodic timers management,
runtime accounting, software watchdog, message pipes, shared interrupt
support, debug infrastructure).

o Assorted bug fixes all over the map.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.3.0.tar.bz2

-- 
Philippe.



