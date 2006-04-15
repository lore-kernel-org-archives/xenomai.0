Message-ID: <4440C19C.2000302@domain.hid>
Date: Sat, 15 Apr 2006 11:49:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] T_FPU without effect
References: <443F5DD7.40306@domain.hid>
	<17471.42250.270559.782396@domain.hid>
In-Reply-To: <17471.42250.270559.782396@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0DC916DEEB46A07E94F5D753"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0DC916DEEB46A07E94F5D753
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > after receiving SIGXCPU for unexpected context switches in a larger
>  > application, I found out that the T_FPU bit does not seem to be
>  > recognised on x86 during native task creation. Here is a simple test=

>  > case, watch out for /proc/xenomai/faults after program start and 5 s=
 later:
>  >=20
>  > #include <native/task.h>
>  > #include <sys/mman.h>
>  >=20
>  > float x;
>  >=20
>  > void task_func(void *p)
>  > {
>  >     rt_task_sleep(5000000000LL);
>  >     x =3D 3.14 + (int)p;
>  > }
>  >=20
>  > main()
>  > {
>  >     RT_TASK task;
>  >=20
>  >     mlockall(MCL_CURRENT|MCL_FUTURE);
>  >=20
>  >     rt_task_spawn(&task, NULL, 0, 40, T_FPU | T_JOINABLE, task_func,=
 0);
>  >     rt_task_join(&task);
>  >=20
>  >     return 0;
>  > }
>  >=20
>  >=20
>  > Any immediate ideas?
>=20
> User-space threads always have the FPU bit anyway. When a user-space

Yep, I stumbled over this fact meanwhile.

> thread in primary mode uses FPU for the first time on x86, the FPU
> hardware is initialized in the fault handler, this is the expected
> behaviour. This allow the nucleus to not switch FPU context for
> user-space threads that never use the FPU.

But doesn't this lazy scheme introduce the risk of unexpected latencies
for the first FPU usage of a RT task? I mean, there is already the
information available if a task is going to use the FPU (via the flag),
then why not make use of it?

>=20
> In case of an abnormal FPU fault, the message "invalid use of FPU" is
> printed on console.
>=20

Yeah, I got this unfortunately only once: full alarm, both via kernel
message and SIGXCPU. So far I failed to reproduce it. I tested that
"normal" FPU usage for the first time does not trigger that warnings.
What may have caused this?

Jan


--------------enig0DC916DEEB46A07E94F5D753
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQMGjniDOoMHTA+kRAiZaAJ94mp1nF5upfaLm00TxMHUHXBNp3QCfbHiA
TonpjnuYIoFKbo+M1G0jZ10=
=iEKJ
-----END PGP SIGNATURE-----

--------------enig0DC916DEEB46A07E94F5D753--

