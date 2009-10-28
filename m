From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Oct 2009 10:35:52 +0100
Message-ID: <1256722552.2065.84.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.5-rc4
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is 2.5-rc4. Most of the new stuff comes from the Analogy DAQ
framework which eventually made its way to 2.5. RTCAN support for
SJA1000 based PCI cards has been introduced as well. The rest is bug
fixing all over the place.

http://download.gna.org/xenomai/testing/xenomai-2.5-rc4.tar.bz2

--

Alexis Berlemont (73):
      analogy: add error messages for the IOCTL interface
      analogy: fix testing drivers' renaming issues
      analogy: some Comedi -> Analogy forgotten renamings
      analogy: add modules descriptions and license specifications
      analogy: fix comments
      Replace comedi_channel_* char-typed fields by unsigned long fields.
      Update indentation, add flags related macros
      Add missing flags for instructions
      Fix indentation
      Fix indentation
      Add range_unknown declaration
      Add Comedi PCIMIO drivers set
      Review the subdevice registration system: get closer from Comedi upstream
      Replace the first argument type: comedi_cxt_t becomes comedi_dev_t
      Change subdevice related callbacks: replace their first argument
      Apply driver API change on testing drivers
      Slightly optimize the function comedi_get_chan()
      Change the second argument of the callback do_cmd()
      Fix typing mistake in the driver fake.c
      Review the tracing macros, mimic v4l2's system
      Add the subdevice registration index into the subdevice structure
      Simplify the declaration of comedi_get_chan
      Simplify munge function declaration
      Remove comedi_get_nbchan(), a specific function which became useless
      Review trace macros
      Update 8255 driver
      Replace forgotten rtdm_printk() by comedi_err()
      Review traces
      Update NI TIO driver according to driver API changes
      Update NI MIO driver according to driver API changes
      Update NI PCIMIO driver according to driver API changes and fix a bug at the same time
      Minor indentation change in fake driver source
      Fix obvious bug in IRQ registering procedure
      Fix trivial compilation bug.
      Remove useless argument in the cancel callback
      Review comedi_get_cmd's arguments: the subdevice descriptor should be enough.
      Fix trace type (info -> err)
      Properly implement debug traces
      Fix minor initialization bugs
      Add more checks in chaninfo, rnginfo ioctls
      Add comedi_presetup_transfer() function to be called before attach procedure
      Add a fake range descriptor; Add basic checks in *_info ioctls
      Add fake range descriptor
      Add missing types flags into COMEDI_SUBD_TYPES
      Fix debug trace routines
      Fix MSeries_PLL_Enable_Bit wrong definition
      Add RTSI and clock precompilation constants
      Improve comedi_buf_evt(): remove ugly subdevice guessing based on flags.
      Apply modifications due to comedi_buf_evt() declaration change
      Add missing RTSI / clock configuration routines
      Improve comedi_buf_*put/get() interfaces
      COMEDI_BUF_PUT and COMEDI_BUF_GET became useless, so remove them.
      Minor change: remove useless comedi_device structure declaration
      Add some basic check in comedi_get_cmd()
      Remove useless wrappers (comedi_kmalloc, comedi_kfree)
      Remove useless wrappers (comedi_copy_*_user())
      Initialize the freshly allocated device's private area
      Fix obvious typo mistake
      Fix some error checkings in analog output command test function
      Fix various minor bugs
      Fix internal trigger via instruction
      Add ai / ao trigger callback
      Add a trigger instruction
      Replace an info message by an error message
      Fix a problem in the mite configuration (only for AI)
      Add a missing EXPORT_SYMBOL() comedi_alloc_subd.
      Align fake macro declarations with real functions declarations
      Fix modules compilations issues
      Comedi4RTDM -> Analogy (first part)
      Comedi4RTDM -> Analogy (second part)
      Comedi4RTDM -> Analogy (third part, kernel side compiles)
      Comedi4RTDM -> Analogy (last part, user side compiles and runs)
      Update *_alloc_subd() after bugfix backport from comedi branch

Breeje, R. (Remco) den (2):
      analogy: add a missing dependency for the NI MIO driver (NI TIO)
      analogy: fix received bytes storing in cmd_read

Gilles Chanteperdrix (2):
      build: provide front-end script to link static POSIX apps
      Do not use the 2 stages build for building non-posix applications

Jan Kiszka (12):
      rtipc: Fix 64-bit related warnings
      x86-hal: Include fix for NMI watchdog on 2.6.31
      POSIX: Fix error reporting of __real_accept
      librtdk: Mark __wrap_clock_gettime as weak symbol
      native: Release fastlock to the proper heap
      nucleus: xnheap_destroy does not fail
      native: Fix memory leak on heap/queue auto-deletion
      nucleus: Use Linux spin lock for heap list management
      nucleus: Fix race window in heap mapping procedure
      native: Avoid double release on queue/heap auto-cleanup
      nucleus: Avoid returning errors from xnheap_destroy_mapped
      rtai: Try to fix _shm_free

