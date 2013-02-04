Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Apple Message framework v1283)
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <9EFD9D88-FCCB-489A-9DA9-06A8C8AFE8EA@kabelmail.de>
Date: Mon, 4 Feb 2013 14:28:40 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <335BAC77-AB58-4E49-B573-FD7FCB2645FC@kabelmail.de>
References: <mailman.0.1359630001.19052.xenomai@xenomai.org>
	<9EFD9D88-FCCB-489A-9DA9-06A8C8AFE8EA@kabelmail.de>
Subject: Re: [Xenomai] Ipipe pre and post patch for AM335x beagleBone/
	koenkooi branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 31.01.2013 um 15:17 schrieb Stephan Kappertz:

>=20
>>> Hi All,
>>>=20
>>> sorry for the long delay. As Gilles suggested I have prepared a pre =
and post patch for ipipe-core-3.2.21-arm-4 and the git repository =
supporting BeagleBone here: =
https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr7=
20e07b4c1f687b61b147b31c698cb6816d72f01 . Should I send the patches to =
the list?
>>>=20
>>> - Stephan
>>=20
>> I think that you should.
>>=20
>> Goran
>>=20
>=20
> Here they are.
> Usage:
>=20
> * clone git repository =
https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr7=
20e07b4c1f687b61b147b31c698cb6816d72f01
>=20
> * checkout linux-ti33x-psp-3.2.21-r13g
>=20
> * apply pre.patch
>=20
> * run xenomai (tested with 2.6.2.1) prepare-kernel.sh
>=20
> * apply post.patch
>=20
> * Configure & compile kernel
>=20
> - Stephan
>=20
> <beagleBone_pre_post_patches.tar.bz2>
>=20
>=20
>=20

FWIW:

You can also apply the above pre/post patch to the other repository that =
Michael Haberle mentioned:

HowTo:

* git clone git://github.com/beagleboard/kernel.git

* git checkout origin/beaglebone-3.2 -b beaglebone-3.2

* edit patch.sh to not apply patches beyond 3.2.21:

#PATCHSET=3D"usb psp 3.2.1 3.2.2 3.2.3 3.2.4 3.2.5 3.2.6 3.2.7 3.2.8 =
3.2.9 3.2.10 3.2.11 3.2.12 3.2.13 3.2.14 3.2.15 3.2.16 3.2.17 3.2.18 =
3.2.19 3.2.20 3.2.21 3.2.22 3.2.23 3.2.24 3.2.25 3.2.26 3.2.27 3.2.28 =
3.2.29 3.2.30 3.2.31 3.2.32 3.2.33 3.2.34 led libertas pwm mfd =
beaglebone"

PATCHSET=3D"usb psp 3.2.1 3.2.2 3.2.3 3.2.4 3.2.5 3.2.6 3.2.7 3.2.8 =
3.2.9 3.2.10 3.2.11 3.2.12 3.2.13 3.2.14 3.2.15 3.2.16 3.2.17 3.2.18 =
3.2.19 3.2.20 3.2.21 led libertas pwm mfd beaglebone"

* patch -p1 < pre.patch
* prepare-kernel.sh --arch=3Darm --linux=3D.
* patch -p1 < post.patch

* configure, compile=85=20

- Stephan=


