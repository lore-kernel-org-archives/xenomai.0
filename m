Message-ID: <44C6626A.6000304@domain.hid>
Date: Tue, 25 Jul 2006 20:26:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <448E98A3.6080707@domain.hid>	<448E9E8B.70809@domain.hid>	<448EA7F7.5000802@domain.hid>	<448EB038.8070802@domain.hid>	<448EE593.7010809@domain.hid>	<448EF022.1040901@domain.hid>
	<17550.61982.685449.470866@domain.hid>
In-Reply-To: <17550.61982.685449.470866@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig52E9D2B911136224BD8001D8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Timer optimisations, continued
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
--------------enig52E9D2B911136224BD8001D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

to continue the discussion about improving the timer subsystem,
specifically with respect to unit conversion overhead, I'm posting here
a (fairly long) report of my findings and consideration.

First of all I did some benchmarking of the various optimised conversion
routines that popped up. I stressed them on the different x86-platforms.
The numbers are for 1000 iterations (loop overhead compensated), used
compiler was gcc-4.1. Just to recall the actors:

xnarch_tsc_to_ns - original accurate 64-bit division for converting TSC
                   ticks in nanoseconds (and vice versa)
fast_tsc_to_ns   - my scaled-math-based assembler variant, suffering
                   from some inaccuracy for large intervals, still
                   requires normal 64-bit muldiv for the ns-to-TSC
                   return path
ns_2_cycles      - Philippe's similar version, a bit more inaccurate
nodiv_ullimd     - Gilles' 64-bit conversion routine, only sometimes
                   varying in the last bit from the original result
nodiv_imuldiv    - Gilles' 32-bit div-less conversion for small
                   intervals (haven't checked, but I assume it's as
                   accurate as the 64-bit variant in the limited domain)

And here are the results (ugly test code available on request):

VIA C2, 600 MHz:
xnarch_tsc_to_ns:  160680 cycles /  267800 ns
fast_tsc_to_ns:    119842 cycles /  199736 ns
ns_2_cycles:        69376 cycles /  115626 ns
nodiv_ullimd:      179042 cycles /  298403 ns
nodiv_imuldiv:      41336 cycles /   68893 ns

P-III, 1GHz:
xnarch_tsc_to_ns:  108475 cycles /  107935 ns
fast_tsc_to_ns:     24127 cycles /   24006 ns
ns_2_cycles:        21338 cycles /   21231 ns
nodiv_ullimd:       67974 cycles /   67635 ns
nodiv_imuldiv:      13269 cycles /   13202 ns

P-MMX, 266 MHz:
xnarch_tsc_to_ns:  131886 cycles /  495812 ns
fast_tsc_to_ns:     47697 cycles /  179312 ns
ns_2_cycles:        43627 cycles /  164011 ns
nodiv_ullimd:      141915 cycles /  533515 ns
nodiv_imuldiv:      44761 cycles /  168274 ns

P-M, 1,3GHz:
xnarch_tsc_to_ns:  113219 cycles /   87091 ns
fast_tsc_to_ns:     26718 cycles /   20552 ns
ns_2_cycles:        15024 cycles /   11556 ns
nodiv_ullimd:       49620 cycles /   38169 ns
nodiv_imuldiv:      17036 cycles /   13104 ns

Opteron 275 (32-bit mode), 1,8 GHz:
xnarch_tsc_to_ns:  112507 cycles /   62503 ns
fast_tsc_to_ns:     21857 cycles /   12142 ns
ns_2_cycles:        12545 cycles /    6969 ns
nodiv_ullimd:       41175 cycles /   22875 ns
nodiv_imuldiv:       7261 cycles /    4033 ns

For sure, working with only 32-bit is the fastest variant on all
platforms. Other variants do not always perform well or have limited
accuracy. Unfortunately, 32-bit conversions cannot be applied on all
scenarios, we will see this below.


After hacking my fast_tsc_to_ns, my original plan was to switch the
internal timer base completely to nanoseconds in the hope to reduce the
number of conversions in the timer hot-paths. Luckily I decided to
analyse the typical scenarios first before starting the develop any
patch. I consider the following 5 scenarios for heavy timer usage. Both
TSC and nanoseconds as time base are analysed, also a potential
timer_start() variant that accepts absolute timeout values. The pseudo
code /should/ be self-explaining. If not do not hesitate to ask.


1. Periodic Timers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Start once, run continuously
=3D> hot-path is the timer IRQ


1.1 TSC-based
-------------

task_set_periodic(start, interval)              [rarely]
        delay =3D start - get_time()
                get_time(): tsc -> ns           [64-bit]
        timer_start(delay, interval)
                delay: ns -> tsc                [32-bit candidate]
                date =3D get_tsc() + delay
                interval: ns -> tsc             [32-bit candidate]
                program_timer(date)
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
-or-
task_set_periodic(start, interval)              [rarely]
        timer_start_abs(start, interval)
                date: ns -> tsc                 [64-bit]
                interval: ns -> tsc             [32-bit candidate]
                program_timer(date)
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [hot-path]
        date <=3D get_tsc()?
        date =3D get_tsc() + interval
        program_timer(date)
                delay =3D date - get_tsc()
                set_hw_timer(delay)


