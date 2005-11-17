Message-ID: <437D0ABB.3040004@domain.hid>
Date: Thu, 17 Nov 2005 23:56:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] kernel module misses rt_get_time
References: <20051117214647.61520725.gda@domain.hid>	<437D0735.8070306@domain.hid>
	<20051117235310.4418aee6.gda@domain.hid>
In-Reply-To: <20051117235310.4418aee6.gda@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0DD21604BFEE702BE2F73F40"
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
To: Gerald Dachs <gda@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0DD21604BFEE702BE2F73F40
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gerald Dachs wrote:
>>Actually, rt_get_time and rt_get_time_ns are the same in the RTAI
>>compatibility skin (counts are nanoseconds here, see count2nano e.g.).
>>Therefore, a
> 
> 
> Sorry, but I don't think so. In the rtai docs I read that rt_get_time returns ticks
> and rt_get_time_ns returns nano seconds.
> 

Yes, in the original RTAI. But the emulation skin of Xenomai makes no
difference in this regard - all nanoseconds. That's why the conversion
functions are void here.

Jan

--------------enig0DD21604BFEE702BE2F73F40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDfQq7niDOoMHTA+kRAvvrAJ9mSY0maG8efczKLgmABP6ZfoXXUQCeKT45
xqW1Cwrsw6u0d7oMAkvFyGE=
=jSpT
-----END PGP SIGNATURE-----

--------------enig0DD21604BFEE702BE2F73F40--

