Message-ID: <4D55ACC8.1030104@domain.hid>
Date: Fri, 11 Feb 2011 22:40:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <327302.79333.qm@domain.hid>
In-Reply-To: <327302.79333.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] USB and C++?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R2VuZ2lzIEthbmhnIFRvbGVkbyBSYW3DrXJleg==?= <gengiskanhg.geo@domain.hid>
Cc: xenomai@xenomai.org

Gengis Kanhg Toledo Ram=C3=ADrez wrote:
> Hello to every one:
>=20
> First, I would like to congratulate this effort called Xenomai as well =
as its=20
> community.
>=20
> My questions to you are these
>=20
> 1. Is it possible to use XENOMAI with the USB port? in hard or soft mod=
e?

We do not talk about hard and soft mode with Xenomai.

If what you want to do is have a Xenomai appliation, and being able to
use an USB device, then yes, it should work.

If what you want to do is access an USB device from a Xenomai thread
running in primary domain, then it will work if you write a driver for
this device using RTDM. There is an USB4RT USB stack, but I do not know
in which state it currently is.

> 2. What about porting a C++ application to XENOMAI? I know there is a g=
uide=20
> related to RTAI, but it is from 2004=20

This should not need anything special.

>=20
> (http://people.mech.kuleuven.be/~psoetens/portingtolxrt.html)
> 3. Which one is the recommended distro for this?

You do not have much choice here: the only distributions for which we
provide the necessary stuff are the .deb based one. That would be Debian
or Ubuntu, maybe others, I do not know.

--=20
                                                                Gilles.


