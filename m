Message-ID: <48E8B704.8030403@domain.hid>
Date: Sun, 05 Oct 2008 14:45:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid> <48E8AFB4.4040208@domain.hid>
	<48E8B29D.5040705@domain.hid>
In-Reply-To: <48E8B29D.5040705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig244AE10CEA8765B55FE27F86"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r4210 - in /trunk:
	ChangeLog	src/skins/native/task.c
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
--------------enig244AE10CEA8765B55FE27F86
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Author: gch
>>> Date: Sat Oct  4 23:11:09 2008
>>> New Revision: 4210
>>>
>>> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D4210&view=3Drev
>>> Log:
>>> Call __real_pthread_setschedparam in order to inform the libc of the =
scheduling parameters change.
>> Well, I dropped this idea after realizing that it will kick us out of
>> primary mode in all cases. This change is an improvement (/wrt Linux
>> scheduling accuracy) for borderline threads, but it will cause
>> regressions for primary-only threads. I have no idea right now how to
>> make both happy, at least without explicit pthread_setschedparam
>> invocations by the user application.
>=20
> Well, we discussed this on the xenomai mailing list, you did not answer=
,
> so we assumed you agreed.

I do not find any hint in that thread that we agreed on changing the
implementation. Rather I took back my suggestion to do it like #4210.
And you proposed to install some signal for syncing glibc /wrt
priorities. When changing something, then I would say explore this path
first.

Turning rt_task_set_priority into secondary-mode service is a critical
change, and only the last resort if we consider its current
implementation as totally broken - I wouldn't say it is like that. It's
partially and, unfortunately, silently broken, ie. lacking documentation
about its limitations. But its perfectly OK for primary-only users.

Jan


--------------enig244AE10CEA8765B55FE27F86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjotwUACgkQniDOoMHTA+n5uQCfUcqx8zpHp/a3gdd01u7C9xl/
RxoAn0SLgyt5GWTammsjmDOp7LH3cT0D
=4gHN
-----END PGP SIGNATURE-----

--------------enig244AE10CEA8765B55FE27F86--

