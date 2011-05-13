Message-ID: <4DCD0B37.40105@domain.hid>
Date: Fri, 13 May 2011 12:43:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
In-Reply-To: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai 2.5.X - 32 bit X86 is not running on
 newer Kernel Versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/13/2011 11:55 AM, Benner Bernd (MH/EES) wrote:
> Hi,
> =20
>    we have a well running X86 Realtime system with Kernel 2.6.29 and
> xenomai-2.4.10. The system is able to boot from a stick and runs on all=

> our computers.
> To fix some X11- problems with newer graphic chipsets, we try to upgrad=
e
> to a newer Kernel version.
> =20
>    We are starting with Kernel 2.6.34.5 and xenomai-2.5.5.2 using the
> latest ADEOS-patches. This system works on some test machines, but on
> some Core 2 Duo 3 GHz systems with Intel Desktop Chipset ( Lenovo and H=
P
> ) the system freeze and/or produces strange console outputs ( only line=

> feeds ) after a start of latency or clocktest.
> We are not able to get a kernel log from this systems.
> =20
>   All permutations of Kernel 2.6.34.5, Kernel 2.6.35.13, xenomai-2.5.3,=

> xenomai-2.5.5.2, xenomai-2.5.6 has the same problems on the Core 2 Duo =
3
> GHz machines.
> On other machines with slower Mobile Core 2 Duo or Pentiom M processors=

> the system runs or has sometimes the same problem.
> =20
>   I have try some changes in the Kernel configuration, without any
> success.  I have also try a combination of Kernel 2.6.35.13. and
> xenomai-2.4.10 with some changes in the xenomai headers to run with
> newer Kernels. This version has the same problem on the Core 2 Duo 3 GH=
z
> systems.
> =20
>   Is there any way to find the reason of this problems with Xenomai
> 2.5.X and newer Kernels 2.6.3X with 32 bit X86 or has anybody similar
> problems fixed.

Have you tried with something more recent than 2.6.34? We had a problem
revealed by grub2, I do not remember which version fixed it. Otherwise,
you have to enable early printk and redirect the console to serial port
or netconsole, in order to capture it from another computer. Without
these logs, there is not much we can do.

Could you post your kernel configuration?

> =20
> Thanks in advance
> =20
> Mit freundlichen Gr=C3=BC=C3=9Fen / Best Regards
> Bernd Benner
> MH/SGT3
> *moehwald*
> *Bosch Group*
> Moehwald GmbH
> Michelinstra=C3=9Fe 21
> 66424 Homburg
> GERMANY
> _www.moehwald.de_
> _b.benner@domain.hid_ <mailto:b.benner@domain.hid>
> Moehwald GmbH, Sitz/Registered Office: Homburg/Saar, Zentrales
> Handelsregister/Registered Court: Saarbr=C3=BCcken HRB 2812
> Gesch=C3=A4ftsf=C3=BChrung/Managing Directors: Jens Last, Wolfgang Geen=
en
> =20
> =20
> =20
> =20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
                                                                Gilles.


