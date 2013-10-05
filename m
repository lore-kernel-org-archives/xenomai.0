Message-ID: <52505D40.7070600@xenomai.org>
Date: Sat, 05 Oct 2013 20:41:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [Announce] Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

at last, here comes Xenomai 2.6.3, available at the usual address:
http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2

In addition to core bug fixes and improvements, it has the following
more visible changes:
- upgrade to support I-pipe patches to Linux 3.8, and Linux 3.10
(not included);
- contributed I-pipe patches for BeagleBone, Raspberry Pi and Zynq;
- upgrade FPU support for recent x86 processors;
- RTCAN drivers updates
- automatically invoke mlockall in Xenomai libraries;
- simplify POSIX skin auto-shadowing;
- clean-up headers, on x86 architecture, and generally to avoid 
warnings when compiling with GCC pedantic or warning flags
- Debian packaging rework
- allow setting the x86 SMI workaround parameters at run-time to help 
building generic kernels;
- allow building applications and Xenomai code with _FORTIFY_SOURCE,
which seems to be the norm for recent distributions;
- finish moving all the manual pages to asciidoc to allow making them 
available online.

Thanks for all contributions.
Regards.

The shortlog follows.
Charles Steinkuehler (1):
      hal/arm: Add pre/post patch set for BeagleBone 3.8.13 kernel

Gernot Hillier (1):
      debian: cleanup configure invocation

Gilles Chanteperdrix (92):
      build: bootstrap
      hal/arm: Add beaglebone patches
      hal/arm: add I-pipe patch for Raspberry Pi
      skins: avoid multiply defined symbols
      nucleus: check for NULL u_mode
      hal/arm: adapt to Linux 3.8
      nucleus/shadow.c: fix for Linux 3.8
      nucleus: do not start host timer emulation if host timer is not shared
      regression: use a semaphore to enforce synchronization
      x86/hal: i386 disappeared from Linux 3.8
      x86/hal: i386 disappeared from Linux 3.8 (2)
      x86/hal: allow SMI control at run-time
      native: avoid using fastlock after free
      native: get unit tests working with periodic timer
      regression/tsc: various fixes
      switchtest: handle device open error
      posix: fallback to __real_socket for EPROTONOSUPPORT
      skins: move libxenomai headers
      posix: allow compiling applications with _FORTIFY_SOURCE
      posix: _FORTIFY_SOURCE support take #2
      build: bootstrap
      testsuite/sigdebug: for munlockall to get missing mlockall signal
      drivers: enable rtipc by default
      skins: move xntrace API out-of-line in libxenomai library
      hal/arm: move __xn_rdtsc definition to asm/tsc.h
      hal/blackfin: move __xn_rdtsc definition to asm/tsc.h
      hal/nios2: move __xn_rdtsc definition to asm/tsc.h
      hal/powerpc: move __xn_rdtsc definition to asm/tsc.h
      hal/sh: move __xn_rdtsc definition to asm/tsc.h
      hal/x86: move __xn_rdtsc definition to asm/tsc.h
      headers: no longer include asm/xenomai/syscall.h automatically
      headers: fix error when compiling with gcc pedantic flags
      hal/arm: use __asm__ to allow compiling with GCC extensions disabled
      hal/x86: use __asm__ to allow compiling with GCC extensions disabled
      posix: allow headers compilation with GCC pedantic flag
      posix: fix HAVE_ symbols in exported headers
      hal/arm: remove C++ comments from C headers
      build: arm generic as an alias to kuser arm tsc and bootstrap
      headers: avoid using signals as it is a keyword for Qt
      debian: revert spurious commit
      hal/arm: fix compilation with I-pipe patch for linux 2.6.31
      posix: avoid races in pthread_set_name_np
      native: do not defer removing rt_heaps from list
      native: avoid calling copy_from_user with hard irqs off
      testsuite/sigdebug: do not assume one-shot timer
      skins/posix: suppress useless xnlock
      nucleus/shadow: generalize xnshadow_call_mayday
      skins/posix: rework user-space thread signals
      skins/posix: disable PTHREAD_WARNSW before exiting a thread
      Merge remote branch 'jan/for-upstream'
      native: do not defer removing rt_queues from list
      hal/x86: fix compilation issues with old kernels
      nucleus: do not always use the noclone attribute
      hal/x86: remove empty directory
      posix: use pragma instead of __extension__
      hal/x86: move smi.o to xeno_hal module
      hal/x86: fix SSE/AVX fpu tests
      hal/arm: move FPU features initialization
      hal/x86: fix kernel-space FPU with old cpus
      hal/x86: fix FPU features detection
      hal/arm: replace config check with compile check
      posix: enable AMOK bit
      nucleus: fix comments in AMOK bit heandling ifdev
      hal/arm: update imx6q patches
      doc: small updates in manual pages
      posix: wrap open64
      tests: get xeno-test to not always return EXIT_SUCCESS
      bootstrap: use autoreconf
      build: use more recent autotools version
      doc: adapt to more recent version of doxygen
      doc: adapt to more recent version of asciidoc
      doc: add xeno-test and dohell manual pages
      doc: fix dohell doc source file name
      doc: regenerate
      debian: rework
      arm: upgrade I-pipe patches
      blackfin: upgrade I-pipe patches
      powerpc: upgrade I-pipe patches
      x86: upgrade I-pipe patches
      x86: add I-pipe patch for Linux 3.8.13
      Merge remote-tracking branch 'mfornero/for-upstream'
      hal/arm: update Raspberry Pi patches
      hal/x86: upgrade I-pipe patch
      build: remove references to prepare-patch.sh
      hal: upgrade I-pipe patches
      doc: update graphic driver advice in troubleshooting guide
      doc: update graphic driver advice in troubleshooting guide
      doc: ixp4xx now also uses the kuser tsc
      hal/arm: upgrade I-pipe patches
      hal/x86: upgrade I-pipe patches
      build: bump version number and bootstrap
      doc: regenerate

