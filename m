Message-ID: <456C79AA.6020904@domain.hid>
Date: Tue, 28 Nov 2006 19:02:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Switch mode with x86
References: <s56c6ea0.008@domain.hid>
In-Reply-To: <s56c6ea0.008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig415A25AFBA4F5FF5538DCF66"
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
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig415A25AFBA4F5FF5538DCF66
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
> Hi !=20
>=20
> I'm newbie in xenomai world,
> I've write an application which make a lot of switch mode
> (Primary->secondary ...)
> and sometime tasks are block in secondary mode (/proc/xenomai/sched ->
> stat X).
> (no watchod message in dmesg, it's block in secondary mode).
>=20
> I use xenomai 2.2.5, adeos 1.5.02 (same probleme with 2.2.3 et adeos
> 1.4)
> It' run on x86 (486 vortex 166Mhz).
> So, i've write an litle example that failed.  It failed on my x86 (in
> less than 2 minutes),
> but this example run corectly with a pentium 4 or an Amd processor :

How does it fail precisely? Which tasks are stuck? Attach
/proc/xenomai/sched output e.g. Already tried to attach gdb to that
process after the lock-up?


One difference of vortex vs. P4 might be (besides speed) that for the
former Xenomai uses TSC emulation, for the latter the CPU already comes
with this support. You can force the high-end systems into that mode by
compiling the kernel with CONFIG_M586. Or did you use the same kernel
images on all systems?

Your .config would be interesting. You can already check if
CONFIG_INPUT_PCSPKR is set. Must be off for TSC emulation (Xenomai 2.2
doesn't check for this conflict, 2.3 will do so).

>=20
> #include <sys/mman.h>
> #include <stdio.h>
> #include <signal.h>
> #include <native/task.h>
> #include <string.h>
>=20
> static int iStop =3D 0;
> RT_TASK Task_1, Task_2;
> //---------------------------------------------------------------------=
-THREAD
> 1
> void thread_1(void *arg)
> {
> 	while(1)
> 	{
> 		unsigned long overruns;
> 		int iErr;
>=20
> 		iErr =3D rt_task_wait_period(&overruns);
> 		if (iErr || overruns)
> 			printf("Echec wait_period task_1 err %d,
> overruns: %lu\n",iErr,overruns);

Would have been better to attach the program instead of inlining it. :)

>=20
> 		//iErr =3D rt_task_set_mode(T_PRIMARY, 0, NULL);
> 		if(iErr)
> 			printf("Echec set_mod Secondary task_1\n");
> printf("r\n");
> 		if(iStop =3D=3D 1)
> 		{
> 			iErr =3D rt_task_delete(&Task_1);
> 			if (iErr )=20
> 				printf("Echec delete task_1 err %d\n",
> iErr);
> 			break;
> 		}
> 	}

There is no mode switch in this thread and the second one. Is this not
required to cause the lock-up???

=2E..
>=20
> If thoses two task have the same priority it looks to not failed,
> perhaps a problem
> with the scheduler in secondary mode when two task comes from primary
> mode ?
> Is it a know probleme with x86 ?

Nope. Fairly unusual. Does the switchtest from the Xenomai test-suite
fail as well?

> Or perhaps a big error in my example ...

Nothing I can see.

>=20
> Have you an idea ?=20
> thanks in advance
>=20
> nicolas blanchard
>=20

Jan


--------------enig415A25AFBA4F5FF5538DCF66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbHmqniDOoMHTA+kRApFFAJ91qpQs7TIJP09X9Vfd5OmIOLGHrwCfTSJ9
B7fy9PrCV6j1vAkVGX5+LjI=
=Osvo
-----END PGP SIGNATURE-----

--------------enig415A25AFBA4F5FF5538DCF66--

