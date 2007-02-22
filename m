Message-ID: <45DDB8A6.9090703@domain.hid>
Date: Thu, 22 Feb 2007 16:37:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Hello world with questions
References: <bc4264770702220523r6af8f8at6d709a0e9079bd6c@domain.hid>
In-Reply-To: <bc4264770702220523r6af8f8at6d709a0e9079bd6c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9DD8459513BFF7875ACB6E90"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DD8459513BFF7875ACB6E90
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> I have copy-pasted the trivial app into the body of this mail. To
> understand what is
> going on I have sprinkled and garnished it with questions.
>=20
>=20
> [These are standard headers I presume]
> #include <stdio.h>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/mman.h>

Jep.

>=20
>=20
> [These are xenomai headers. What libraries must be linked in with them?=
]
> #include <native/task.h>
> #include <native/timer.h>

-lnative, see examples.

>=20
> [I see this macro is called later as an argument. What is its function?=
]
> RT_TASK demo_task;

It's a type in fact. Actually, this is bad style, derived from the
original RTAI API mess. I think we should establish something like
rt_task_t etc. on the long-term for the Xenomai native skin, keeping the
current names only for legacy code (Philippe?).

>=20
> /* NOTE: error handling omitted. */
>=20
> void demo(void *arg)
> {
>=20
>           RTIME now, previous;
>=20
>     /*
>      * Arguments: &task (NULL=3Dself),
>      *            start time,
>      *            period (here: 1 s)
>      */
>     rt_task_set_periodic(NULL, TM_NOW, 1000000000);
>=20
>     previous =3D rt_timer_read();
>=20
>     while (1) {
>         rt_task_wait_period(NULL);
>         now =3D rt_timer_read();
>=20
>         /*
>          * NOTE: printf may have unexpected impact on the timing of
>          *       your program. It is used here in the critical loop
>          *       only for demonstration purposes.
>          */
>         printf("Time since last turn: %ld.%06ld ms\n",
>                (long)(now - previous) / 1000000,
>                (long)(now - previous) % 1000000);
>                previous =3D now;
>     }
> }
>=20
>=20
> [The purpose of this function eludes me ?]
> void catch_signal(int sig)
> {
> }

POSIX signal handling (not Xenomai-related): makes pause() below return
when some of the caught signals arrive.

>=20
> int main(int argc, char* argv[])
> {
>=20
> [What is happening here?]
>     signal(SIGTERM, catch_signal);
>     signal(SIGINT, catch_signal);

# man signal

>=20
> [Does this mean I cannot access global variables if this program is
> running in a thread? That would be a disastrous limitation!]
>     /* Avoids memory swapping for this program */
>     mlockall(MCL_CURRENT|MCL_FUTURE);

??? There is no such limitation. It's the plain thread programming model
like with normal pthreads.

# man mlockall

>=20
>     /*
>      * Arguments: &task,
>      *            name,
>      *            stack size (0=3Ddefault),
>      *            priority,
>      *            mode (FPU, start suspended, ...)
>      */
> [I presume this sets the function "demo" as a real-time task?]
>     rt_task_create(&demo_task, "trivial", 0, 99, 0);

No, it just creates that task object, the function is set below.

>=20
>     /*
>      * Arguments: &task,
>      *            task function,
>      *            function argument
>      */
>     rt_task_start(&demo_task, &demo, NULL);
> [Is RTASK a task label? What happens if there are more than 1 task to
> run in separate threads?]

RT_TASK is the type of a task /descriptor/ (like a file descriptor or
pthread_t). You can have more tasks by playing with more descriptors.

>=20
> [How is the loop broken to get to this part of the program?]
>     pause();

see above

>=20
>     rt_task_delete(&demo_task);
> }
>=20
>=20
> Kindly,
>=20
> Roland.
>=20

HTH,
Jan


--------------enig9DD8459513BFF7875ACB6E90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3bimniDOoMHTA+kRAtaoAJ9v1PCFe4CoGhFtLu9jHvzhuTwTOQCdHu83
Qa53Svx9sYjgtAJtklIEHEU=
=b0fk
-----END PGP SIGNATURE-----

--------------enig9DD8459513BFF7875ACB6E90--

