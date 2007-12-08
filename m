Message-ID: <475AD805.3000505@domain.hid>
Date: Sat, 08 Dec 2007 18:44:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4.0
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


Here is Xenomai v2.4.0. We are damn late on this one, so I'm going to
enter terse mode to save time: in short, this stable milestone aims at
more flexibility, increased portability, and lesser latency. This
serves the ultimate goal of making Xenomai the platform of choice for
migrating applications from traditional RTOS to Linux.

o Major nucleus updates:

	- massive refactoring of the timer sub-system.
	- introduce timebases at the core of the time-keeping code.
	- support for generic clock events (CONFIG_GENERIC_CLOCKEVENTS).
	- recognize RT-capable group for controlling access to the
          Xenomai core.
	- overhauled LTT support, rebased on the common trace marker
          infrastructure.
	- add synchronous I/O mode to message pipes (O_SYNC).
	
o Major architecture updates:

	- x86_64 port
	- powerpc: HAL sanitization; support for PA-SEMI's PA6T;
          integrated 32/64bit I-pipe support against 2.6.23/powerpc
          (i.e. CONFIG_PPC_MERGE); backported 32bit I-pipe support
          against 2.6.23/ppc.
	- ARM: AT91 support (armv4 and armv5); IXM21 upgrade; support
          for EABI.
	- blackfin: combined bf5xx support (bf533, bf537, bf561)
          against 2.6.23.
	- i386: massive HAL refactoring and sanitization; upgrade to
          2.6.23.

o Major skin-related work

	- posix: mq code reworked for efficiency; harden more
          clock-related services; add pthread_kill() syscall.
	- RTDM: add timer interface; provide automatic cleanup of open
	  file descriptors on process termination.
	- native: allow cross-API calls to blocking services;
          auto-cleanup support (reclaim orphan resources upon process
          exit); introduce I/O region descriptors to support
          user-space mapping of I/O-port and MMIO regions.
	- pSOS: expose tm_* calls to user-space; add convenience
          extensions.
	- rtai: Provide support for shared memory services.

o Driver updates

	- improved Linux Socket-CAN compatibility (CAN_RAW protocol);
          CAN filter inversion; add support for bus error interrupts.
        - 16550A: add support for MMIO accesses; provide control over
          break signal; add PnP awareness.

o Misc

	- rtdk: introduce a collection of utilities aimed at forming a
	  Real-Time Development Kit for userland usage. Starts with a
	  set of non-intrusive (latency-wise) *printf() services.

	- Bug fixes all over the map.


See the ChangeLog for details.

http://download.gna.org/xenomai/stable/xenomai-2.4.0.tar.bz2

-- 
Philippe.