Henri Roosen (2):
      make rtcan_flexcan driver compatible with non OpenFirmware platforms
      Fix rtcan_flexcan for mx6 for OpenFirmware platforms

Jan Kiszka (29):
      nucleus: Use separate SIGDEBUG reason code for rescnt imbalance
      configure: Report defaults for command line switches in help output
      prepare-kernel: Only purge links from target directories
      nucleus: Remove unneeded atomic manipulation of xnsched::status
      switchtest: Add SSE and AVX check
      x86-64: Clean up fxsave/fxrstor
      x86: Implement xsave-based FPU context switching
      x86: Remove noxsave kernel parameter enforcement
      Replace configure-time checks on PC Speaker and HPET with build-time checks
      Remove __devinit/exit etc. from drivers
      Restore pre-existing SIGDEBUG handler
      Drop unused xeno_sigxcpu_no_mlock variable
      switchtest: Fix x86 SSE/AVX FPU check helpers
      Invoke mlockall on every skin library initialization
      posix: Control auto-shadowing via environment variable
      Remove mlockall alert handler
      Drop --enable-dlopen, disable optimized TLS support by default
      Work around gcc-4.6 bug
      posix: Skip auto-shadowing if current thread is already shadowed
      nucleus: Remove unused xnvfile_*_p helpers
      nucleus: Adjust procfs usage to latest kernel API
      nucleus: Remove obsolete parent field from xnvfile
      rtcan: Debugging feature depends on procfs
      rtcan: Update procfs usage to latest kernel API
      analogy: Update procfs usage to latest kernel API
      mscan: Fix up procfs changes
      Fix wrapping of procfs services for 2.4 kernels
      nucleus: Forward host ticks on non-real-time CPUs
      skins/posix: Fix locking imbalances in __sem_open

Matthew Fornero (1):
      hal/arm: Add Zynq patches

Paul Corner (2):
      Add missing -g and -b options to the latency documentation.
      hal/arm: upgrade Raspberry Pi patches

Paul Janzen (2):
      rtcan_module: Fix tx_timeout buffer size inconsistency
      rtcan_module: Improve buffer size handling for /proc/rtcan entries

Philippe Gerum (19):
      x86: reunify most of 32/64bit headers
      nucleus/sched-tp: add safe guard when late for next window
      nucleus/timer: display locked timer state in /proc/xenomai/timer
      nucleus/pod: delegate TCB cleanup to exit handler for dormant user threads
      nucleus/pod: document deletion logic in xnpod_delete_thread()
      wrappers: pull MAX_RT_PRIO from linux/sched/rt.h (>= 3.9.0)
      blackfin: upgrade I-pipe support to 3.8.0-1
      x86: upgrade I-pipe support to 3.8.0-1
      powerpc: upgrade I-pipe support to 3.8.0-1
      arm: upgrade I-pipe support to 3.8.0-1
      powerpc: upgrade I-pipe support to 3.5.7-4
      examples/ipc: fixups for building with -Wall -Werror
      wrappers: include linux/sched.h unconditionally
      testsuite: enable back build over uClibc
      blackfin: add calibration data for bf60x
      testsuite/regression: xddp_test: use port auto-selection
      nucleus: emit rejected syscall id upon spurious non-shadow call
      nucleus: raise maximum number of pending low stage requests
      nucleus/timer: prevent buffer overflow

Wolfgang Grandegger (1):
      rtcan/peak_pci: add further device ids to the PCI device, table




-- 
                                                                Gilles.

