Message-ID: <43CE9FCB.2070305@domain.hid>
Date: Wed, 18 Jan 2006 21:06:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601171559x13acf2c2m@domain.hid>
In-Reply-To: <fd6a47a90601171559x13acf2c2m@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA9DD1E321FCAA6E6595D6B5F"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9DD1E321FCAA6E6595D6B5F
Content-Type: multipart/mixed; boundary="------------090705050800060206000208"

This is a multi-part message in MIME format.
--------------090705050800060206000208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
> Gilles,
>=20
>=20
> I cannot reproduce those messages after turning nucleus debugging on.
> Instead, I now either get relatively more failing mutexes or even hard
> lockups with the test program I sent to you. If the computer didn't cra=
sh,
> dmesg contains 3 Xenomai messages relating to a task being movend to
> secondary domain after exception #14. As when the computer crashes: I h=
ave
> written the last kernel panic message on a paper. Please tell if you wa=
nt
> also the addresses or (part of) the call stack.
>=20
> I'm still wondering if there's a programming error in the mutex test
> program. After I sent my previous message, and before I turned nucleus
> debugging on, I managed (by reducing the sleeptimes to max. 5.0e4) to
> fatally crash the computer, while spewing out countless 'scheduling whi=
le
> atomic messages'. Is the mutex error reproducible ?

I was not able to crash my box or generate that scheduler warnings, but
the attached patch fixes the false positive warnings of unlocked
mutexes. We had a "leak" in the unlock path when someone was already
waiting. Anyway, *this* issues should not have caused any other problems
then the wrong report of rt_mutex_inquire().

@Gilles: please apply to both trees.

[Update] While writing this mail and letting your test run for a while,
I *did* get a hard lock-up. Hold on, digging deeper...

Jan

--------------090705050800060206000208
Content-Type: text/plain;
 name="mutex-lockcnt.fix"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="mutex-lockcnt.fix"

Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(revision 465)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2006-01-18  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/skins/native/mutex.c (rt_mutex_unlock): Fix leaking lockcnt
+	on unlock with pending waiters.
+
 2006-01-16  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* ksrc/skins/native/task.c (rt_task_create): Use a separate string
Index: ksrc/skins/native/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/mutex.c	(revision 465)
+++ ksrc/skins/native/mutex.c	(working copy)
@@ -461,8 +461,11 @@
     mutex->owner =3D thread2rtask(xnsynch_wakeup_one_sleeper(&mutex->syn=
ch_base));
=20
     if (mutex->owner !=3D NULL)
+	{
+	mutex->lockcnt =3D 1;
 	xnpod_schedule();
-   =20
+	}
+
  unlock_and_exit:
=20
     xnlock_put_irqrestore(&nklock,s);

--------------090705050800060206000208--

--------------enigA9DD1E321FCAA6E6595D6B5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzp/LniDOoMHTA+kRAvukAJ0TJIFxtS2XUx8arD35ioYpANzlRwCff/6M
pFgK6y0SnZ7pwOKTeArVgDE=
=Twqt
-----END PGP SIGNATURE-----

--------------enigA9DD1E321FCAA6E6595D6B5F--

