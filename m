Message-ID: <46E25EBE.90700@domain.hid>
Date: Sat, 08 Sep 2007 10:35:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46DFD2EA.6000202@domain.hid> <46E07430.2060309@domain.hid>
	<46E15E3B.50706@domain.hid>
In-Reply-To: <46E15E3B.50706@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE80B0B41AB3B5130DFDA0797"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE80B0B41AB3B5130DFDA0797
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Patrick wrote:
>=20
> Jan Kiszka a =E9crit :
>> Patrick wrote:
>>  =20
>>> Hy,
>>>
>>> I don't understand the difference between rtdm function and standard =
function.
>>> For exemple what is the diffrence between rtdm_printk and printk=20
>>>    =20
>>
>> Technically? None these days (printk is provided RT-safe by
>> Adeos/I-pipe), but it documents that the message may be printed from R=
T
>> context. And who know if some future RTDM implementation may not have =
to
>> differentiate internally again...
>>
>>  =20
>>> or rtdm_malloc=20
>>> and malloc ?
>>>    =20
>>
>> You mean kmalloc (malloc is user space only)? rtdm_malloc provides
>> memory from a dedicated pool (dedicated to Xenomai, excluding Linux) a=
nd
>> uses a predictable allocator (as long as the memory usage pattern is
>> predictable). kmalloc is non-deterministic, and is shared with the who=
le
>> Linux kernel.
>>  =20
> Yes I use kmalloc... sorry
> So kmalloc and rtdm_kmalloc is exactly the same ?

They share the same purpose, but details differ, just look at the
function arguments...

>=20
>>  =20
>>> I am developping an RT driver so I must simply used only functions rt=
dm ?
>>>    =20
>>
>> Regarding the two services above: Depends on the context. If they run =
in
>> non-RT driver cleanup or device instantiation context, you should
>> continue to use standard Linux services. Just for usage from RT contex=
ts
>> (tasks, IRQ handlers (please don't allocate memory in the latter
>> context, though...)) switch to those RTDM variants.
>>
>> Jan
>>
>>  =20
> For IRQ handlers I use the rt_intr_ functions it's not right ? what is =
the difference between this functions and th rtdm_irq ?

Besides details, the main point is that you shall not mix APIs in your
driver if you want to keep it portable to future RTDM environment.

>=20
> Do you have an simple trivial exemple of rtdm driver with irq ?

We still need to add such a tutorial to the RTDM series. In the
meantime, you could have a look at irqbench from the testsuite for a
more simple scenario. But, of course, you can also dig inside the other
RTDM drivers in-tree or beyond, they are just not that simple.

Jan


--------------enigE80B0B41AB3B5130DFDA0797
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG4l6+niDOoMHTA+kRAhfmAJwIZ2iyFuREsEIQvF4aLaAKJpAenQCeMVKP
/qKfXtTlEJ74xmK1JKwW6tM=
=vP+K
-----END PGP SIGNATURE-----

--------------enigE80B0B41AB3B5130DFDA0797--

