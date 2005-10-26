Message-ID: <435FBDB1.2010109@domain.hid>
Date: Wed, 26 Oct 2005 19:32:33 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid> <435F2DDA.1030702@domain.hid>
	<435FB6CB.9030307@domain.hid>
In-Reply-To: <435FB6CB.9030307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F59DFD311F4A7E9BE604A8A"
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
--------------enig4F59DFD311F4A7E9BE604A8A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello Hannes,

> ...
> I compiled the rt_serial_uprog, but it can't open rtser0:
> 
> # ./rt_serial_uprog
> rt_serial_uprog: timer started
> rt_serial_uprog: can't open rtser0 (write)
> rt_serial_uprog: stop timer
> 
> # lsmod
> Module                  Size  Used by
> xeno_16550A            12392  0
> xeno_rtdm              23460  1 xeno_16550A
> xeno_native           114384  0
> xeno_nucleus           82696  3 xeno_16550A,xeno_rtdm,xeno_native
> xeno_hal               23616  4
> xeno_16550A,xeno_rtdm,xeno_native,xeno_nucleus
> [...]
> 
> rtser[X] should be available as soon as xeno_16550A is loaded, right ?

Only when you provided the correct module parameters... Isn't that
documented somewhere? Don't remember right now, but if not, this
requires fixing. Check what's available on your box via /proc/xenomai/rtdm.

> 
>> Any frequent problems falling asleep? ;)
> 
> 
> Usually not - we have national holiday today, so I was doing my stuff as
> long
> as I wanted :-)

Yea, I can understand. The only problem is the code one produces between
about 3 and 5 am - mine is generally just "interesting". Later it gets
better again. :)

Jan

--------------enig4F59DFD311F4A7E9BE604A8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDX72yncNeS9Q0k+IRAtWFAKC6yXA9HGONqhGb9uBuFXsbtAdwjACeJkHJ
wDcISC8F8W26ClwsG+7Vhpc=
=032+
-----END PGP SIGNATURE-----

--------------enig4F59DFD311F4A7E9BE604A8A--

