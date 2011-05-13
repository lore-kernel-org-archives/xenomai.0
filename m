From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7A76@domain.hid>
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7A76@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 May 2011 14:46:26 +0200
Message-ID: <1305290786.2147.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] WG: Xenomai 2.5.X - 32 bit X86 is not running on
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

On Fri, 2011-05-13 at 14:36 +0200, Benner Bernd (MH/EES) wrote:
> Hi,
>=20
>   i am using a old grub grub-0.97. There is no problem with booting or ea=
rly printk messages. The xenomai services and the linux system including X1=
1- Desktop is starting very well.
>   The system is frozen after the creation of the first real time task in =
user mode. ( latency,clocktest etc. )
>=20
>   We are using a Tinycore 3.x Live Linux distribution for our system whic=
h runs originally with a Kernel 2.6.33. ( but there
> is no X86-ADEOS patch for this Kernel ) I have test kernel 2.6.34.5 and 2=
.6.35.13 and kernel 2.6.37.6.
>   Kernel 2.6.37 do not work with tinycore ( probable UDEV- problems ).
>   Systems 2.6.34 and 2.6.35 are working. The ADEOS/Xenomai patched versio=
ns are working very well, if nobody starts a realtime
> thread.
>=20
>   Here is my Kernel config for Kernel 2.6.35.13, xenomai-2.5.6
>=20
>   When I debug the xenomai latency application the system freeze happens =
after activation of the display task.
> The display task reports the warming up message. The system is frozen bef=
ore the latency task is created.

Sometimes Adeos is at odds with mainline changes in the MTRR code when
it gets preempted by some real-time activity, so it is important to
check the behavior with no X11 started, plain console mode. If things
end up working in this mode, then this might give us some hints about
the issue.

>=20
>=20
> Mit freundlichen Gr=C3=BC=C3=9Fen / Best Regards
> Bernd Benner
> MH/SGT3
> moehwald
> Bosch Group
> Moehwald GmbH
> Michelinstra=C3=9Fe 21
> 66424 Homburg
> GERMANY
> www.moehwald.de
> b.benner@domain.hid
> Moehwald GmbH, Sitz/Registered Office: Homburg/Saar, Zentrales Handelsreg=
ister/Registered Court: Saarbr=C3=BCcken HRB 2812
> Gesch=C3=A4ftsf=C3=BChrung/Managing Directors: Jens Last, Wolfgang Geenen
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Gesendet: Freitag, 13. Mai 2011 12:43
> An: Benner Bernd (MH/EES)
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Xenomai 2.5.X - 32 bit X86 is not running on =
newer Kernel Versions
>=20
> On 05/13/2011 11:55 AM, Benner Bernd (MH/EES) wrote:
> > Hi,
> >
> >    we have a well running X86 Realtime system with Kernel 2.6.29 and
> > xenomai-2.4.10. The system is able to boot from a stick and runs on
> > all our computers.
> > To fix some X11- problems with newer graphic chipsets, we try to
> > upgrade to a newer Kernel version.
> >
> >    We are starting with Kernel 2.6.34.5 and xenomai-2.5.5.2 using the
> > latest ADEOS-patches. This system works on some test machines, but on
> > some Core 2 Duo 3 GHz systems with Intel Desktop Chipset ( Lenovo and
> > HP
> > ) the system freeze and/or produces strange console outputs ( only
> > line feeds ) after a start of latency or clocktest.
> > We are not able to get a kernel log from this systems.
> >
> >   All permutations of Kernel 2.6.34.5, Kernel 2.6.35.13,
> > xenomai-2.5.3, xenomai-2.5.5.2, xenomai-2.5.6 has the same problems on
> > the Core 2 Duo 3 GHz machines.
> > On other machines with slower Mobile Core 2 Duo or Pentiom M
> > processors the system runs or has sometimes the same problem.
> >
> >   I have try some changes in the Kernel configuration, without any
> > success.  I have also try a combination of Kernel 2.6.35.13. and
> > xenomai-2.4.10 with some changes in the xenomai headers to run with
> > newer Kernels. This version has the same problem on the Core 2 Duo 3
> > GHz systems.
> >
> >   Is there any way to find the reason of this problems with Xenomai
> > 2.5.X and newer Kernels 2.6.3X with 32 bit X86 or has anybody similar
> > problems fixed.
>=20
> Have you tried with something more recent than 2.6.34? We had a problem r=
evealed by grub2, I do not remember which version fixed it. Otherwise, you =
have to enable early printk and redirect the console to serial port or netc=
onsole, in order to capture it from another computer. Without these logs, t=
here is not much we can do.
>=20
> Could you post your kernel configuration?
>=20
> >
> > Thanks in advance
> >
> > Mit freundlichen Gr=C3=BC=C3=9Fen / Best Regards Bernd Benner
> > MH/SGT3
> > *moehwald*
> > *Bosch Group*
> > Moehwald GmbH
> > Michelinstra=C3=9Fe 21
> > 66424 Homburg
> > GERMANY
> > _www.moehwald.de_
> > _b.benner@domain.hid_ <mailto:b.benner@domain.hid> Moehwald GmbH,
> > Sitz/Registered Office: Homburg/Saar, Zentrales
> > Handelsregister/Registered Court: Saarbr=C3=BCcken HRB 2812
> > Gesch=C3=A4ftsf=C3=BChrung/Managing Directors: Jens Last, Wolfgang Geen=
en
> >
> >
> >
> >
> >
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> --
>                                                                 Gilles.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



