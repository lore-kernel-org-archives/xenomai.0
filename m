Message-ID: <465ABD99.1090301@domain.hid>
Date: Mon, 28 May 2007 13:31:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72776EE42663D37B4E63A7BD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [ANNOUNCE] Xenomai and I-pipe patch series,
	LTTng bits
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
--------------enig72776EE42663D37B4E63A7BD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Instead of posting yet another stream of individual patches from my
queue, I decided to put them all into a series and upload them. See

	http://www.rts.uni-hannover.de/rtaddon/patches

for my latest I-pipe, Xenomai, and LTTng enhancements and fixes. Here is
a short overview of the content:


/ipipe-kernel
-------------

ipipe-janitorial.patch

    Removes (now) useless hunks from the I-pipe patch, specifically over
    i386.

disable-context-check-v2.patch
disable-context-check-v2-i386.patch

    Infrastructure for temporarily or permanently disabling the context
    checker. Applies this on ipipe_trace_panic_freeze() and NMI.

add-ipipe_preempt_disable.patch

    Introduces ipipe_preempt_disable as an I-pipe-safe alternative to
    preempt_disable. Required for kernel markers that come with LTTng.

hard-irq-disable-on-suspend-resume.patch

    Old patch of mine to enable software-suspend over I-pipe.

remove-safe-current.patch
remove-ipipe_processor_id.patch
remove-ipipe_processor_id-i386.patch

    Refreshed cleanup patches, setting in stone that we now have
    non-stack-based smp_processor_id and current over most
    architectures. What "most" precisely means, still needs to be
    clarified.

remove-rwlocks.patch

    Refreshed removal patch for the ironed rwlocks - now that Xenomai's
    interrupt shield no longer needs them.

prepare-lttng.patch
ltt-ipipe.patch

    LTTng preparation and I-pipe adoption patches. See README.lttng for
    more details.


/xenomai
--------

rt-safe-skin-dereference.patch

    As posted a few days ago: Fixes the usage of module_put over
    the Xenomai domain.

inline-rt_timer-services.patch

    Inline trivial rt_timer services of the native skin for kernel
    usage. Saves object size, micro-optimises their usage.

uninline-tsc-ns.patch

    Uninlines the huge xnarch_tsc_to_ns and xnarch_ns_to_tsc functions.
    Specifically on low-end boxes with small caches, this appears to buy
    us several microseconds worst-case latency. :)

fast-tsc-to-ns.patch

    Integration of my scaled-math-based xnarch_tsc_to_ns service for
    i386 at least. xnarch_ns_to_tsc remains untouched in order to keep
    conversion errors small. clocktest reports no significant precision
    regression here, and both code size and execution speed improved.

flatten-timer-irq.patch

    As posted earlier: Refactor the timer IRQ path.

xntimer-start-in-tick.patch

    As posted earlier: Only reprogram the hardware timer once per tick.

optimise-periodic-xntimers.patch

    Simplifies the tests that have to be done in the tick handler in
    order to decide if an xntimer shall be reloaded by introducing a new
    timer state XNTIMER_PERIODIC and testing all states at once.

xeno-kill-ipipe_processor_id.patch

    Refreshed cleanup patch to remove ipipe_processor_id completely.

remove-rthal_rwlock.patch

    Refreshed removal patch for the now unused rthal_rwlocks.

librtutils.patch

    My original librtprint patch. I now renamed the library to
    librtutils to express that more stuff beyond rt_print may find its
    home here in the future. Hopefully acceptable now.

rtsystrace-v2.patch

    Updated proposal to add rt_print-based Xenomai syscall tracing.
    Still in early stage, and I'm lacking feedback on this approach, if
    it makes sense to pursue it.

lttng.patch

    Very rough patch to make LTTng work with Xenomai again. This patch
    tries to follow Jean-Olivier Villemure's original work very closely
    to get something working first. Needs more cleanups and enhancements
    as I explained earlier in the LTTng announcement.


/lttng
------

lttv-xenomai.patch

    Rebased version of Jean-Olivier Villemure's original LTTV extension
    for Xenomai. Applies to LTTV 0.8.82 but is still unstable and
    quickly crashes when visualising Xenomai traces.


Check out, give it a try. Feedback would be appreciated, just as well as
patches/fixes, e.g. to add support for further archs where only i386 is
included yet.

Jan


--------------enig72776EE42663D37B4E63A7BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGWr2ZniDOoMHTA+kRAqkSAJ9OIvw5zPMxtinVErVh7paCzETBhACggs+S
5bVFb/2fHZVE383IbIRkxVg=
=oNGv
-----END PGP SIGNATURE-----

--------------enig72776EE42663D37B4E63A7BD--

