Message-ID: <4BAFBF32.8030507@domain.hid>
Date: Sun, 28 Mar 2010 22:42:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [announce] Xenomai v2.5.2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>, Xenomai help <xenomai@xenomai.org>

Hi,

here comes Xenomai v2.5.2, codenamed "Souls Of Distortion" available
from Xenomai download area:
http://download.gna.org/xenomai/stable/xenomai-2.5.2.tar.bz2

It contains important fixes for several bugs found in previous versions:
- silent memory corruption induced by the "u_mode" feature;
- bad return values of posix and native condition variables (also add 
some unit tests for condition variables, to allow tracking regressions);
- fix error handling in xnintr_detach().

Some improvements in several area:
- a new --with-testdir option allowing to install xenomai testsuite 
programs in a special directory, to avoid collision with other programs;
- a bunch of improvements from the analogy branch;
- made a libxenomai library factoring the code common between all skins,
with a change in the xeno-config script, making it simpler to use (you 
now pass the script the skin for which you are compiling, and the output 
ldflags contain the name of all libraries);
- get the select syscall more in-line with the behaviour dictated by the
POSIX spec.

And I am probably forgetting some other important changes, short log
follows:
Alexis Berlemont (35):
      analogy: fix a declaration issue, a4l_sizeof_subd was not in analogy.h
      analogy: add the function a4l_sync_dio
      analogy: clean the fake driver and add a DIO subdevice
      analogy: [fake] fix a bad access in the attach procedure
      analogy: fix a bug in a4l_sync_dio
      analogy: add the program insn_bits to test digital subdevices
      analogy: [pcimio] fix a bug in the management of attach options
      analogy: print a kernel error message if an instruction failed
      analogy: add a missing error message in insn_read
      analogy: add a missing error message in insn_write
      analogy: [fake] fix a bad access in the detach procedure
      analogy: [fake] minor change in debug messages
      analogy: remove a useless locking during the detach procedure
      analogy: remove a forgotten variable which became useless
      analogy: add a4l_flush_sync()
      analogy: read() and poll() return no more -ENOENT when acquisition is over
      analogy: reinitialize events flags before accepting commands
      analogy: [fake] send events only if data are sent to userspace
      analogy: adapt cmd_read after having fixed read and poll syscalls
      analogy: in insn_read, no more real-time mode and automatic subd selection
      analogy: in insn_write, no more real-time mode and automatic subd selection
      analogy: improve robustness of the detach procedure
      analogy: minor changes in comments
      analogy: fix a potential missing initialization of the subd descriptor
      analogy: make a4l_config_subd support open drain configuration
      analogy: [pcimio] fix many race conditions in DMA output transfers
      analogy: make __pre_abs_get more robust at ends of acquisitions
      analogy: fix a bug in cmd_read with real-time mode enabled
      analogy: remove rt_task_set_mode from test programs
      analogy: change the error code in case of context error (-EPERM -> -ENOSYS)
      analogy: [loop] add the asynchronous callbacks for the write subdevice
      analogy: in cmd_{read, write}, replace a4l_sys_* by a4l_async_*
      analogy: declare a4l_async_read and a4l_async_write in analogy.h
      analogy: add a description of TRIG_WAKE_EOS
      analogy: at close time, cancel any busy subdevice

Andreas Glatz (3):
      native: corrected spelling mistake in macro __xeno_flush_rq()
      nucleus: check IRQ object before attaching or detaching it
      native: removed redundant code in rt_intr_delete()

Daniele Nicolodi (2):
      analogy: [pcimio] enable subdevice buffer mmapping
      analogy: fix a bug in a4l_ioctl_bufinfo when idle

Gilles Chanteperdrix (34):
      maint: extract-doc copies plain-text files too.
      testsuite: fix compilation of latency with uclibc
      arm: fix inline assembly for older binutils releases.
      nucleus: wake a select'ing thread up when closing a fd.
      timeconv: revert 97b78d45bf4c5571fccd9675fae8bb008a341769
      wrap-link: try to work correctly with the --as-needed option
      Make libxeno_common a real shared library
      Add libxenomai and a new --skin option to xeno-config
      build: bootstrap
      Use pthread_once for initializations which should be called once.
      Merge commit 'jan'
      asm-generic: remove any trace of mlock_alert.h, only bind.h needs it
      libxenomai: make xnsysinfo static, its contents depend on the skin
      xeno-config: fix typo
      xeno-config: support --skin=foo option in addition to --skin foo
      posix: fix recursive condvar implementation
      doc: add a warning about -EINTR return value for rt_cond_wait*
      testsuite: fix mutex-torture timed mutex test to work on UP
      testsuite: add condition variable testsuite
      posix: fix pthread_cond_*wait return value overwriting
      doc: document -ESRCH as a possible return value of rt_cond_delete
      native: fix rt_cond_*wait return value overwriting
      common: add access in user-space to nkvdso
      common: do not let u_mode exceptional cases leak out of current.[ch]
      testsuite: add some margin to avoid false errors in mutex-torture
      testsuite: suppress the cancel_with_signals testcase from sigtest.
      testsuite: fix compilation warnings
      common: modify leak warning
      arm: upgrade I-pipe support to 2.6.28.10-arm-1.12-07, 2.6.29-arm-1.13-05 and 2.6.30-arm-1.15-01
      x86 syscalls: make __xn_get_eip a macro
      Merge commit 'rpm'
      common: use vdso to detect presence of the drop_u_mode syscall.
      build: update version stamp
      doc: regenerate

