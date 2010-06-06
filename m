From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1275812358.18250.315.camel@domain.hid>
References: <4C037798.8070307@domain.hid>
	<1275403262-23939-1-git-send-email-P.B.Cheblakov@domain.hid>
	<4C051D3F.2030407@domain.hid> <4C0A8B94.7020207@domain.hid>
	<4C0ABA8F.8000104@domain.hid> <4C0ABE03.9000400@domain.hid>
	<4C0B478A.7060303@domain.hid>
	<1275812358.18250.315.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Jun 2010 11:00:39 +0200
Message-ID: <1275814839.18250.357.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH V3] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-06-06 at 10:19 +0200, Philippe Gerum wrote:
> On Sun, 2010-06-06 at 09:00 +0200, Wolfgang Grandegger wrote:
> > On 06/05/2010 11:13 PM, Gilles Chanteperdrix wrote:
> > > Wolfgang Grandegger wrote:
> > >> On 06/05/2010 07:38 PM, Gilles Chanteperdrix wrote:
> > >>> P.B.Cheblakov wrote:
> > >>>> I'v=D1=83 merged fixes from Wolfgang for Kconfig and for warnings =
in this=20
> > >>>> patch and tested it
> > >>> Thanks, but it seems we still have a few build issues:
> > >>> - the PCI IDs used by this patch are not available in old kernels
> > >>
> > >> OK, this can to be fixed with some "ifndef ..." lines. What kernel d=
id
> > >> make problems?
> > >=20
> > > http://sisyphus.hd.free.fr/~gilles/bx
> >=20
> > OK.
> >=20
> > >>> - the I-pipe patches no longer apply on some stable releases.
> > >>
> > >> I don't understand this issue? What does it have to do with this dri=
ver?
> > >=20
> > > Nothing. It simply showed up at the same time because I had not run t=
he
> > > build test for some time.
> >=20
> > Hm, the error message is quite clear:
> >=20
> > prepare-kernel.sh: Unable to patch kernel 2.6.33.5 with adeos-ipipe-2.6=
.33.4-powerpc-2.9-01.patch
> >=20
> > But it's dissappointing that a successive extraversion breaks the patch=
.
>=20
> ppc64 upstream issue. I've remerged here, I'll push an updated patch in
> the coming hours after some testing.

Should be ok now:
http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.33.5-pow=
erpc-2.10-00.patch

>=20
> >=20
> > Wolfgang.
> >=20
> >=20
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
>=20
>=20


--=20
Philippe.



