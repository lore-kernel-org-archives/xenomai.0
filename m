Message-ID: <4E63829E.1090500@domain.hid>
Date: Sun, 04 Sep 2011 15:52:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
	<4E635FD3.3010704@domain.hid>
	<CAG0ejMGyNRZCAoyhnQ3A10g21HXxUx66DQjckZYeDUcuAMmAsA@mail.gmail.com>
	<4E636667.4030107@domain.hid>
	<CAG0ejMEmmevXe0yn_=ufgcO7HKLv5+3pV-diuxw4x-rvepuwOQ@mail.gmail.com>
	<4E637061.8090605@domain.hid>
	<CAG0ejMFKjFdvhXWLabv5+V8sJy=OXdpP=XZAUasHS2PEGqTg8g@domain.hid>
In-Reply-To: <CAG0ejMFKjFdvhXWLabv5+V8sJy=OXdpP=XZAUasHS2PEGqTg8g@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C96F4BABABC5F6976020D7C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xenomai-core ftrace
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rainbow <lvqq05@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C96F4BABABC5F6976020D7C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-09-04 15:16, rainbow wrote:
> 2011/9/4 Jan Kiszka <jan.kiszka@domain.hid>
>=20
>> On 2011-09-04 14:21, rainbow wrote:
>>> Is the ipipe patch the same as patch like
>>> adeos-ipipe-2.6.37.6-x86-2.9-02.patch,
>>
>> Except that the trace branch is for 2.6.35, yes. More precisely it is
>> now the same, I just pushed the latest version that includes two more
>> backported ipipe fixes.
>>
>>> I know the latter is xenomai patch
>>> and after I patch it, I can see "Real-time sub-system  ---> " Option.=
 But
>> If
>>> I use 2.6.35-x86-trace which contains ,there is no such option.
>>
>> That menu option is introduced by Xenomai, ie. after running
>> prepare-kernel.sh. You likely forgot that step.
>>
>=20
>=20
>> Yes,I forget the step. So I think I only have to run prepare-kernel.sh=

>> --arch=3Dx86_64
>=20
> --linux=3D2.6.35-x86-trace  , I do not need --adeos option because
>> the 2.6.35-x86-trace contains the ipipe patch.
>>
>=20
>=20
>=20
>> Note again that you have to use a Xenomai tree with the required ftrac=
e
>> patches on top if you want Xenomai to generate ftrace events as well.
>>
>> "Xenomai tree with required ftrace patches on top" you mean the branch=

> "remotes/origin/queues/ftrace"?

Yep. I just pushed a rebased version of current git master.

Jan


--------------enig0C96F4BABABC5F6976020D7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5jgp4ACgkQitSsb3rl5xSL+wCfa+cuNNTFmRnYLEE8+7fqbtKC
pRwAoLvT+okYZt6lj9YlvGHo6DKMBzWO
=Vna3
-----END PGP SIGNATURE-----

--------------enig0C96F4BABABC5F6976020D7C--

