Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Apple Message framework v1278)
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <CAMpYrwA+-Rhr=MvA2sLXFgHp0o7fseukeaoFDhO6Xej-VUjF_A@mail.gmail.com>
Date: Mon, 17 Sep 2012 14:14:41 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D11119A-DE48-4041-843F-DFACB8D4E233@kabelmail.de>
References: <f4e484caea0dc89aaa132406e82ac5ae@theropers.us>
	<70283B31-48C9-4753-A073-993507CF0A96@kabelmail.de>
	<5051E332.8090505@xenomai.org>
	<CAMpYrwA+-Rhr=MvA2sLXFgHp0o7fseukeaoFDhO6Xej-VUjF_A@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai on Beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Oier G. de Albeniz" <gdalbeniz.lists@gmail.com>, xenomai@xenomai.org, adam.r.roper@gmail.com, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Dear all,
>=20
> >> I am interested in getting Xenomai working on the
> >> Beaglebone but I have no previous experience with Xenomai.  I would
> >> greatly appreciate it if you would be willing to share your source
> >> code.=20
>=20
> I would be very interested in it too as I am in the exactly same case =
here. I am also new to xenomai and I would want to test it in a =
beaglebone.
>=20
> >On 13 September 2012 15:44, Gilles Chanteperdrix wrote:
> >We could distribute this work with Xenomai sources,
>=20
> That would be awesome.
>=20
> >On 09/13/2012 03:31 PM, Stephan Kappertz wrote:
> > I can provide a combined patchfile against the vanilla 3.2.21 kernel=20=

>=20
> That would be great too.=20
>=20
> >On 09/13/2012 03:31 PM, Stephan Kappertz wrote:
> > that includes both the AM335x support as provided by Koen Kois git=20=

> >On 07/12/2012 09:54 PM, Stephan Kappertz wrote:
> > I am using the slightly patched kernel from linux-omap
>=20
> In the meanwhile, could you tell us what seems to be the best kernel =
tree to get xenomai working in the beaglebone? I can't find the git repo =
you talk about.
>=20
> Thanks,
>=20
> Gdalbeniz

The problem with an post patch is that it needs to be updated for every =
updated ipipe patch=85

What I could do now is creating a post-patch to the the kernel after =
applying the original ipipe-core-3.2.21-arm.patch to the vanilla kernel. =
I did not update to ipipe-core-3.2.21-arm-1.patch though. Gilles, do you =
have an incremental patch available that I can apply after the original =
patch? Making that patch apply correctly would possibly be less effort =
than starting with the full patch again.

- Stephan





