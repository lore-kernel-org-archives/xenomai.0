Message-ID: <49C4AD34.7010303@domain.hid>
Date: Sat, 21 Mar 2009 10:02:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1237546591.9844.115.camel@domain.hid>	<49C381F8.9070107@domain.hid>
	<1237563537.9844.150.camel@domain.hid>
In-Reply-To: <1237563537.9844.150.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34C1391C2C5D674A8AEC98EA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtserial interface stalls
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vikesh Rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34C1391C2C5D674A8AEC98EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Vikesh Rambaran wrote:
> On Fri, 2009-03-20 at 12:46 +0100, Jan Kiszka wrote:
>> Vikesh Rambaran wrote:
>>> ...
>>> Alternative tried (after a bit of debugging)
>>> -----------------
>>>
>>> Changed  serialConfig.tx_timeout       =3D RTSER_DEF_TIMEOUT;
>>> to       serialConfig.tx_timeout       =3D RTDM_TIMEOUT_NONE;
>>>
>>> Task 2 then runs continuously. Writing to rtser0 returns valid number=
 of
>>> bytes written but no data appears on serial port pin. At the same tim=
e
>>> rtser1 functions normally.
>> Without feedback from the device about its tx queue state you may
>> quickly overload it this way (definitely if written bytes > fifo lengt=
h).
>>
>=20
> The idea is to write data into the devices' circular buffer and return
> immediately. If there is not enough place in the buffer, i expected
> the write call to return an error code or fewer bytes than that which
> was requested. That would indicate a buffer overrun condition which can=

> be flagged at application level. This way the task will not be delayed
> and other important functionality can be executed in a deterministic
> way.
>=20
> The data transmitted on each serial channel is less than 150 bytes at
> 115200kb/s with the task having a fixed period of 20mS. This should not=

> overflow default 4k buffers of the 16550A driver.
>=20
> Well that's the plan:) Did i perhaps misunderstand the implementation
> for the tx_timeout ?
>=20

No, I agree your approach is valid, and even non-blocking write should
behave as you expected. I actually forgot that the uart driver is that
smart - at least in theory. Something else is fishy.

When you switch to non-blocking, is there no data at all written, or
does transmission stop roughly around where blocking write would stop
the writer?

Jan


--------------enig34C1391C2C5D674A8AEC98EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknErTgACgkQniDOoMHTA+mKugCfRZwglFPXfiSLhrdqB3+/FkMd
bugAnAuD/t0BOEtFSM7v+Q2XrFp1QRrr
=iBdH
-----END PGP SIGNATURE-----

--------------enig34C1391C2C5D674A8AEC98EA--

