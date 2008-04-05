Message-ID: <47F74220.5050904@domain.hid>
Date: Sat, 05 Apr 2008 11:10:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<47F17B32.7070505@domain.hid>	<18417.52630.8850.939898@domain.hid>	<47F23E9E.7060801@domain.hid>	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>	<47F258AD.3000103@domain.hid>	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>	<47F2A7CC.4050301@domain.hid>	<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>	<47F3A00E.1020700@domain.hid>	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>	<47F3E0B3.2030805@domain.hid>	<18419.57862.758026.458669@domain.hid>	<47F3FE7E.6020302@domain.hid>	<18420.2520.32895.319766@domain.hid>	<18420.3711.295442.250105@domain.hid>	<47F5148E.4030909@domain.hid>
	<47F700C2.60509@domain.hid>
In-Reply-To: <47F700C2.60509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62A7E5E5613E6B5661029C2C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62A7E5E5613E6B5661029C2C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Tomas Kalibera wrote:
> Hi,
>=20
> I've tried a more defensive kernel setup & your patch (no.6). The locku=
p=20
> is still there. It  happens after a realtime task is started, though I =

> was unable to track exactly when -  it does not crash in a debugger,=20
> does not crash with strace, breaks SysRq, and printing log messages=20
> seems to be delayed (despite flushing). I tried changing the applicatio=
n=20
> code (like using more default flags when creating a task, etc). But I=20
> did not find a workaround.
>=20
> I've put the kernel on the web again, including the config (the one tha=
t=20
> contains "xenomaidp6"). Maybe it might help to track down the bug...=20
> Maybe not.

Jumping late on this, I didn't find any (user space) test case for the=20
observed bug in this thread. Can you provide something? The simpler, the =

better. It may even contain bugs itself, it just has to trigger the=20
kernel oops reliably.

Then I saw in your .config that your kernel is optimized for AMD K6. In=20
order to prepare "exporting" the bug, could you check that more generic=20
CONFIG_M586TSC makes no difference? Also, if you happen to have a=20
second, different box (/wrt CPU type & speed) at hand, it would be nice=20
to know that the issue is present there as well. But the latter is also=20
something we can try once a test case is available. My preferred target=20
will be QEMU, because that one can quite nicely be debugged even if the=20
box is hopelessly locked up.

Thanks,
Jan


--------------enig62A7E5E5613E6B5661029C2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH90IkniDOoMHTA+kRAoknAJ94osJpun41LHz84Xpy3t6X0Oi/CQCfXBLA
vvza7PB5mxxOLYxIZoF2rWw=
=Yjjl
-----END PGP SIGNATURE-----

--------------enig62A7E5E5613E6B5661029C2C--