1.2 ns-based
------------

task_set_periodic(start, interval)              [rarely]
        delay =3D start - get_time()
                get_time(): tsc -> ns           [64-bit]
        timer_start(delay, interval)
                date =3D get_time() + delay
                        get_time(): tsc -> ns   [64-bit]
                program_timer(date)
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
-or-
task_set_periodic(start, interval)              [rarely]
        timer_start_abs(start, interval)
                date =3D start
                program_timer(date)
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [hot-path]
        now =3D get_time()
                get_time: tsc -> ns             [64-bit]
        date <=3D now()?
        date =3D now + interval
        program_timer(date)
                date: ns -> tsc                 [64-bit]
                delay =3D date - get_tsc()
                set_hw_timer(delay)


1.3 Summary of (only!) the hot-path
-----------------------------------

              | total       | tsc->ns | ns->tsc | possible
              | conversions |         |         | 32-bit ns->tsc
--------------+-------------+---------+---------+----------------
TSC-based     | 0           | 0       | 0       | 0
TSC-based+ABS | 0           | 0       | 0       | 0
ns-based      | 2           | 1       | 1       | 0
ns-based+ABS  | 2           | 1       | 1       | 0



2. Relative Timers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(explicit relative delays)

Started often, typically time out
=3D> hot-path is timer_start() and the timer IRQ


2.1 TSC-based
-------------

task_sleep(delay)                               [hot-path]
        timer_start(delay, 0)
                delay: ns -> tsc                [32-bit candidate]
                date =3D get_tsc() + delay
                program_timer(date)
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [hot-path]
        date <=3D get_tsc()?
        (programming of succeeding timer intentionally not included)


2.2 ns-based
-------------

task_sleep(delay)                               [hot-path]
        timer_start(delay, 0)
                date =3D get_time() + delay
                        get_time: tsc -> ns     [64-bit]
                program_timer(date)
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [hot-path]
        now =3D get_time()
                get_time: tsc -> ns             [64-bit]
        date <=3D now?
        (programming of succeeding timer intentionally not included)


2.3 Summary of the hot-path
---------------------------

              | total       | tsc->ns | ns->tsc | possible
              | conversions |         |         | 32-bit ns->tsc
--------------+-------------+---------+---------+----------------
TSC-based     | 1           | 0       | 1       | 1
ns-based      | 3           | 2       | 1       | 0



3. Relative Timeouts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(IPC mechanisms, device operations, etc.)

Started often, typically do not fire, often comparably large timeout
values that do not make it down to program_timer() before cancellation
=3D> hot-path is timer_start() and timer_stop()


3.1 TSC-based
-------------

mutex_lock(..., delay)                          [hot-path]
        timer_start(delay, 0)
                delay: ns -> tsc                [32-bit candidate]
                date =3D get_tsc() + delay
                program_timer(date)             [rarely]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
        block_on_mutex()
        timer_stop()
                program_timer(date)             [rarely]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [rarely]
        date <=3D get_tsc()?


3.2 ns-based
------------

mutex_lock(..., delay)                          [hot-path]
        timer_start(delay, 0)
                date =3D get_time() + delay
                        get_time: tsc -> ns     [64-bit]
                program_timer(date)             [rarely]
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
        block_on_mutex()
        timer_stop()
                program_timer(date)             [rarely]
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [rarely]
        now =3D get_time()
                get_time: tsc -> ns             [64-bit]
        date <=3D now?


3.3 Summary of the hot-path
---------------------------

              | total       | tsc->ns | ns->tsc | possible
              | conversions |         |         | 32-bit ns->tsc
--------------+-------------+---------+---------+----------------
TSC-based     | 1           | 0       | 1       | 1
ns-based      | 1           | 1       | 0       | 0



4. Absolute Timers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(e.g. TDMA slot timing in RTnet)

Started often, include time-stamp acquisition and conversion, typically
fire =3D> hot-path is get_time(), timer_start(), and the timer IRQ


4.1 TSC-based
-------------

date =3D get_time() + delay                       [hot-path]
        get_time: tsc -> ns                     [64-bit]

task_sleep_until(date)                          [hot-path]
        delay =3D date - get_time()
                get_time: tsc -> ns             [64-bit]
        timer_start(delay, 0)
                delay: ns -> tsc                [32-bit candidate]
                date =3D get_tsc() + delay
                program_timer(date)
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
-or-
task_sleep_until(date)                          [hot-path]
        timer_start_abs(date, 0)
                date: ns -> tsc                 [64-bit]
                program_timer(date)
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [hot-path]
        test date <=3D get_tsc()?


4.2 ns-based
------------

date =3D get_time() + delay                       [hot-path]
        get_time: tsc -> ns                     [64-bit]

task_sleep_until(date)                          [hot-path]
        delay =3D date - get_time()
                get_time: tsc -> ns             [64-bit]
        timer_start(delay, 0)
                date =3D get_time() + delay
                        get_time(): tsc -> ns   [64-bit]
                program_timer(date)
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
-or-
task_sleep_until(date)                          [hot-path]
        timer_start_abs(date, 0)
                program_timer(date)
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [hot-path]
        now =3D get_time()
                get_time: tsc -> ns             [64-bit]
        date <=3D now()?


