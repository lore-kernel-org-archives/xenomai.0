Message-ID: <44D0970D.6060008@domain.hid>
Date: Wed, 02 Aug 2006 14:14:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Reading Memory Mapped IO
References: <353F6272FE0A6544AA97D47F761F486B01707FDF@ples506a.stcl.siemens.co.uk>
	<44D09177.8080001@domain.hid>
In-Reply-To: <44D09177.8080001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F7F7BE112038D0AB30616FD"
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
To: "Doyle, Alan" <alan.doyle@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F7F7BE112038D0AB30616FD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Doyle, Alan wrote:
>> Hi,
>>
>> I have an application where I need to read four contiguous memory mapp=
ed
>> data registers in response to an interrupt. As its real time critical =
I
>> intend to implement the read in Xenomai. Having read and processed the=

>> data it later needs to be passed to a Linux domain application, I am
>> hoping to use a Posix message queue for this purpose.
>>
>> I seem to have two options as to how to implement this, I could regist=
er
>> the interrupt in a Xenomai user space thread and mmap the data registe=
rs
>> so that on receiving the interrupt the registers could be read.
>> Alternatively I could write a Xenomai RTDM driver to read the register=
s
>> on interrupt and use the driver read call from the Xenomai user space
>> thread to access register data. In each case the data would then be
>> passed to the Linux domain via a message to a Posix queue - after some=

>> further processing that is not real time critical.
>>
>> Could you enlighten me as to the pros and cons of each approach, I am
>> particularly unclear as to the implications of using mmap in the Xenom=
ai
>> domain and what if any affect it might have on the real time
>> responsiveness (I understand mmap() to be a call back into the Linux
>> kernel rather than to the Xenomai nucleus).
>=20
> To call mmap from real-time code is actually a generic issue. If you
> look at the design of other time-critical, though not hard-RT drivers
> like video4linux, they also try to avoid mmap'ing on demand. Instead on=
e
> should set up mappings ahead-of-time during device initialisation. Use
> rings of premapped buffers that cycle between the driver and the
> application.

One thing I forgot to mention: likely you want to have a look at
rtdm_mmap_to_user() for this purpose.

Jan


--------------enig9F7F7BE112038D0AB30616FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0JcNniDOoMHTA+kRAid9AJ9zNsgW9Wz6ZmkbgoGZrBLOcrivqACeMPEo
rfEvh6g1ib0PDzEbmb22F2g=
=S06Q
-----END PGP SIGNATURE-----

--------------enig9F7F7BE112038D0AB30616FD--

