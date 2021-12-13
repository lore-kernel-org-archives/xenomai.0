From: Uladzimir Bely <ubely@ilbers.de>
Subject: Re: [xenomai-images] [PATCH 1/1] Changes to support sbuild-based Isar
Date: Mon, 13 Dec 2021 08:41:08 +0300
Message-ID: <5330380.rdbgypaU67@hp>
In-Reply-To: <094d5cdf-0528-009b-28ba-0241116f3d86@siemens.com>
References: <20211209073619.17698-1-ubely@ilbers.de>
 <20211209073619.17698-2-ubely@ilbers.de>
 <094d5cdf-0528-009b-28ba-0241116f3d86@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>, Baurzhan Ismagulov <ibr@ilbers.de>

In mail from =D1=87=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3, 9 =D0=B4=D0=B5=D0=
=BA=D0=B0=D0=B1=D1=80=D1=8F 2021 =D0=B3. 12:35:16 +03 user Jan Kiszka wrote:
> On 09.12.21 08:36, Uladzimir Bely via Xenomai wrote:
> >=20
> > diff --git a/recipes-xenomai/xenomai/xenomai.inc
> > b/recipes-xenomai/xenomai/xenomai.inc index 8f13767..454dd7b 100644
> > --- a/recipes-xenomai/xenomai/xenomai.inc
> > +++ b/recipes-xenomai/xenomai/xenomai.inc
> > @@ -41,7 +41,5 @@ do_prepare_build() {
> >=20
> >  dpkg_runbuild_prepend() {
> > =20
> >      bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
> >     =20
> >                       ${PV} ${COMMIT})
> >=20
> > -
> > -    sudo chroot --userspec=3D$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> > -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> > +    SBUILD_PREBUILD=3D"cd %p; scripts/bootstrap"
>=20
> Could we rather provide an abstract interface to users, not carrying
> SBUILD in its name? I'm concerned that the current will make it hard to
> switch builders in the future if we may have to.
>=20
> Jan

Hello.

With current approach it doesn't look easy enough. With buildchroot, it's=20
possible to do anything we want in 'dpkg_runbuild_prepend' or 'prepare_buil=
d'=20
task. When the actual build is started, all preparations are here and can b=
e=20
used.

Sbuild is an isolated environment, so similar things can only be somehow=20
passed to the build environment. Here we use SBUILD_PREBUILD to do it, so a=
ll=20
preparations are 'postponed' until real build starts and all dependencies=20
installed.

If we want to unify the approach, we have 2 possible ways:
1) use something like SBUILD_PREBUILD (we can call it BUILD_PREBUILD) - so,=
=20
the preparations won't be done in some prebuild tasks, but they will be=20
postponed (with buildchroot, too) and executed during the actual build.
2) place the stuff into debian/rules, using patches or somehow else. So, th=
e=20
preparations will be done in Debian style at the correct time.

Q:
Also, there is a question regarding 'xenomai.inc' quoted above. Why 'script=
s/
bootstrap' is executed manually here, before the build? There is `bootstrap=
`=20
make target that does exactly the same, but at the build stage.
I'm simply removing 'dpkg_runbuild_prepend()' from xenomai.inc and it is st=
ill=20
working for me.

=2D-=20
Uladzimir Bely
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov



