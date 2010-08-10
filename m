Message-ID: <4C610855.1080105@domain.hid>
Date: Tue, 10 Aug 2010 10:05:41 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <4C573CCB.7090006@domain.hid>
In-Reply-To: <4C573CCB.7090006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [announce] Xenomai v2.5.4
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Hi,
> 
> you will find Xenomai 2.5.4, aka "Sleep Walk", at the usual place:
> http://download.gna.org/xenomai/stable/xenomai-2.5.4.tar.bz2
> 
> It contains the usual amount of bug fixes and I-pipe patches update, as 
> well as a new piece of nice code: the so-called mayday support, which 
> should allow Xenomai watchdog to work less brutally (namely, avoid 
> killing the tasks occupying too much CPU, and send them a signal), and 
> be the base for a new version of user-space signals in the 2.6 branch.
> 
> Alex also pushed a lot of improvements for the analogy support.
> 
> So, it seems not everybody has been lazy like me for this last version.

to satisfy my curiosity: What was the exact reason for not including
the hostrt stuff? After having spent quite some (obviously wasted)
effort to make the code compliant with the maintainer's requests, I
wonder what could have been missing.

Wolfgang
> 
> The complete shortlog follows:
> Alexis Berlemont (48):
>       analogy: change the context's role (broken)
>       analogy: the buffer structure is now the central field of a4l_context (bro
> ken)
>       analogy: the subdevice structure got a new status field (broken)
>       analogy: the transfer structure is left with a minimal role (broken)
>       analogy: first draft of buffer initialization functions (broken)
>       analogy: adapt open, r/w, select and ioctl functions (broken)
>       analogy: adapt a4l_set_dev() after a4l_context's overhaul (broken)
>       analogy: update a4l_set_dev() declaration (broken)
>       analogy: update comments on a4l_context (broken)
>       analogy: changes related with subdevice's status field (broken)
>       analogy: replace transfer setup functions with buffer setup ones (broken)
>       analogy: update cancel functions (broken)
>       analogy: rewrite the cancel ioctl handler (broken)
>       analogy: fix bulk flag declaration in buffer.h (broken)
>       analogy: update a4l_read and a4l_write (broken)
>       analogy: update all a4l_buf_* functions (broken)
>       analogy: last updates in the buffer part (broken)
>       analogy: cosmetic changes (broken)
>       analogy: declare the reserve / release functions at the subd level (broken
> )
>       analogy: update a4l_get_minor function (broken)
>       analogy: update a4l_set_dev and remove useless info traces (broken)
>       analogy: use rtdm_context_to_private (broken)
>       analogy: minor fix in the subdevice structure declaration
>       analogy: add some helper macros to test the subdevice's characteristics
>       analogy: remove useless functions in the subdevice part
>       analogy: fix the buffer syscalls (ioctl + r/w) after buffer review (broken)
>       analogy: fix the declaration of the structure a4l_context (broken)
>       analogy: fix compilation issues and review the mmap ioctl handler (broken)
>       analogy: cosmetic change (broken)
>       analogy: fix buffer's compilation issues (broken)
>       analogy: prettify some subdevice tests (broken)
>       analogy: [pcimio] fix a huge hack in the mite initialization (broken)
>       analogy: fix the last compilation problems
>       analogy: fix a missing setting of the buf field in subdevice (broken)
>       analogy: fix the subdevice status management
>       analogy: fix buffer initialization/cleanup calls at open/close times
>       analogy: [loop] add a debug trace when trigger is called
>       analogy: fix test of subdevice status in a4l_write
>       analogy: [fake - loop] remove volatile keywords
>       analogy: add a detail in a4l_close doxygen doc
>       analogy: add an arbitrary sleep in cmd_write before closing the device
>       analogy: [ni_pcimio] really minor changes
>       analogy: [ni_pcimio] add the missing allocation of the digital ring
>       analogy: [ni_pcimio] fix timeout value in digital trigger
>       analogy: remove a4l_subd_is_busy calls in analogy core
>       analogy: remove calls of a4l_release/reserve_subd in the core
>       analogy: remove some tests which become with the buffer overhaul
>       analogy: fix a bug in a4l_fill_desc() when called on an idle device
> 
> Gilles Chanteperdrix (18):
>       arm: fix VFP handling in the SMP case
>       arm: get the nodiv_llimd code to compile in thumb mode
>       Merge commit 'rpm' into pending
>       Merge branch 'pending'
>       rtcan: add missing PCI IDs for old kernels
>       Merge commit 'rpm/for-upstream' into build-test
>       Update autotools files
>       arm: clarify the patches README with regard to vendor-specifi branches
>       Merge commit 'analogy' into pending
>       testsuite: adapt "run" scripts to the --with-testdir option
>       native: add cancellation points
>       arm: upgrade adeos patches to 2.6.30-1.15-02, 2.6.31-1.16-02, 2.6.33-1.17-
> 02
>       Add IMX51 patch
>       build: bootstrap
>       compat: add missing PCI ID for 2.4 kernels
>       sched: avoid infinite reschedule loops
>       build: bump version number
>       doc: regenerate
> 
> Pavel Cheblakov (1):
>       rtcan: add rtcan_plx_pci driver
> 
> Philippe Gerum (46):
>       generic/hal: remove dead code
>       powerpc/hal: test XENO_HW_UNLOCKED_SWITCH instead of IPIPE_WANT_PREEMPTIBL
> E_SWITCH
>       powerpc: use hardened switch_mm() support when available
>       powerpc: upgrade I-pipe support to 2.6.33.4-powerpc-2.9-01
>       nucleus: prevent stack overflow w/ unlocked context switch
>       scripts: fix --enable-debug help string
>       posix: fix build w/o CONFIG_PROC_FS
>       nucleus/heap: fix build w/o CONFIG_PROC_FS
>       x86: upgrade I-pipe support to 2.6.32.13-x86-2.6-04
>       x86: update fpu state accessor for 2.6.35+
>       x86: upgrade I-pipe support to 2.6.34-x86-2.6-04
>       powerpc: upgrade I-pipe support to 2.6.34-powerpc-2.9-01
>       uitron: fix wait flag helper
>       hal/generic: always track switch to foreign stack
>       compat: provide linux/err.h wrapper to linux/fs.h
>       nucleus: silence deprecated warnings on __builtin_expect for old compilers
>       rtai: mark as deprecated
>       skins: sanitize heap binding
>       build: check for CONFIG_MMU in user-space
>       nucleus: fix heap mapping for nommu
>       wrappers: no need to reserve pages passed to vm_insert_page
>       x86: upgrade I-pipe support to 2.6.32.15-x86-2.7-00, 2.6.34-x86-2.7-00
>       powerpc: upgrade I-pipe support to 2.6.33.5-powerpc-2.10-01, 2.6.34-powerpc-2.10-00
>       x86: upgrade I-pipe support to 2.6.32.15-x86-2.7-00, 2.6.34-x86-2.7-00
>       arm: upgrade I-pipe support to 2.6.33-arm-1.17-00
>       blackfin: upgrade I-pipe support to 2.6.34-blackfin-1.14-00
>       nucleus: introduce generic bits for MAYDAY support
>       powerpc: enable MAYDAY support
>       x86: enable MAYDAY support
>       arm: enable MAYDAY support
>       blackfin: enable MAYDAY support
>       nios2: enable MAYDAY support
>       arm: upgrade I-pipe support to 2.6.33-arm-1.17-01
>       blackfin: upgrade I-pipe support to 2.6.34-blackfin-1.14-02
>       powerpc: upgrade I-pipe support to 2.6.33.5-powerpc-2.10-03, 2.6.34-powerpc-2.10-02
>       x86: upgrade I-pipe support to 2.6.32.15-x86-2.7-02, 2.6.34-x86-2.7-01
>       common: warn early about missing /dev/rtheap
>       nucleus: fix uninit variable
>       nios2: upgrade I-pipe support to 2.6.30-nios2-1.2-00
>       rtai: disable for MMU-less and 64bit builds
>       rtdm: fix memory mapping services for nommu platforms
>       powerpc: introduce HW_MATH_EMU symbol
>       switchtest: bail out upon sem_wait() error
>       nucleus: export xnshadow_call_mayday() as a service
>       powerpc: add calibration values for mpc8xx
>       powerpc: upgrade I-pipe support to 2.6.34-powerpc-2.10-03
> 
> Stefan Kisdaroczi (3):
>       debian: switch to dpkg-source 3.0 (native) format
>       debian: fix init script start/stop values
>       x86: add Intel ICH10_1 to rthal_smi_pci_tbl
> 
> Tschaeche IT-Services (1):
>       nucleus: enable tswitch callout for the root thread
> 
> Enjoy.
> 


