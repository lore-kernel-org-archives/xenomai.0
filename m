Message-ID: <4444D5F6.2010006@domain.hid>
Date: Tue, 18 Apr 2006 14:05:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] CONFIG_PREEMPT doesn't work with ADEOS
References: <20060418131428.31f735e9@domain.hid>
	<4444D12B.6040901@domain.hid> <4444D277.4040306@domain.hid>
In-Reply-To: <4444D277.4040306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9EB09D9CBFA5F33B3D5A8998"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9EB09D9CBFA5F33B3D5A8998
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Bernhard Walle wrote:
>>
>>> Hello,
>>>
>>> I have a kernel 2.6.15.6 with
>>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.15-i3=
86-1.2-03.patch
>>>
>>> patch. In this configuration, CONFIG_PREEMPT doesn't work any more,
>>> i.e. the kernel is not preempted.
>>>
>>
>> How do you check this?
>>
>=20
> Forget about this question. I'm going to give a look at your testcase
> when time allows. Thanks.
>=20

I did, and I can confirm this (2.6.16, original ipipe-1.2-03 applied,
ipipe on vs. off). Maybe something related to the TASK_ATOMICSWITCH chang=
es?

>>> With the kernel without ADEOS patch, it works fine. A test program is=

>>> at http://www.bwalle.de/temp/kern-preempt.tar.bz2.
>>>
>>> Do you know what's wrong?
>>>
>>>
>>> Regards,
>>>   Bernhard
>>
>>
>>

Jan


--------------enig9EB09D9CBFA5F33B3D5A8998
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERNX5niDOoMHTA+kRAg2ZAJ9IVMVsh2BYcSb1keMThZiEeyoA4wCdHv9W
3ZrB0cKHQ9RK2jsqqvQod4w=
=o4ra
-----END PGP SIGNATURE-----

--------------enig9EB09D9CBFA5F33B3D5A8998--

