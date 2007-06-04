Message-ID: <46649F7E.3060104@domain.hid>
Date: Tue, 05 Jun 2007 01:25:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47B608E1A4CEEE75A7EA90A4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig47B608E1A4CEEE75A7EA90A4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

An undated and extended version of my patch stack for I-pipe and Xenomai =

is now available at

	http://www.rts.uni-hannover.de/rtaddon/patches

There is once again some new stuff from my would-be-nice-in-2.4 list
contained, namely the timerstat /proc output and a preview on my current
rtdm_timer draft. Here is the overview of the content:

/ipipe-kernel
-------------

ipipe-janitorial.patch

    [unchanged]
    Removes useless hunks from the I-pipe patch, specifically over i386.

disable-context-check-v3.patch
disable-context-check-v2-i386.patch

    [Fixed broken !CONFIG_IPIPE_DEBUG_CONTEXT build]
    Infrastructure for temporarily or permanently disabling the context
    checker. Applies this on ipipe_trace_panic_freeze() and NMI.

refactor-ipipe_walk_pipeline.patch

    [broken-out ipipe_processor_id removal]
    Remove cpuid from __ipipe_walk_pipeline parameters, remove fastcall.

cleanup-processor_id-i386.patch

    [broken-out ipipe_processor_id removal]
    Drop legacy code related to i386 ipipe_processor_id.

instrument-smp_processor_id.patch
instrument-smp_processor_id-i386.patch

    [broken-out ipipe_processor_id removal]
    Catch smp_processor_id invocations over non-root domains on archs
    that retrieve the CPU number from the kernel stack. Archs without
    this problem need to define IPIPE_STACK_INVARIANT_CPUID (only
    support for i386 so far).

hard-irq-disable-on-suspend-resume.patch

    [unchanged]
    Old patch of mine to enable software-suspend over I-pipe.

add-ipipe_preempt_disable.patch

    [unchanged]
    Introduces ipipe_preempt_disable as an I-pipe-safe alternative to
    preempt_disable. Required for kernel markers that come with LTTng.

prepare-lttng.patch
ltt-ipipe-v2.patch

    [updated to use of ipipe_processor_id() where now required]
    LTTng preparation and I-pipe adoption patches. See README.lttng for
    more details.


/xenomai
--------

refactor-queue-init.patch

    Refactor DECLARE_XNQUEUE to DEFINE_XNQUEUE. Break out
    XNQUEUE_INITIALIZER.

cleanup-proc-stuff.patch

    Remove xnskentry::proc, track proc registration via xnskentry::name.
    Clean up redundant typecasts. Remove unneeded code in *_seq_next().

destroy-thread-timers.patch

    Unconditionally destroy xnthread timers on thread deletion. Besides
    the consistency aspect, timerstats.patch will require clean
    destruction.

fast-tsc-to-ns-v2.patch

    [Rebased, improved rounding of least significant digit]
    Integration of my scaled-math-based xnarch_tsc_to_ns service for
    i386 at least.

[RFC] timerstat.patch

    Dump currently or previously active timers per timebase under
    /proc/xenomai/timerstat. Output looks like this:

# cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
0    5959        5958        1          4000000    NULL         [host tic=
k]
0    25          24          659464312  1000000000  xnpod_watch  [watchdo=
g]
0    368         367         5042333    10000000   xnthread_pe  sampling-=
831

    The idea is to have an overview of timer activity *on the target*,
    just like we already have for threads. This can help to quickly get
    an overview about
     - how many timers there are on a system
     - how they are programmed
     - how often they are the scheduled -- and actually fired
     - who may have installed them

[RFC] xntimer-monotonic.patch

    Use a new flag, XNTIMER_MONOTONIC, to control if absolute timeouts
    shall skip wallclock_offset correction on start, making them
    independent of clock adjustment. So far only used by RTDM timers,
    the POSIX /might/ be able to exploit it as well.

[PREVIEW] rtdm-timers.patch

    Add rtdm_timer_* services, turn timerbench into the first user. This
    patch also introduces monotonic timers to rtdm_task_* and adds the
    new clock service rtdm_clock_read_monotonic. The whole thing about
    monotonic clocks for drivers is due to my concerns that once we
    start tuning the master timebase according to external sources, we
    /might/ be happy to provide non-adjustable clock and timers for
    device drivers that need strictly continuous timing.

librtutils.patch

    [refreshed]
    Contains rt_print services so far. Still open naming question.

[RFC] rtsystrace-v2.patch

    [refreshed]
    Proposal to add rt_print-based Xenomai syscall tracing. Looking for
    a less code-invasive approach.

[PREVIEW] lttng.patch

    [rebased]
    Very rough patch to make LTTng work with Xenomai.


As usual: Testers and reviews are welcome, feedback is appreciated.

Jan


--------------enig47B608E1A4CEEE75A7EA90A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD4DBQFGZJ+DniDOoMHTA+kRAnkrAJ9M1/kwkG8VL8em1nLlPmxhD8FKmgCTBfw5
mn9kOA2m8q/RIqTo1Y+evQ==
=+q0f
-----END PGP SIGNATURE-----

--------------enig47B608E1A4CEEE75A7EA90A4--

