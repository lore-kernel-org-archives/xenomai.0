Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 12 Feb 2008 16:23:08 +0100
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <OFBC4D9AEC.79F3468F-ONC12573ED.004C30FC-C12573ED.004C9297@domain.hid>
Message-ID: <20080212152308.299870@domain.hid>
MIME-Version: 1.0
References: <OFBC4D9AEC.79F3468F-ONC12573ED.004C30FC-C12573ED.004C9297@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Which kernel version fits with a xenomai release
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "G.P.M. Haagh" <g.p.m.haagh@domain.hid>, xenomai@xenomai.org

>=20
> Hoi,
>=20
> I am a newbie. I have difficulty understanding what Xenomai / Adeos and
> Linux kernel versions fit together and are actually tested.
> How do you find out, where is this documented....
>=20
> More specific situation:
>       Ubuntu 7.10 (standard with 2.6.22.14 kernel)
>       Dell Optiplex 755 (has very new ethernet controller from Intel not
> coming with 2.6.22/.23 kernels). Ubuntu provides extra kernel e1000-ich9
> module.
>=20
> Any advise on 'recent' kernel/Xenomai versions to use?
>=20
> thanx,
> Gerard Haagh

Hi Gerard,

you find the matching kernel versions in ksrc directory. If you have an x86=
 architecture, check http://svn.gna.org/viewcvs/xenomai/tags/v2.4.2/ksrc/ar=
ch/x86/patches/ for the latest official xenomai release and you see the lin=
ux kernel versions supported by xenomai 2.4.2. It also contains a README pr=
oving further details.
If none of this patches is matching your desired (or because of the NIC nee=
ded) linux kernel version, I suggest to try out the trunk version.

Best regards
Karl
--=20
von Karl Reichert

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger

