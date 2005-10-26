Message-ID: <435F2DDA.1030702@domain.hid>
Date: Wed, 26 Oct 2005 09:18:50 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid>
In-Reply-To: <435EFAB8.2050501@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC36E8A4A816A32C1130B8855"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC36E8A4A816A32C1130B8855
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hannes Mayer wrote:
> Hi Jan et al.!
> 
> I've noticed your thread on the RTAI list "Driver Model for RTAI" in June.
> Now as I try to port some RTAI serial port stuff to Xenomai in order to
> put up some howto page on my website, I'm clueless.

Actually, there is already some howto, but I guess also enough room for
improvements: http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon/

> 
> None of the RTAI functions rt_spopen, rt_spread_timed, rt_spwrite are
> available - I see that there is some rt_dev_open, rt_dev_write available,
> but only rt_dev_read - what about some timed-read ?

Yep, that's correct, it's yet another new API. Anyway, if you feel the
need for a legacy wrapper, you are welcome to add some library on top of
the RTDM profile.

BTW, timed read can be realised by setting a reception timeout for the
opened device instance, see example or profile documentation.

> 
> I see that rt_spopen opens /dev/rtser[X] but /dev/rtser[X] is not on my
> system, nor can I find any creation-script in the xenomai source.

Nope, RTDM devices are not being mapped into the Linux file system. They
use a separate namespace where you can find serial devices as plain
"rtser[X]".

> 
> Sorry if I'm overlooking some stuff... 5:40am here.
> 

Any frequent problems falling asleep? ;)

Jan

--------------enigC36E8A4A816A32C1130B8855
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXy3bncNeS9Q0k+IRAn8cAJ9aGS8KfhQTUyFoHsk7ii50IVYqJACcCUF6
Z3fWrcCk6MTAuRH2vZ0ydrg=
=4Dc4
-----END PGP SIGNATURE-----

--------------enigC36E8A4A816A32C1130B8855--

