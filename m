Message-ID: <4423E426.1010206@domain.hid>
Date: Fri, 24 Mar 2006 13:20:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: read data from serial device
References: <dvrrgc$g2a$1@domain.hid>	<dvu50v$5pq$1@domain.hid>	<44229953.3090002@domain.hid>	<dvu5ud$90v$1@domain.hid>
	<4422A10B.90508@domain.hid>
In-Reply-To: <4422A10B.90508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16B7FA0567487966E82FCB9C"
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
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16B7FA0567487966E82FCB9C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Marco Jackel wrote:
>> Hi,
>>
>> Philippe Gerum wrote:
>>
>>> Marco Jackel wrote:
>>>
>>>> "rt_dev_read" gives negative Results. Whats wrong?
>>>
>>> Which negative code is returned exactely?
>>
>> It returns -5
>=20
> -EIO. Except for traditional RTOS skins like VxWorks, VRTX and so on
> which have their own error list, we tend to normalize on POSIX error
> codes in all other parts of the codebase.
>=20
> Regarding the EIO issue, it looks like a transmission error has been
> detected on the read-side by the 16650A driver. Jan will likely tell yo=
u
> more when time allows.

Are you sure that you transmit with the correct baud rate and line
settings? In your rtser_config I see that you use odd parity. I think
Linux default is no parity bit.

>=20
>>
>> Are the error-codes documented somewehere?
>>
>=20
> Yes, the documentation link on our website is a good starting point. Fo=
r
> the particular EIO issue on the serial driver, I'm not sure there is a
> lot more explanations than the one above, though.

Oops, undocumented return code in the profile. Need to be fixed. Yes,
it's indeed some hardware/bit error that is expressed with EIO.

Jan


PS: A cleaned-up version of the serial port demo code can currently be
found at http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon.

PPS: I'm examining the reason for your crash ATM. Should not happen.


--------------enig16B7FA0567487966E82FCB9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEI+QmniDOoMHTA+kRAu64AJ9cGcPnqM370zFyddYICksMs58CEQCfXGCo
iSGGv1VQkCiBHkPC5c5Xl8U=
=CheK
-----END PGP SIGNATURE-----

--------------enig16B7FA0567487966E82FCB9C--

