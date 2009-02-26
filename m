Message-ID: <49A6A483.1050505@domain.hid>
Date: Thu, 26 Feb 2009 15:17:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.7
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
To: xenomai-core <xenomai@xenomai.org>, xenomai-help <xenomai@xenomai.org>


Here is the seventh maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* Fix multiple issues in the message pipe support (memory
          leak, latency peak, oops on disconnect).
	* Fix GDB support issue with shadow threads in ready state.
	* Fix missed rescheduling after sched unlock.
	* Fix auto-cleanup sequence of shared heaps.
	* Run start hook for shadow threads as well.

	[native]

	* Fix memory leak (rt_queue_write).
	* Fix auto-cleanup sequence of queues and shared heaps.

	[posix]

	* Check for mmap64/ftruncate64 availability (uClibc).

	[powerpc]

	* Fix race in timer request code.
	* Fix busy count in timer release code.
	* Fix early timer shots on PA-Semi.
	* Upgrade Adeos support to 2.6.28.5-powerpc-DENX-2.4-04.
	* Add support for the mpc5121-ads platform (2.6.24.6 based).

	[arm]

	* Fix race in timer request code.
	* Implement FCSE via Adeos 2.6.2{6,7,8}-arm-1.12-00 series.

	[x86]

	* Fix race in timer request code.
	* Fix FPU backup clobbering.
	* Upgrade Adeos support to 2.6.27.19-x86-2.2-06,
          2.6.28.7-x86-2.2-06.

	[blackfin]

	* Fix race in timer request code.
	* Do not force -mfdpic on user-space libraries.
	* Upgrade Adeos support to 2008R1.5-RC3-bf5xx-1.8-00,
	  2.6.28-blackfin.git-1.9-00.

	[testsuite]

	* Add stress mode to switchtest.
	* Fix restart issue in klatency (NOTE: local ABI breakage. The
          klatency binary will not work with klat modules from older
          releases, and conversely, klatency binaries from older
          releases won't work with the klat module available with
          2.4.7 and on).

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.7.tar.bz2

-- 
Philippe.

