Message-ID: <436718FB.8090207@domain.hid>
Date: Tue, 01 Nov 2005 08:27:55 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] General Xenomai / RTAI Skin
	Usage         Questions
References: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
	<4366708B.8010501@domain.hid>
	<200511011227.03173.rlenglet@domain.hid>
In-Reply-To: <200511011227.03173.rlenglet@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig096EC47BE89B66187E112F28"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig096EC47BE89B66187E112F28
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Romain Lenglet wrote:
> ...
> Otherwise, my biggest source of problems is IRQ sharing between 
> realtime and non-realtime drivers: this predictably provokes 
> kernel panics. But Jan seems to be working on it.
> 

Actually, Dmitry and I are discussing IRQ sharing between real-time
driver, not across the RT/non-RT border.

The latter case almost always a no-go and should rather be solved at
hardware level by rearranging the IRQ usage (where possible...). The
problem is that the non-RT IRQ handler has to be called just after the
RT handler to make the non-RT hardware release the IRQ line. But this
cannot be guaranteed due to other RT activity and creates an ugly
priority inversion.

That your system just crashes is likely due to the RT driver not being
prepared to share IRQs with non-RT. What driver are you using?

Jan

--------------enig096EC47BE89B66187E112F28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZxj7ncNeS9Q0k+IRAgcKAKDcjGLJF3W9sR8YK1rpEBdcoQ4bagCeIGBD
88CkJgkbdqYlTRY/GKKEWQ0=
=eBq1
-----END PGP SIGNATURE-----

--------------enig096EC47BE89B66187E112F28--

