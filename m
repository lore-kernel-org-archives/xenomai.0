From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 15:05:28 +0200
Message-Id: <1153227929.5029.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2
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


Here is v2.2, basically aiming at higher performances and better Linux
integration compared to the previous series. The major issues we have
been working on for this release are:

o Latency reduction, thanks to a combined work on the I-pipe support
and fast paths of the real-time core. To leverage that, you will need
to upgrade to recent Adeos releases, which provide pipeline head
optimizations.

o Direct syscall interfaces to the VxWorks and VRTX skins are now
available. In other words, it is now possible to run VxWorks and VRTX
applications in user-space context, without resorting to the UVM
machinery (which remains available, though).

o The testsuite has been extended with new tests and benchmarks.

o The POSIX, RTDM and native skin have been significantly updated.
POSIX-wise, this also means that we are getting close to the 1003.1b
specifications, fully delivered in primary execution mode.

o The Adeos support has been upgraded for all architectures.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.2.0.tar.bz2

-- 
Philippe.



