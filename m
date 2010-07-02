From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Fri,  2 Jul 2010 13:49:06 +0200
Message-Id: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 0/7] Host realtime clock support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

(This is the Xenomai part of the mechanism, please see the ipipe
 mailing list for the patches that provide the required basis 
 infrastructure)

This patch series extends Xenomai with a new clock, CLOCK_HOST_REALTIME.
It allows for sharing NTP-corrected real time timestamps between
Linux/ipipe and Xenomai. The data are also available in userspace and can
be read without switching to kernel mode. Notice, however, that the new
clock only enables to read to time, but cannot serve as a full time basis.
Some changes to the ipipe layer are required as basis.

In contrast to the initial approach, we don't use a transactional mechanism
to copy the information over from Linux, but use classical synchronisation.
The code can be compiled in conditionally for both, ipipe and Xenomai. When
disabled by architectures that don't support apt clock sources, there is
no runtime-overhead associated with the feature.

Some points that may require further discussion:

- POSIX only specifies a few clock_ids, and these have already been
  extended by the Linux kernel. We use the maximum id (16) for the new
  clock, but it might also make sense to use 7 (CLOCK_MONOTONIC_COARSE+1)
  or 4 (CLOCK_THREAD_CPUTIME_ID+1).

- The current implementation deals with x86_64's TSC. Support for other
  architectures can be added. Additionally, the user has to make sure that
  the TSC clock source remains active once selected.  To implement 
  deactivation (e.g., when the Linux clock source is changed), more 
  ipipe hooks would be required, though.

  There are two alternatives including other architectures:

  * We can create a new clocksource that abstracts the per-architecture
    differences, and use this clocksource as basis for
    Xenomai. Essentially, this means mapping all desired
    non-x86-Clocksources to the interface offered in this patch.
    This requires more changes in the ipipe layer than variant B, namely,
  * We can create a union in struct xnvdso of all arch-specific clock
    datasets and introduce feature flags like XNVDSO_FEAT_HOSTRT_X86,
    XNVDSO_FEAT_HOSTRT_WHATEVER. The reader-side code then needs to
    match the data provided, which requires more changes on the
    Xenomai side.

- The series supports dynamic switching from a non-TSC clocksource to
  clocksource_tsc, but does not handle the other direction. This is
  intentional, because when a user wants meaningful synchronised time
  stamps, the reliability of the underlying clock should be ensured.

  Naturally, it would be possible to detect this change at the kernel
  level, but this would make the ipipe part more intrusive.

The code compiles with all combinations of IPIPE_HOSTRT and
OPT_XENO_HOSTRT.

As always, thanks for your comments and review!

Best, Wolfgang

---
 examples/posix/Makefile         |    3 -
 examples/posix/show_hrtime.c    |   82 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/hal.h       |    2
 include/asm-generic/system.h    |    4 +
 include/asm-sim/system.h        |    4 +
 include/asm-x86/atomic.h        |    5 ++
 include/nucleus/Makefile.am     |    2
 include/nucleus/hostrt.h        |   65 ++++++++++++++++++++++++++++
 include/nucleus/seqlock_user.h  |   57 +++++++++++++++++++++++++
 include/nucleus/vdso.h          |   20 +++++++-
 include/posix/time.h            |    2
 ksrc/nucleus/Kconfig            |    4 +
 ksrc/nucleus/module.c           |   25 +++++++++++
 ksrc/skins/posix/clock.c        |   90 +++++++++++++++++++++++++++++++++++++++-
 src/skins/posix/clock.c         |   65 ++++++++++++++++++++++++++++
 src/testsuite/unit/check-vdso.c |    2
 16 files changed, 426 insertions(+), 6 deletions(-)


