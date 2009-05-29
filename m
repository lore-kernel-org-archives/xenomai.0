From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Fri, 29 May 2009 18:56:18 +0200
Message-Id: <1243616178.27443.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.8
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is the eighth maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* Suppress switch warning upon signal receipt when the process
	is being debugged.
	* Fix host tick propagation.
	* Prevent early timer shots due to rounding imprecision.
	* Fix computation of heap overhead.
	* Move xnarch_set_irq_affinity out of intr lock.
	* Introduce channel information in LTTng markers.

	[posix]

	* Fix access checks in select().
	* Fix errnoneous -EINVAL error return with mmap() of non
          page-aligned length.

	[native]

	* Fix message pipe streaming mode.
	* Make optimized tsc<->ns conversion routines available to
          user-space.

	[vxworks]

	* Add missing rescheduling in semaphore deletion code.

	[vrtx]

	* Fix sc_[e]tcreate().
	* Rework mutex support.

	[powerpc]

	* Do not restore ALTIVEC/SPE regs for kernel threads.
	* Port to Emerson's MVME7100 dual core SBC.
	* Upgrade Adeos support to 2.6.29.4-powerpc-DENX-2.6-00.

	[arm]

	* Upgrade Adeos support to 2.6.29-arm-1.13-00.

	[x86]

	* Fix miscompilation of __do_strncpy_from_user().
	* Yet another round of FPU management fixes.
	* Upgrade Adeos support to 2.6.29.4-x86-2.4-01.

	[blackfin]

	* Upgrade Adeos support to 2.6.28.10-blackfin.git-1.10-00.

	[can]

	* ixxat-pci: fix problems with device probing.
	* ixxat-pci: disambiguate PCI device id.
	* mscan: fix build problems with recent kernel versions.


http://download.gna.org/xenomai/stable/xenomai-2.4.8.tar.bz2

git://xenomai.org/xenomai-2.4.git

-- 
Philippe.



