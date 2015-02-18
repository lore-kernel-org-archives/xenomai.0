Message-ID: <54E46905.10904@xenomai.org>
Date: Wed, 18 Feb 2015 11:27:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <Xenomai@xenomai.org>


This candidate release is mainly about integrating the RTnet stack,
adapted to the latest RTDM kernel interface, in addition to a few Cobalt
and Copperplate updates.

We need a few fixups on RTnet, and upgrading the Cobalt pipeline to
kernel 3.18, which should close this candidate release cycle.

http://download.gna.org/xenomai/testing/latest/

Short log follows:

Anders Blomdell (1):
      drivers/rtnet: add support for SIOCGIFNAME ioctl

Gilles Chanteperdrix (24):
      cobalt/arm: fixup for kernel 3.16
      cobalt/intr: fix first enable
      cobalt/autotune: add options to ease autotuning at boot
      cobalt/rtdm: rebase rtdm_nrtsig on ipipe_post_work_root
      cobalt/rtdm: add rtdm_schedule_nrt_work service
      rtnet: import
      rtnet: Adapt to RTDM API changes
      rtnet: use callbacks for locking (rtpacket_type)
      rtnet: rtskb_pool changes
      rtnet: EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
      rtnet: rtskb_pool changes (2)
      rtnet: remove now useless macros
      rtnet: convert /proc output to vfile
      rtnet: sanitize CONFIG_ symbols
      rtnet: reduce the compat cruft
      rtnet: Kconfig fixes
      rtnet: compile and install tools
      rtnet/arp: do not answer ARP requests only when rtnetproxy is loaded
      rtnet: update r8169 driver
      rtnet: update 8139too driver
      rtnet: add more netdev compatibility functions
      rtnet: update macb driver
      rtnet: update at91_ether driver
      rtnet: move documentation under kernel/drivers/net

Huy Cong Vu (3):
      rtnet/af_packet: fix module loading
      rtnet/e100e: update e1000e driver for Intel i217/i218
      rtnet/af_packet: fix device refcounting

Jan Kiszka (25):
      drivers/udd: Fix modular build
      lib/copperplate: Use single source for default registry path
      alchemy/pipe: Use required CURRENT_IMPL wrapping on rt_pipe_create
      build: Remove arch patching from Kconfig.frag
      cobalt/rtdm: Fix tracing of failed fd operation
      cobalt/pipe: Avoid running init_waitqueue_head under xnlock
      smokey/sigdebug: Port from 2.6
      cobalt/thread: Fix signaling of SIGDEBUG_LOCK_BREAK
      smokey/rtdm: Wait longer on deferred close
      sysregd: Fix --linger support
      sysregd: Ignore SIGHUP while running as daemon
      lib/cobalt: Fix ordering of fork handler
      sysregd: Clean up sessions also in linger mode
      sysregd: Register atexit hook earlier
      testsuite/smokey/xddp: Poll for registry link to appear
      copperplate/registry: Make inter-user sharing configurable
      sysregd: Adjust access rights of mount point directories
      sysregd: Remove session rootdir on cleanup
      cobalt: Generalize RTDM udev rules
      doc: Fix registry path documentation
      copperplate/registry: Switch to /var/run as default mountpoint root
      copperplate/registry: Establish per-user namespaces for named sessions
      sysregd: Unmount filesystems via fusermount
      scripts: Add multi-user service setup scripts
      build: Fix kernel build if SRCARCH != ARCH

Philippe Gerum (39):
      cobalt/kernel: fixups for kernel 3.16
      trank/native: add compat call for rt_pipe_create()
      cobalt/uapi: allow up to 128 distinct clock identifiers
      cobalt/include/kernel: fix dist rule
      cobalt/posix/thread: fix pthread_getschedparam() for RR threads
      lib/analogy: drop dependencies on obsolete rt_dev API
      utils/can: drop dependencies on obsolete rt_dev API
      include/rtdm: drop obsolete rt_dev API, move to trank support
      utils/autotune: fix signedness issue after type promotion (gcc
4.x/ppc64)
      cobalt/kernel/rtdm: drop obsolete rt_dev API
      cobalt/powerpc: use regular context switch routines
      cobalt/rtdm/mutex: fix rtdm_mutex_timedlock()
      scripts/xeno-config: add some implicit defaults
      cobalt/posix/thread: fix error handling upon failure to map shadow
      copperplate: add configuration tunable for registry moint point
      cobalt/arm: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      scripts/mercury: restore lost CFLAGS in xeno-config
      rtcan/flexcan: align with device tree specs >= 3.11
      copperplate/threadobj: fix race on early thread exit
      copperplate/threadobj: mercury: work around glibc's PI bug with
condvars
      cobalt/x86_64: fix register trashing upon MAYDAY diversion
      cobalt/x86: upgrade I-pipe support
      cobalt/arm: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/arm: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/kernel: distinguish u/k/i latencies in Kconfig
      trank/rtdm: finalize compat wrappers
      doc: assorted doxygen fixups
      build: bump version code
      bootstrap
      doc: prebuild
      cobalt: bump ABI revision level

--
Philippe.

