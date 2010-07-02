From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Fri,  2 Jul 2010 13:49:59 +0200
Message-Id: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH 0/2] Host realtime clock support
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

(This is the ipipe part of the mechanism, please see the Xenomai
 mailing list for the patches that make use of the infrastructure)

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
 arch/x86/Kconfig              |    1
 arch/x86/include/asm/tsc.h    |    1
 arch/x86/kernel/tsc.c         |    4 +--
 arch/x86/kernel/vsyscall_64.c |    6 +++++
 include/linux/ipipe_tickdev.h |   25 +++++++++++++++++++++++
 kernel/ipipe/Kconfig          |    3 ++
 kernel/ipipe/core.c           |   44 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 82 insertions(+), 2 deletions(-)


