Message-ID: <4B8C23F9.3050109@domain.hid>
Date: Mon, 01 Mar 2010 21:30:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid> <4B86FFA0.3000403@domain.hid>
	<4B870134.2040802@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>
	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58A4F38C250CB3B442FB13B8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58A4F38C250CB3B442FB13B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Charlton, John wrote:
> I am attaching a much simpler tar ball that demonstrates the difference=
 between xenomai-2.4.6.1 and xenomai-2.5.1 rt_cond_wait() function.  The =
difference is that in the new version of xenomai-2.5.1 the rt_cond_wait()=
 function does wait for the condition for the specified timeout interval =
but when it timesout it returns 0 and I have not been able to get it to r=
eturn -ETIMEDOUT.  The CanFestival timers_xeno task depends on the value =
of -ETIMEDOUT being returned when a timeout occurs.
>=20

Yes, there are unfortunately breakages in rt_cond_wait[_until] - fairly
obvious ones when looking from the right angle... :-/. I'm looking into
this.

Thanks,
Jan


--------------enig58A4F38C250CB3B442FB13B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuMI/0ACgkQitSsb3rl5xQUKACguujI6U9nF3BNb8t/TdoB/hy8
F2UAoN4HAW2NS6q4M42GcpNCeyaeXGAD
=aE3e
-----END PGP SIGNATURE-----

--------------enig58A4F38C250CB3B442FB13B8--

