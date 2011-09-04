Message-ID: <4E637061.8090605@domain.hid>
Date: Sun, 04 Sep 2011 14:34:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
	<4E635FD3.3010704@domain.hid>
	<CAG0ejMGyNRZCAoyhnQ3A10g21HXxUx66DQjckZYeDUcuAMmAsA@mail.gmail.com>
	<4E636667.4030107@domain.hid>
	<CAG0ejMEmmevXe0yn_=ufgcO7HKLv5+3pV-diuxw4x-rvepuwOQ@mail.gmail.com>
In-Reply-To: <CAG0ejMEmmevXe0yn_=ufgcO7HKLv5+3pV-diuxw4x-rvepuwOQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2BF7E42211E7CA81CD30638E"
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
--------------enig2BF7E42211E7CA81CD30638E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-09-04 14:21, rainbow wrote:
> Is the ipipe patch the same as patch like
> adeos-ipipe-2.6.37.6-x86-2.9-02.patch,

Except that the trace branch is for 2.6.35, yes. More precisely it is
now the same, I just pushed the latest version that includes two more
backported ipipe fixes.

> I know the latter is xenomai patch
> and after I patch it, I can see "Real-time sub-system  ---> " Option. B=
ut If
> I use 2.6.35-x86-trace which contains ,there is no such option.

That menu option is introduced by Xenomai, ie. after running
prepare-kernel.sh. You likely forgot that step.

Note again that you have to use a Xenomai tree with the required ftrace
patches on top if you want Xenomai to generate ftrace events as well.

> Another  problem is that there are so many xenomai gits , how can i dow=
nload
> the correct git?

By cloning the the git repository you obtain all available branches. You
just need to checkout the desired one afterward.

> I am a newby to xenomai and I am sorry to ask so many questions but I w=
ant
> to do something on xenomai :) . Thank you for your detail answers.

Setting up ftrace for Xenomai is not necessarily a newbie task, but I
think I know the background of this. :)

Jan


--------------enig2BF7E42211E7CA81CD30638E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5jcGEACgkQitSsb3rl5xS5NQCaAx3AUF7zJFrBqidfTBkEt4Gm
RtYAoKEiEg5S1tSJAaCEdjBSEq61WZCx
=E8CH
-----END PGP SIGNATURE-----

--------------enig2BF7E42211E7CA81CD30638E--