Oliver Schlenker (2):
      Fork-safe rt_print
      Syslog extension of rt_print

Patrice Kadionik (1):
      doc: add guidelines for nios2 build

Philippe Gerum (74):
      analogy: fix debug options dependencies
      rtdm: introduce device context <-> private area accessors
      rtdm: introduce RTIPC protocol family
      rtipc/iddp: retrieve IDDP_GETSTALLCOUNT via the getsockopt() interface
      rtipc: introduce proto_exit()
      rtipc/iddp: allow dynamic unbinding via NULL address
      rtipc/xddp: fix null address
      rtipc/xddp: catch null local pool size
      rtipc/xddp: fix context locking in sendmsg()
      rtipc: add __exit attribute to module_exit code
      rtipc/iddp: introduce local per-socket datagram pool
      rtipc: use standard SOL_SOCKET level operations for timeout settings
      rtipc/xddp: clear _XDDP_BINDING upon error in bind()
      rtipc/xddp: return -EAGAIN when trying to read from an unbound socket
      rtipc/iddp: introduce IDDP_SETLABEL
      rtipc: move code to get/put sockaddr_ipc structs to generic section
      rtipc: fix iddp/xddp context for _RTIOC_BIND
      rtipc/iddp: introduce port auto-selection
      rtipc/iddp: add missing private event init
      rtipc/iddp: remove tracepoint
      rtipc/iddp: clear registry handle at socket creation
      rtipc/iddp: handle close request in NRT mode when required
      rtipc/xddp: always handle close request in NRT mode
      rtipc/iddp: fix binding error path
      rtipc: allow kernel-based threads to send/recv datagrams
      rtipc: introduce rtipc_get_iov_flatlen()
      rtipc: disable deprecated close_rt handler for protocols
      rtipc: make RTIPC_IOV_MAX a common limit to all protocols
      nucleus: inline xnmap_fetch service
      nucleus: introduce xnmap_fetch_nocheck service
      rtipc/iddp: fix missing indirection
      rtipc/iddp: fix double-free introduced by recent bufd usage
      rtipc/iddp: remove redundant portmap array
      nucleus: introduce wait context for threads
      rtipc/iddp: fix comment
      native: check status of all bufd-driven copies
      rtipc: introduce BUFP protocol
      nucleus: have xnsynch_acquire/sleep_on return the relevant info bits
      native: use the info bits as returned by xnsynch_acquire/sleep_on
      native: introduce rt_queue_flush() service
      native: be conservative in rt_queue_flush()
      rtipc: fix potential access race to remote socket
      x86: upgrade I-pipe support to 2.6.31-x86-2.4-05
      blackfin: do not over-protect lsys_arch code
      nucleus: start fixing misnomer between clock vs CPU frequency
      timeconv: time converters must have weak linkage
      nucleus: introduce arch-dep extension of the feature set
      nios2: introduce architecture support
      build: introduce CONFIG_XENO_DEFAULT_PERIOD
      nucleus: fix scheduler class init w/ XENO_OPT_NUCLEUS=m
      rtdm: silence warnings w/ XENO_OPT_RTDM_SELECT=n
      scripts: install wrap-link.sh
      scripts: allow concurrent invocations of wrap-link.sh
      x86: fix 64bit build for SMP kernels < 2.6.31
      x86: upgrade I-pipe support to 2.6.30.8-x86-2.4-06, 2.6.31.1-x86-2.4-06
      testsuite: handle platforms with userland-only FPU support
      posix: disable debug by default
      powerpc: upgrade I-pipe support to 2.6.30.3-powerpc-2.7-01
      powerpc: fix commit number for 2.6.30.3-DENX
      powerpc: upgrade I-pipe support to 2.6.30.3-powerpc-2.7-02
      powerpc: upgrade I-pipe support to 2.6.30.3-powerpc-2.7-02
      powerpc: upgrade legacy I-pipe support to 2.6.20-powerpc-1.9-03
      nios2: fix documentation for hwdesign v3
      nios2: upgrade I-pipe support to 2.6.26-rc6-nios2-1.1-00
      blackfin: downgrade to non-atomic bitop when applicable
      blackfin: provide atomic set/clear_mask bitops
      blackfin: introduce MPU support
      blackfin: upgrade I-pipe support to 2.6.31.2-1.12-00
      doc: fix Alex's data
      blackfin: initialize active task pointer for CONFIG_MPU
      nucleus: remove debug noise
      doc: rebuild documentation
      build: update version stamp
      arm: introduce support for freerunning countdown TSC

Sebastian Smolorz (1):
      can: add support for SJA1000 based PCI CAN interface cards from ESD GmbH

Stephen Sinclair (1):
      Copy the udev rules into rules.d if it exists.

Wolfgang Mauerer (3):
      Fix handling of deleted message queue objects
      Make marker string for faults less ambiguous
      Document -EWOULDBLOCK for rtdm_event_wait


-- 
Philippe.



