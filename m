Message-ID: <4C36D8A0.80404@domain.hid>
Date: Fri, 09 Jul 2010 10:06:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
In-Reply-To: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomia adeos pacht error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

G=C3=B6rkem Karado=C4=9Fan wrote:
> hi all,
>=20
> i follow this install introduction (
> http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL)
>=20
> and i write this code
>=20
> /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \
>   --adeos=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.20=
-arm-*
> \
> --linux=3D/opt/linux-02.01.03.11/
>=20
> and i got this error codes
>=20
> Hunk #1 FAILED at 156.
> 1 out of 1 hunk FAILED -- saving rejects to file mm/vmalloc.c.rej
> prepare-kernel.sh: Unable to patch kernel 2.6.29-rc3 with
> adeos-ipipe-2.6.20-arm-1.8-03.patch.
>=20
> i use linux-02.01.03.11 because of omap3530. Do you know which pacht is=
 able
> with kernel 2.6.29.rc3..

It seems I am having a hard time to get understood this days. I do not
know what linux-02.01.03.11 is, and I do not really care, but it is not
the mainline kernel. As I told you in the answer to your previous
question here:
https://mail.gna.org/public/xenomai-help/2010-07/msg00078.html
We only provide Adeos patches for the mainline kernel.

--=20
					    Gilles.