Jan Kiszka (22):
      RTDM: Split up application and driver debugging
      Mark all time conversion symbols weak
      RTDM+POSIX: Avoid leaking binding objects on errors
      RTDM: Bind deleted sem/event objects, but mark them pending
      RTDM: Consistently use xnsynch_test_flags to test for RTDM_SYNCH_DELETED
      RTDM: Avoid calling cleanup_instance with held spin lock
      RTDM: Add smp barrier to rtdm_context_unlock
      Push time conversion services into libxeno_common
      Fix remapping of global sem_heap on fork
      Avoid false error reports of xeno_handle_mlock_alert
      testsuite: Fix posix mutex test for non-auto-shadow setups
      testsuite: Add timed mutex test
      Native: Fix error signedness in rt_cont_wait_until
      Native: Fix return code of in-kernel rt_cond_wait[_until]
      POSIX: Fix signedness issue in EFAULT path of cond_wait_prologue
      POSIX: Fix signedness in mutex re-acquisition on cond wait
      sigtest: Fix hard lock-up on disabled auto-shadowing
      Add __xn_linux_mux_p for Linux syscall demultiplexing
      Allow for deregistering current mode user space address
      common: Introduce xeno_get_current_fast
      rtdk: Introduce assert_nrt_fast
      common: Restore memory corruption warning for non-leak case

Philippe Gerum (38):
      x86: upgrade I-pipe support to 2.6.32.7-x86-2.6-00
      wrap-link.sh: force object files to stage1
      wrap-link.sh: introduce dry run mode (-n)
      x86: upgrade I-pipe support to 2.6.32.7-x86-2.6-01
      scripts: add wrapper script to run standard Xenomai commands
      build: introduce --with-testdir
      testsuite/unit: make vdso test depend on fastsynch availability
      asm-generic: fix dist rule to include timeconv.h
      scripts: fix xeno-config to return proper POSIX cflags
      scripts: fix xeno-config for the deprecated --posix-cflags form
      posix: do not uselessly detach IRQ descriptor before deletion
      nucleus/intr: factor out consistency checks
      nucleus/intr: factor out attachment bit setting
      nucleus/intr: fix error code from xnintr_detach()
      powerpc: define calibration data for tqm8555
      timeconv: init time conversion helper with hrclock frequency
      powerpc: move to SYSINFO v2
      powerpc: upgrade I-pipe support to 2.6.33-powerpc-2.9-00
      testsuite: silence harmless warnings
      rtdk: silence harmless warnings
      blackfin: initialize clockfreq value
      arm: initialize clockfreq value
      x86: initialize clockfreq value
      native: introduce rt_task_same()
      testsuite/latency: fix false positive in mode switch detection
      powerpc: remove dandling reference
      blackfin: upgrade I-pipe support to 2.6.33-blackfin-1.13-00
      scripts/xeno-config: fix --skin=posix --ldflags call form
      native: introduce rt_task_same()
      testsuite/latency: fix false positive in mode switch detection
      powerpc: remove dandling reference
      blackfin: upgrade I-pipe support to 2.6.33-blackfin-1.13-00
      scripts/xeno-config: fix --skin=posix --ldflags call form
      nucleus: warn about denied syscalls
      Merge branch 'master' into for-upstream
      rtdm: tag syscalls as conforming
      nucleus: reset deferred cancellation bit properly
      rtipc/bufp: prevent I/O waiters from missing a pulse

Roland Stigge (1):
      x86 syscalls: fix __xn_get_eip

Stefan Kisdaroczi (6):
      debian: copyright: fix typo and add project url
      debian: libxenomai1: sync from debian.org
      debian: linux-patch-xenomai.README.Debian: sync from debian.org
      debian: Build-Depends: debhelper (>= 7)
      debian: changelog: sync from debian.org
      debian: fix package libxenomai1

Stefan Schaal (1):
      analogy: add a4l_config_subd() declaration in analogy.h

Regards.

-- 
					    Gilles.

