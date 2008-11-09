Message-ID: <49173086.6020206@domain.hid>
Date: Sun, 09 Nov 2008 19:48:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.6
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
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


Here is the sixth maintenance release for the v2.4.x branch.  Short
log follows:

	[nucleus]

	* Detect and use fixed ATOMICSWITCH support when available
          from the I-pipe layer.
	* Get highmem working with shared heaps.
	* Message pipes:
	  - fix handling of concurrent read/write sleep states on the
            same pipe.
	  - fix O_SYNC support.
	  - fix context unwinding upon signal receipt while reading.
	  - enable blocking write upon memory starvation.

	[native]

	* Fix spurious -EBUSY error upon queue and heap deletion
          calls.

	[posix]

	* Allow 64 bits offsets with mmap and ftruncate.

	[vrtx]

	* Fix TCB pointer indexing.

	[vxworks]

	* Add taskSetMode() extension.

	[rtdk]

	* Fix cleanup code.

	[can]

	* Iron socket deregistration code.
	* Fix mpc52xx/mscan build for kernels > 2.6.24

	[powerpc]

	* Fix vma protection bits to access physical memory via
          rtdm_iomap_to_user() (e.g. PCI resources).
	* Update Adeos support to 2.6.26-powerpc-2.2-07.

	[arm]

	* Provide VFP support.
	* Add support for MXC CPU family.
	* Provide TSC emulation for fast wrapping hardware timers.
	* Update Adeos support to 2.6.26-arm-1.11-02.

	[x86]

	* Update Adeos support to 2.6.26.7-x86-2.0-16,
          2.6.27-x86-2.1-01.

	[blackfin]

	* Update Adeos support to 2008R1-bf5xx-1.7-04.

See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.6.tar.bz2

-- 
Philippe.

