Message-ID: <47DEB42A.1080302@domain.hid>
Date: Mon, 17 Mar 2008 19:10:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000301c88853$133395b0$9601a8c0@domain.hid>
In-Reply-To: <000301c88853$133395b0$9601a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig49086339F537802990663488"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Porting Linux Tasklets
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49086339F537802990663488
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Robert McCullough wrote:
> Hi,
>=20
> How do I implement a Linux Tasklet in a RTDM driver?
> I am currently using the tasklet_hi_schedule() API in my Linux driver a=
nd
> need to port that to my RTDM driver.=20

I assume that the code in the tasklet handler is supposed to fulfil=20
real-time requirements: Either in a rtdm_task (using e.g.=20
rtdm_event_signal/wait for communication) or directly in the IRQ=20
handler. That depends on the worst-case execution time of the handler=20
and if there are might be tasks/IRQs that should have higher priority.

Jan


--------------enig49086339F537802990663488
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH3rQsniDOoMHTA+kRAkJVAJ9bfZZoDPgpaXi8dQxIeorbwQ4nxwCfZVkT
q6Rku+7qRuaCAnS42hRipUE=
=KuKY
-----END PGP SIGNATURE-----

--------------enig49086339F537802990663488--

