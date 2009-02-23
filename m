Message-ID: <49A323CE.3010302@domain.hid>
Date: Mon, 23 Feb 2009 23:31:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>	<49A1DEBE.6020002@domain.hid>
	<BAY135-W25DA8BBF5E569E370DB25DC6AE0@domain.hid>	<49A2D47D.90609@domain.hid>
	<BAY135-W50A146D755045D42A23F66C6AE0@domain.hid>
In-Reply-To: <BAY135-W50A146D755045D42A23F66C6AE0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6264CC179F58EDFB112C7681"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6264CC179F58EDFB112C7681
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thomas Schaefer wrote:
> Hi,
>=20
> CONFIG_SCHED_SMT is not set.
> I manually overwrite CONFIG_X86_HT to n but every time I run make-kpkg =
it will overwrite CONFIG_X86_HT to y.

Yeah, that was nonsense. And I do have a HT-capable test box with an
older 2x2 Xeon in fact. It never caused problems, at least not like
those you found (the box has sever and unfixable SMI issues, so I
stopped using it for Xenomai tests).

More ideas: What happens if your run latency like this?

	taskset -c 1 latency -c 1

Maybe there is some strange issue with sending IPIs on your box (which
is required to start things up in case creator and created task sit on
different CPUs). If that happens to make a difference, please try again
without taskset but with dumping /proc/xenomai/irq before and after the
start and post the result.

Jan


--------------enig6264CC179F58EDFB112C7681
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmjI9IACgkQniDOoMHTA+khaQCfdWkfvhnqRt3wcmUqAy16vnmi
B0kAn1YYsIALcAOIPLtrqwHqPOk17uzl
=W3St
-----END PGP SIGNATURE-----

--------------enig6264CC179F58EDFB112C7681--

