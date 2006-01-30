Message-ID: <2F8EE677D406514ABE53EF9C0934A666017CB023@domain.hid>
From: Dominique.RAGOT@fr.thalesgroup.com
Subject: RE: [Xenomai-help] Dual Xeon, 2.6.10, adeos-r13
Date: Mon, 30 Jan 2006 14:51:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: villaume@domain.hid, xenomai@xenomai.org

Hello,

I am using a dual Xeon with 2.6.13 with xenomai 2.0 and adeos-r13 =
without any problem on FC3. The SMP support is very good on this =
system. At one time there were some stalls with the default parameters =
sent to the kernel, namely rhgb. We have suppressed them (rhgb quiet) =
when booting with our recompiled kernels. If this doesn't help, I =
propose to have a look at your .config file.

Regards,

----------
Dominique RAGOT
THALES Land & Joint Systems
    160, bd de Valmy - BP 82
    F-92704 Colombes Cedex - France
Tel: +33 (0)1 46 13 24 41      Fax: +33 (0)1 46 13 34 01


> -----Message d'origine-----
> De : xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid la part de Nathaniel Villaume
> Envoy=E9 : mercredi 25 janvier 2006 20:11
> =C0 : xenomai@xenomai.org
> Objet : [Xenomai-help] Dual Xeon, 2.6.10, adeos-r13
>=20
>=20
> Hi all,
>=20
> I can't seem to find any info about Dual Xeon and Xenomai=20
> (well, ADEOS,=20
> really). Is this a configuration that is expected to work? =20
> What about=20
> smp Athlon? or DualCore Athlon? (I think Opteron is not in=20
> the picture=20
> yet, right?)
>=20
> For the dual Xeon, I'm able to patch and build fine, but boot stalls=20
> after the hardware has been initialized by the init process.
> (i.e. The last line I get from Fedora Core 3 Init 2.85 booting says:=20
> Initializing hardware... storage network, audio done [ok])
>=20
> I've done what I think are correct:
> - turned off HyperThreading in both bios and in kernel config
> - disabled REGPARM
>=20
> The Processor family  is set to Pentium 4 and sub arch is set=20
> to Generic=20
> architecture (X86_GENERICARCH), but I've also tried Pc=20
> Compatible (X86)=20
> to  the same effect.
> I used an adeos-r9 patch that came with RTAI, and I at least got the=20
> system to boot. But RTAI puked when loading the SMP scheduler....
>=20
> Is there anything else I might do to make this work?  What is the=20
> confidence level in SMP support?
>=20
> Thanks,
> -Nate
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

