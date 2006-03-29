Message-ID: <442A6F5C.50602@domain.hid>
Date: Wed, 29 Mar 2006 13:28:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
References: <1143612388.32703.257789950@domain.hid>
In-Reply-To: <1143612388.32703.257789950@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2C459FC5E078BB77EF51E2A"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saul <xeno@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2C459FC5E078BB77EF51E2A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Saul wrote:
> Hi,
>=20
> I'm trying to run a short test program, just to get into the swing
> of this shiny new real-time system. I'm running Xenomai 2.1.0 on
> kernel 2.6.15.6
>=20
> The following program runs a busy delay in primary mode (verified by
> enabling the primary mode switch warning) and calculates the time taken=
=2E
> Another task is resumed and prints the time.
>=20
> I get output something like this:
>   1:  40.017 ms
>   2:  40.017 ms
>   3:  53.357 ms
>   4:  53.356 ms
>   5:  40.017 ms
>   6:  40.020 ms
>   7:  53.355 ms
>   8:  40.020 ms
>   9:  40.017 ms
>  10:  53.356 ms
>  11:  40.020 ms
>  12:  40.019 ms
>  13:  106.710 ms
>  14:  40.017 ms
>  15:  40.018 ms ...
>=20
> I assume I've done something silly but I can't find anything wrong. My
> computer is a 3GHz P4. Xenomai is built-in statically, and at boot says=

> "Xenomai: SMI-enabled Intel chipset found, enabling SMI workaround."
>=20
> Anyway, the erratic execution times come and go with the smallest
> changes in the program e.g. moving the delay into it's own function or
> creating functions for timing the delay loop, so I wouldn't be too
> surprised if the problem can't be reproduced.
>=20
> Also, I found that using rt_timer_spin() instead of a real busy loop
> does not have the same problem, which indicates that the simple busy
> loop is in fact being interrupted during execution.
>=20
> Is it a problem that I'm not explicitly destroying the tasks? They don'=
t
> linger in /proc/xenomai/sched once the program is killed. How much
> is automatically cleaned up upon process exit?

Tasks are cleaned up, other stuff not.

>=20
> #include <stdio.h>
> #include <stdlib.h> // exit
> #include <unistd.h> // pause
> #include <sys/mman.h> // mlockall
> #include <signal.h>
> #include <xenomai/native/task.h>
> #include <xenomai/native/timer.h>
>=20
> #define MS 1000000
>=20
> RT_TASK timed_task;
> RT_TASK display_task;
> int timed_count =3D 0;
> double timed_delay =3D 0;
>=20
> void my_processing(void)
> {
>         int i;
> //      rt_timer_spin(40*MS);
>         for (i=3D80000000; --i; );
> }
>=20
> void timed_task_handler(void *cookie)
> {
>         RTIME start_tsc =3D rt_timer_tsc();
>         rt_task_set_mode(0, T_WARNSW, NULL);
>         for (timed_count=3D0;;) {
>                 rt_task_sleep(40*MS); /* allow linux to run */
>=20
>                 RTIME prev_tsc =3D rt_timer_tsc();
>                 my_processing();
>                 RTIME tsc =3D rt_timer_tsc();
>                 timed_delay =3D rt_timer_tsc2ns(tsc-prev_tsc)*1e-9;
>=20
>                 timed_count++;
>                 rt_task_resume(&display_task);
>                 if (timed_count >=3D 100)
>                         break;
>         }
>         rt_task_set_mode(T_WARNSW, 0, NULL);
>         printf("total time: %.3f\n",
>                 rt_timer_tsc2ns(rt_timer_tsc()-start_tsc)*1e-6);
>         exit(0);
> }
>=20
> void display_task_handler(void *cookie)
> {
>         for (;;) {
>                 rt_task_suspend(NULL);
>                 printf("%3d:  %.3f ms\n",
>                         timed_count, timed_delay * 1e3);
>         }
>         exit(0);
> }
>=20
> void context_switch_warn_handler(int sig)
> {
>         printf("WARNING: detected switch to secondary mode\n");
> }
>=20
> int main(int argc, char *argv[])
> {
>         int err;
>         mlockall(MCL_CURRENT|MCL_FUTURE);
>         signal(SIGXCPU, context_switch_warn_handler);
>         rt_timer_set_mode(TM_ONESHOT);
>         rt_task_spawn(&timed_task, "timed-task",
>                                 0, 99, 0, timed_task_handler, 0);
>         rt_task_spawn(&display_task, "display-task",
>                                 0, 98, 0, display_task_handler, 0);
>         pause();
>         return 0;
> }
>=20
> Any clues?
> Thanks in advance,
> Saul.
>=20

No obvious problem with your program. Does the latency test of Xenomai
show any significant times? Maybe the SMI workaround does not catch all
issues on your system (though up to 60 ms jitter is still quite a lot).

Jan


--------------enigC2C459FC5E078BB77EF51E2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEKm9cniDOoMHTA+kRAqjdAJ9S1Nl9VWyNev5p6upv1yrxtWdeeQCeLIZf
zRpVLViPald0nRD31nNJ7S8=
=FYEU
-----END PGP SIGNATURE-----

--------------enigC2C459FC5E078BB77EF51E2A--

