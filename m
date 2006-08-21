Message-ID: <44EA1B2A.5010402@domain.hid>
Date: Mon, 21 Aug 2006 22:44:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] primary mode versus secondary mode
References: <75975c320608211235l79dfb17ft54df1018e7f597ff@domain.hid>
	<75975c320608211321u5b2d9e45nfb078e9ed4d8b617@domain.hid>
In-Reply-To: <75975c320608211321u5b2d9e45nfb078e9ed4d8b617@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4DC44AE5BABDE3D6F9062DC4"
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
To: Paul Ianna <paulianna2002@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DC44AE5BABDE3D6F9062DC4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul Ianna wrote:
> Hi All,
>=20
> I have read (at least some of) the Xenomai docs and am a little
> unclear on the real distinction between primary and secondary mode.
>=20
> I have seen in the native API that I can receive a signal if a task
> has "migrated to the Linux domain".
>=20
> Does secondary mode mean that I am no longer a real-time task?

As long as your task is in this mode, Linux can do with it again what it
wants to. This phase ends once you call a Xenomai service that requires
primary mode or you enforce a mode switch (rt_task_set_mode, but for
most applications designs not required).

>=20
> How do I avoid dropping from primary mode to secondary mode?

Avoid executing Linux system services (file I/O, networking, printf,
etc.) in critical code paths, avoid sending Linux signal to the task.
But if you write a hard real-time application, you are likely doing a
careful review of what your time-critical code finally does anyway ;).
If not (don't tell it anyone...), the SIGXCPU signal raised on mode
switches can guide you finding fishy parts.

Jan


--------------enig4DC44AE5BABDE3D6F9062DC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6hsqniDOoMHTA+kRAkvYAJ4hRbTvxjjDm32Fg4ctkDBeOS/R1wCfUKcZ
z3bK0B+EHyGtuSXfNMYsLxE=
=7WJG
-----END PGP SIGNATURE-----

--------------enig4DC44AE5BABDE3D6F9062DC4--

