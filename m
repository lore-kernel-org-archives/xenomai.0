Message-ID: <4399CA00.6010905@domain.hid>
Date: Fri, 09 Dec 2005 19:16:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Commercial use of Xenomai
References: <B4D14EA407C38B4DAF92B8EAC9249D7F01788ACA@mspex01.go.mts.com>
In-Reply-To: <B4D14EA407C38B4DAF92B8EAC9249D7F01788ACA@mspex01.go.mts.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
Cc: xenomai@xenomai.org

Rosenow, Jim wrote:
> First let me start by saying I apologize if xenomai-help is the wrong=20
> list, I found a xenomai-main which I though more likely the correct lis=
t=20
> but it has had no activity.
>

Xenomai-main is a hidden and dead list. Active lists are listed here:
http://gna.org/mail/?group=3Dxenomai

> =20
>=20
> I had been following fusion for some time with an eye toward the=20
> possibility of commercial use due to it being user-space real-time and=20
> thus more likely to allow protection of intellectual property.  I=92m=20
> pleased to see a continuation of fusion in the Xenomai project.
>=20
> =20
>=20
> =20
>=20
> I=92ve searched the archives for license details and have only found=20
> reference to GPL V2.
>=20

Look harder: e.g. skins/native/lib/COPYING (v2.0.x) or=20
src/skins/native/COPYING (v2.1). LGPL inside.

> =20
>=20
> My primary question is if a user space Xenomai real-time application is=
=20
> considered a derivate work and thus is subject to be GPL=92d?
>=20
> =20

1. Xenomai libraries that provide system call wrappers to invoke the=20
real-time nucleus services from user-space are LGPL. E.g. libnative.so=20
and libpthread_rt.so. Application-wise, those have the same role with=20
respect to the Xenomai nucleus than the glibc has with respect to the=20
Linux kernel. This is likely what you want to use.

2. Xenomai libraries that provide the UVM support are licensed under the=20
GPL, with a specific exception clause that basically says that mere=20
linking against such unmodified libraries does not cause by itself the=20
application to be covered by the GPL. Rationale: UVM support is mainly=20
composed of GPLed kernel-based code (nucleus, various RTOS skins), but=20
compiled for a different execution environment, so that the UVM can run=20
it over a virtual machine layer, all of this being in the context of a=20
regular Linux process in user-space. For this reason, the base license=20
remains the GPL, but the exception is there for what is worth.

3. All Xenomai code running in Linux kernel space is GPL.

4. All Xenomai code implementing the simulator (i.e. sim/ directory) is G=
PL.

--=20

Philippe.

