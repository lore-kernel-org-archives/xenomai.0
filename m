Date: Fri, 7 Nov 2014 13:47:59 +0100 (CET)
From: tbultel@free.fr
Message-ID: <586279251.109308096.1415364479248.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <20141107095222.GD6724@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: tbultel@free.fr
> Cc: xenomai@xenomai.org, "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca=
>
> Envoy=C3=A9: Vendredi 7 Novembre 2014 10:52:22
> Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.=
18-14 -> very slow boot
>=20
> On Fri, Nov 07, 2014 at 10:48:43AM +0100, tbultel@free.fr wrote:
> >=20
> >=20
> > ----- Mail original -----
> > > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > > =C3=80: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
> > > Cc: tbultel@free.fr, xenomai@xenomai.org
> > > Envoy=C3=A9: Jeudi 6 Novembre 2014 17:08:21
> > > Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
> > > adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
> > >=20
> > > On Thu, Nov 06, 2014 at 11:04:57AM -0500, Lennart Sorensen wrote:
> > > > On Thu, Nov 06, 2014 at 03:41:47PM +0100, tbultel@free.fr
> > > > wrote:
> > > > > Gilles, we do not have CONFIG_ARM_ERRATA_754327 enabled
> > > > > It is -not- enabled in the evaluation kernel that is provided
> > > > > by
> > > > > the
> > > > > manufacturer.
> > > > > That errata is said to be for CPU revs < r2p0
> > > > >=20
> > > > > I am a little bit puzzled about the naming conventions for
> > > > > the
> > > > > CPU revision,
> > > > > uboot says rev1.2, the kernel says
> > > > >=20
> > > > > Processor=09: ARMv7 Processor rev 10 (v7l)
> > > > > ...
> > > > >=20
> > > > > CPU implementer=09: 0x41
> > > > > CPU architecture: 7
> > > > > CPU variant=09: 0x2
> > > > > CPU part=09: 0xc09
> > > > > CPU revision=09: 10
> > > > >=20
> > > > > how can I do the matching ?
> > > > >=20
> > > > > Meanwhile, we noticed that compared to the evaluation kernel,
> > > > > we
> > > > > were missing
> > > > > CONFIG_ARM_ERRATA_754322 and CONFIG_PL310_ERRATA_769419
> > > > >=20
> > > > > Adding them helps a lot, but the freeze still happens on one
> > > > > machine
> > > > >=20
> > > > > We are currently trying with 754322 + 769419 + 754327 + 5
> > > > > nops in
> > > > > fec ...
> > > > > but not sure if we need 754327.
> > > > >=20
> > > > > Regards
> > > > > Thierry
> > > > >=20
> > > > > PS: Regarding the thermal issue, we have changed our
> > > > > supplier, we
> > > > > now have
> > > > > a dissipator that is big enough (it is the AMOS820 from Via
> > > > > Embedded)
> > > >=20
> > > > I am not sure how to read the A9 revision.  I have this on a
> > > > system:
> > >=20
> > > I have found the method I gave in ARM documentation. I am pretty
> > > sure this is how it works.
> > >=20
> > > --
> > > =09=09=09=09=09    Gilles.
> > >=20
> >=20
> >=20
> > Gille,
> > we agree that as we have a r2p10, the 754327 does not apply.
> > Thus the only erratas I was missing are CONFIG_ARM_ERRATA_754322
> > and CONFIG_PL310_ERRATA_769419,
> > that are in ./arch/arm/configs/imx6_defconfig
> > They are now part of my config.
> > Unfortunately, the network stress test still makes the freeze
> > happen with CONFIG_IPIPE enabled
> >=20
> > How come can that freeze only happen on -some- machines (they all
> > have the same CPU rev),
> > and that the time they stay up is dependent on them ?
> > If the freeze was reproducible without CONFIG_IPIPE, we could
> > easily say that it is simply
> > an hardware bug but unfortunately with is not the case.
> >=20
> > A new info: the machine that freezes the most also freezes with
> > ethernet fec unplugged.
> > All these machines work fine with CONFIG_IPIPE disabled.
>=20
> Well, you told me that you had freezes because of the mb() in the
> FEC code, all that I can tell you is that the bug I know related to
> mb() would probably be fixed by adding nops before the mb(). It is
> not clear to me, have you tried that?
>=20
> --

The freeze happens faster with he mb(), yes.
But it is still there without it, or when adding the 5 nops before.
And if the ethernet is unplugged (which normally leads to the code=20
we mention not to be called),  we have the bug, too.
I have just made a test with a ethernet on USB adapter and it freezes the s=
ame way.

Thierry
> =09=09=09=09=09    Gilles.
>=20

