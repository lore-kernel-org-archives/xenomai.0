Message-ID: <4AF29030.6020600@domain.hid>
Date: Thu, 05 Nov 2009 09:43:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200911050512.20207.cheng.guanghui.ml@domain.hid>	<4AF213F6.3000106@domain.hid>
	<200911051050.24209.cheng.guanghui.ml@domain.hid>
In-Reply-To: <200911051050.24209.cheng.guanghui.ml@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0CA68AFBF5EA0C0376C9B57"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] a problem about hpet device
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Guanghui, Cheng" <cheng.guanghui.ml@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0CA68AFBF5EA0C0376C9B57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Guanghui, Cheng wrote:
> On Thursday 05 November 2009 07:53:26 Gilles Chanteperdrix wrote:
>> Guanghui, Cheng wrote:
>>> Hello:
>>> 	I need to use hpet device as my clock event source in my os
>>> and i have mapped this device to local place. But when i read the
>>> configuration or value all the bit is 1. Is it something wrong?
>> Excuse me, but what is the relation with Xenomai?
> 	Sorry and maybe it is not a direct topic about the Xenomai=20
> but about the real-time systems. I have traced Xenomai at least=20
> for 4 years and read every mail from this maillist. HPET is a very=20
> good internal timer source for real-time systems. Hopefully there
>  are some people doing HPET issue.  If there is no guy about=20
> this work please ignore this mail.

This is clearly off-topic for Xenomai. And note: HPET is not the best
timer source as it doesn't scale (in contrast to LAPIC timers).

Jan


--------------enigF0CA68AFBF5EA0C0376C9B57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrykDgACgkQitSsb3rl5xQdHgCgm6jm4/54OxK9MhVtItpd6AWF
Ld8AoM6/GiYt5IGESNr+DDnxzjdKbDAM
=WOao
-----END PGP SIGNATURE-----

--------------enigF0CA68AFBF5EA0C0376C9B57--

