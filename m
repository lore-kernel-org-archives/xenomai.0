Date: Wed, 20 Dec 2017 11:23:34 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171220112334.122950fb@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <A396DD4B-B1F2-404E-917E-F86FBA90918E@korgrd.com>
References: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
 <44y3lywp2s.fsf@lowell-desk.lan>
 <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com>
 <d56f3f8e-44e0-be07-b832-bb84d93d4df7@siemens.com>
 <A396DD4B-B1F2-404E-917E-F86FBA90918E@korgrd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Am Tue, 19 Dec 2017 16:00:02 -0500
schrieb Steve Pavao <stevep@korgrd.com>:

> Hi Jan,
>=20
> > On Dec 19, 2017, at 2:24 PM, Jan Kiszka <jan.kiszka@siemens.com>
> > wrote:
> >=20
> > On 2017-12-19 19:49, Steve Pavao wrote: =20
> >> Hi Lowell,
> >>=20
> >> Thanks for that tip.  That=E2=80=99s what I was thinking I might need =
to
> >> do.
> >>=20
> >> I guess the solution in Yocto terms is to rework my I-PIPE patch
> >> recipe to not directly apply the I-PIPE patch, but rather to call
> >> prepare-kernel.sh and allow it to apply the patch, plus do the
> >> other things it needs to do.  I guess that should happen in a
> >> do_configure() {} block. =20
> >=20
> > Actually, I would move the kernel patching out of the xenomai
> > recipe and rather have one recipe for the userspace packages and a
> > xenomai-kernel.inc which appends the kernel preparation task with
> > the prepare-kernel.sh invocation. It would also bring in (once
> > again) the xenomai sources so that its kernel elements get pulled
> > into the kernel build. In your kernel recipe, you would simply
> > include that file.
> >=20
> > This way, the kernel could come from various sources, including
> > git.xenomai.org/ipipe.git, and just needs to have the I-pipe patch
> > already applied, either in it git source or by adding a
> > corresponding patch to the custom kernel recipe.
> >=20
> > This seems similar to how ELDK modeled this:
> > http://git.denx.de/?p=3Deldk.git;a=3Dtree;f=3Dmeta-eldk/recipes-kernel/=
xenomai;h=3Dbf965c6d2fa5132413b498161c90f337be8fb174;hb=3Drefs/heads/5.8-el=
dk
> > <http://git.denx.de/?p=3Deldk.git;a=3Dtree;f=3Dmeta-eldk/recipes-kernel=
/xenomai;h=3Dbf965c6d2fa5132413b498161c90f337be8fb174;hb=3Drefs/heads/5.8-e=
ldk> =20
>=20
> Thanks for your advice, Jan.  I was hoping to keep things as simple
> as possible, though.  The ELDK example has a highly-customized bb
> recipe.

If you want to keep things as simple as possible you could also diff
the kernel before and after prepare-kernel.sh and just add the patch
you get out of there to your patches in the bbappend.
This will tie you kernel recipe to the exact version of xenomai and
should be considered a hack.

Henning
=20
> Could I achieve my ends If I use my initial idea, which is to call
> the prepare-kernel.sh from a do_configure block, rather than directly
> applying the I-PIPE patch?  It seems like it won=E2=80=99t succeed, based=
 on
> what you have said, perhaps because the recipe that calls
> prepare-kernel.sh is going to need to be more complex than simply
> calling that script.  (You mentioned about needing to pull in the
> xenomai sources once again).
>=20
> I think I need to hand this task off to a colleague who has some more
> Linux internals experience.
>
> > That is outdated now, unfortunately. Do you plan to publish your
> > layer afterwards? I suppose some people would be happy about a
> > meta-xenomai with support for Xenomai 3. =20
>=20
> I=E2=80=99d have to check with my organization.  Personally, I=E2=80=99d =
like to see
> anyone publish one, including us.  Anything that allows folks to
> start using Xenomai 3 more easily from within their highly-customized
> Poky environments would be helpful.
>=20
> - Steve Pavao
> Korg R&D
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


