Message-ID: <437D0735.8070306@domain.hid>
Date: Thu, 17 Nov 2005 23:41:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] kernel module misses rt_get_time
References: <20051117214647.61520725.gda@domain.hid>
In-Reply-To: <20051117214647.61520725.gda@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE0E153087C59475F1DC45C5D"
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
To: Gerald Dachs <gda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0E153087C59475F1DC45C5D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gerald Dachs wrote:
> Hi,
> 
> I am new to xenomai, sorry if I ask something stupid. 
> I try to use a kernel module with xenomai, but upon loading it
> misses rt_get_time. It looks like it was build with rtai. I have thought
> I could use it with xenomai via the rtai skin.
> In the rtai skin I found only rt_get_time_ns.
> Searching the web I found them both mentioned, I didn't found
> that it is replaced by another function. Is xnpod_get_time the
> same?

Actually, rt_get_time and rt_get_time_ns are the same in the RTAI
compatibility skin (counts are nanoseconds here, see count2nano e.g.).
Therefore, a

static inline RTIME rt_get_time(void) {
	return rt_get_time_ns();
}

should make it into rtai/timer.h (sorry, I have nothing to generate a
patch at hand).

Jan

--------------enigE0E153087C59475F1DC45C5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDfQc5niDOoMHTA+kRAiR9AJ41P9iKRI75zmQJL0Kqo8k+YhBTWgCcC0VD
GLApIGYqhQib3G2V1Ph8UPE=
=1C88
-----END PGP SIGNATURE-----

--------------enigE0E153087C59475F1DC45C5D--

