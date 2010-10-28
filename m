Message-ID: <4CC94E0B.9070106@domain.hid>
Date: Thu, 28 Oct 2010 12:18:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid> <4CC84327.9070202@domain.hid>
	<4CC92786.3030509@domain.hid> <4CC92902.4040904@domain.hid>
	<4CC943A2.9020806@domain.hid>
In-Reply-To: <4CC943A2.9020806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigECCCF1249B1F2FB6410D861E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RTnet-users] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: rtnet-developers@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECCCF1249B1F2FB6410D861E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 28.10.2010 11:34, Anders Blomdell wrote:
> Jan Kiszka wrote:
>> Am 28.10.2010 09:34, Anders Blomdell wrote:
>>> Anders Blomdell wrote:
>>>> Anders Blomdell wrote:
>>>>> Hi,
>>>>>
>>>>> I'm trying to use rt_eepro100, for sending raw ethernet packets,
>>>>> but I'm
>>>>> experincing occasionally weird behaviour.
>>>>>
>>>>> Versions of things:
>>>>>
>>>>>   linux-2.6.34.5
>>>>>   xenomai-2.5.5.2
>>>>>   rtnet-39f7fcf
>>>>>
>>>>> The testprogram runs on two computers with "Intel Corporation
>>>>> 82557/8/9/0/1 Ethernet Pro 100 (rev 08)" controller, where one
>>>>> computer
>>>>> acts as a mirror sending back packets received from the ethernet (o=
nly
>>>>> those two computers on the network), and the other sends packets an=
d
>>>>> measures roundtrip time. Most packets comes back in approximately 1=
00
>>>>> us, but occasionally the reception times out (once in about 100000
>>>>> packets or more), but the packets gets immediately received when
>>>>> reception is retried, which might indicate a race between
>>>>> rt_dev_recvmsg
>>>>> and interrupt, but I might miss something obvious.
>>>> Changing one of the ethernet cards to a "Intel Corporation 82541PI
>>>> Gigabit Ethernet Controller (rev 05)", while keeping everything else=

>>>> constant, changes behavior somewhat; after receiving a few 100000
>>>> packets, reception stops entirely (-EAGAIN is returned), while
>>>> transmission proceeds as it should (and mirror returns packets).
>>>>
>>>> Any suggestions on what to try?
>>> Since the problem disappears with 'maxcpus=3D1', I suspect I have a S=
MP
>>> issue (machine is a Core2 Quad), so I'll move to xenomai-core.
>>> (original message can be found at
>>> http://sourceforge.net/mailarchive/message.php?msg_name=3D4CC82C8D.30=
80808%40control.lth.se
>>> )
>>>
>>> Xenomai-core gurus: which is the corrrect way to debug SMP issues?
>>> Can I run I-pipe-tracer and expect to be able save at least 150 us of=

>>> traces for all cpus? Any hints/suggestions/insigths are welcome...
>>
>> The i-pipe tracer unfortunately only saves traces for a the CPU that
>> triggered the freeze. To have a full pictures, you may want to try my
>> ftrace port I posted recently for 2.6.35.
> 2.6.35.7 ?
>=20

Exactly.

Jan


--------------enigECCCF1249B1F2FB6410D861E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzJTg4ACgkQitSsb3rl5xRGIQCfT5Ck22Mq3CxGAPBsQBErql8O
DGUAnisu+mmlzBxsozQxp8FBYGP7qn93
=4oY4
-----END PGP SIGNATURE-----

--------------enigECCCF1249B1F2FB6410D861E--