4.3 Summary of the hot-path
---------------------------

              | total       | tsc->ns | ns->tsc | possible
              | conversions |         |         | 32-bit ns->tsc
--------------+-------------+---------+---------+----------------
TSC-based     | 3           | 2       | 1       | 1
TSC-based+ABS | 2           | 1       | 1       | 0
ns-based      | 5           | 4       | 1       | 0
ns-based+ABS  | 3           | 2       | 1       | 0



5. Absolute Timeouts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(e.g. POSIX IPC mechanisms)

Started often, typically do not fire, include time-stamp acquisition,
often comparably large timeout values
=3D> hot-path is get_time(), timer_start(), and timer_stop()


5.1 TSC-based
-------------

date =3D get_time() + delay                       [hot-path]
        get_time: tsc -> ns                     [64-bit]

sem_timeddown(..., date)                        [hot-path]
        delay =3D date - get_time()
                get_time: tsc -> ns             [64-bit]
        timer_start(delay, 0)
                delay: ns -> tsc                [32-bit candidate]
                date =3D get_tsc() + delay
                program_timer(date)             [rarely]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
        block_on_sem()
        timer_stop()
                program_timer(date)             [rarely]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
-or-
sem_timeddown(..., date)                        [hot-path]
        timer_start_abs(date, 0)
                date: ns -> tsc                 [64-bit]
                program_timer(date)             [rarely]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
        block_on_sem()
        timer_stop()
                program_timer(date)             [rarely]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [rarely]
        date <=3D get_tsc()?


5.2 ns-based
------------

date =3D get_time() + delay                       [hot-path]
        get_time: tsc -> ns                     [64-bit]

sem_timeddown(..., date)                        [hot-path]
        delay =3D date - get_time()
                get_time: tsc -> ns             [64-bit]
        timer_start(delay, 0)
                date =3D get_time() + delay
                        get_time(): tsc -> ns   [64-bit]
                program_timer(date)             [rarely]
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
        block_on_sem()
        timer_stop()
                program_timer(date)             [rarely]
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
-or-
sem_timeddown(..., date)                        [hot-path]
        timer_start_abs(date, 0)
                program_timer(date)             [rarely]
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)
        block_on_sem()
        timer_stop()
                program_timer(date)             [rarely]
                        date: ns -> tsc         [64-bit]
                        delay =3D date - get_tsc()
                        set_hw_timer(delay)

timer_irq()                                     [rarely]
        now =3D get_time()
                get_time: tsc -> ns             [64-bit]
        date <=3D now()?


5.3 Summary of the hot-path
---------------------------

              | total       | tsc->ns | ns->tsc | possible
              | conversions |         |         | 32-bit ns->tsc
--------------+-------------+---------+---------+----------------
TSC-based     | 3           | 2       | 1       | 1
TSC-based+ABS | 2           | 1       | 1       | 0
ns-based      | 3           | 3       | 0       | 0
ns-based+ABS  | 1           | 1       | 0       | 0

[Please don't take every detail above for granted. Some bugs may sleep
even there. Too many conversions...]


To summarise these lengthy results:

 o ns-based xntimers are nice on first sight, but not on second. Most
   use-cases (except 5) require less conversions when we keep the
   abstraction as it is.

 o Performance should be improvable by combining fast_tsc_to_ns for full
   64-bit conversions with nodiv_imuldiv for short relative ns-to-tsc.
   It should be ok to loose some accuracy wrt to long periods given that
   TSC are AFAIK not very accurate themselves. Nevertheless, to keep
   precision on 64-bit ns-to-tsc reverse conversions, those should
   remain implemented as they are:
   "if (ns <=3D ULONG_MAX) nodiv_imuldiv else xnarch_ns_to_tsc"

 o A further improvement should be achievable for scenarios 4 and 5 by
   introducing absolute xntimers (more precisely: a flag to
   differentiate between the mode on xntimer_start). I have an outdated
   patch for this in my repos, needs re-basing.

To verify that we actually improve something with each of the changes
above, some kind of fine-grained test suite will be required. The
timerbench could be extended to support all 5 scenarios. But does
someone have any quick idea how to evaluate the overall performances
best? The new per-task statistics code is not accurate enough as it
accounts IRQs mostly to the preempted task, not the preempting one. Mm,
execution time of some long-running number-crunching Linux task in the
background?

Looking forward to feedback!

Jan


PS: Finally, after stabilising the xntimers again, we will see a nice
rtdm_timer API as well. But those patches need even more re-basing then..=
=2E


--------------enig52E9D2B911136224BD8001D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFExmJqniDOoMHTA+kRAvlVAJ9e0zjnA9sEZQ+Rdi2iBMhYCUt0YgCfY+yB
RDh8Iioxo03YTNUExT3zfu0=
=+kZZ
-----END PGP SIGNATURE-----

--------------enig52E9D2B911136224BD8001D8--

