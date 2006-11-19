From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 20:16:39 +0100
Message-Id: <1163963799.5006.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.3-rc2
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


Here is the second candidate release for the v2.3.x branch.
Short log follows:

	[hal]

	* ppc, arm: Make sure to return the last "current" value from
	Xenomai context switch routines.

	* x86: Handle issues raised by hidden uses of the FPU from
	regular Linux drivers.

	[nucleus]

	* Account for all extents when reporting the total heap size.

	* Serialize export/unexport requests properly in case of
	varying source domains.

	* Fix interrupt shield support.

	* Fix random softlockup on SMP due to a missing rescheduling
	call after a task exit event has been processed.

	[scripts]

	* Add help strings extraction tool to provide on-line
	documentation of 2.4 kernel options.

	* Switch to FDPIC library format for Blackfin instead of FLAT.

	[drivers]

	* rtcan: sja1000 fixes.

	[vrtx]

	* Fix init code regarding workspace allocation.

	* Fix exec mode bits for sc_tsuspend() and sc_tresume().

	* Use delayed memory release service to free TCBs.

	[vxworks]

	* Set auto-delete flag for user-space tasks.

	[psos+]

	* Preliminary user-space support merged.

----

See the ChangeLog for details.

http://download.gna.org/xenomai/testing/xenomai-2.3-rc2.tar.bz2

-- 
Philippe.



