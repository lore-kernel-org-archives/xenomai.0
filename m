From: Uladzimir Bely <ubely@ilbers.de>
Subject: Re: [xenomai-images] [PATCH 1/1] Changes to support sbuild-based Isar
Date: Thu, 09 Dec 2021 13:11:46 +0300
Message-ID: <2120415.hkbZ0PkbqX@hp>
In-Reply-To: <a76324c5f3ce543c2e3626cb2b2a2adda8f55089.camel@siemens.com>
References: <20211209073619.17698-1-ubely@ilbers.de>
 <20211209073619.17698-2-ubely@ilbers.de>
 <a76324c5f3ce543c2e3626cb2b2a2adda8f55089.camel@siemens.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>

In mail from =D1=87=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3, 9 =D0=B4=D0=B5=D0=
=BA=D0=B0=D0=B1=D1=80=D1=8F 2021 =D0=B3. 12:42:44 +03 user Bezdeka, Florian=
=20
wrote:
> On Thu, 2021-12-09 at 08:36 +0100, Uladzimir Bely via Xenomai wrote:
>=20
> > These patch is required to build Isar from 'ubely/sbuild' branch,
> > e.g. refspec: 37a71e72c7b8e9ae7e9f6a402ecdc6ff66eab8c4
>=20
>=20
> We're using that, so why do we need to patch? Is that related to the
> new SBUILD feature in ISAR? No way to handle that without breaking many
> downstream layers?
>=20
>=20
> >=20
> > Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> > ---
> >=20
> >  recipes-kernel/linux/linux-xenomai.inc | 14 ++++++++------
> >  recipes-xenomai/xenomai/xenomai.inc    |  4 +---
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >=20
> >=20
> > diff --git a/recipes-kernel/linux/linux-xenomai.inc
> > b/recipes-kernel/linux/linux-xenomai.inc
 index 1852bf6..d68c7a1 100644
> > --- a/recipes-kernel/linux/linux-xenomai.inc
> > +++ b/recipes-kernel/linux/linux-xenomai.inc
> > @@ -28,7 +28,7 @@ def get_commit(d):
> >=20
> > =20
> >  LINUX_COMMIT ?=3D "${@get_commit(d)}"
> > =20
> >=20
> > -dpkg_runbuild_prepend() {
> > +dpkg_configure_kernel_append() {
> >=20
> >  	case ${DISTRO_ARCH} in
> >  	armhf)
> >  =09
> >  		ARCH=3Darm
> >=20
> > @@ -46,9 +46,11 @@ dpkg_runbuild_prepend() {
> >=20
> >  	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
> >  =09
> >  			 ${PV} ${LINUX_COMMIT})
> > =20
> > =20
> >=20
> > -	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-
kernel.
> > sh \
 -		--linux=3D${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=3D$ARCH \
> > -		--outpatch=3D${WORKDIR}/xenomai-kernel.patch
> > -	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
> > -		-p1 -i ${WORKDIR}/xenomai-kernel.patch
> > +    SBUILD_PREBUILD=3D"${SBUILD_PREBUILD} &&                          \
> > +        touch /home/builder/${PN}/file.touch &&                     \
>=20
>=20
> Where does this paths come from? Looks kas or even kas-container
> related.
>=20

It's coming from current 'sbuild' series.

The problem here is the following. We are building 'linux-xenomai` here and=
=20
relay on some '${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/
prepare-kernel.sh' script that is not a part of 'linux-xenomai' recipe.=20
Buildchroot allows to do do that because it doesn't provide 'clean room' bu=
ild=20
environment, so it is already 'polluted' by previously installed packages.=
=20
That's why we have this prepare-kernel.sh preinstalled and can run at any=20
moment.

With sbuild, package is compiled in clean environment, so we can't directly=
=20
reuse files belonging to other packages. To do that, we use SBUILD_PREBUILD=
=20
variable to keep command that should be passed later to sbuild compilation.=
=20
So, sbuild internally first install dependencies in clean environment and=20
executes this command at some internal stage.

>=20
> > +        /usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh    \
> > +            --linux=3D%p --arch=3D${ARCH}                             =
  \
> > +            --outpatch=3D/home/builder/${PN}/xenomai-kernel.patch &&  \
> > +        patch -d %p -p1 -i /home/builder/${PN}/xenomai-kernel.patch \
> > +    "
> >=20
> >  }
> >=20
> > diff --git a/recipes-xenomai/xenomai/xenomai.inc
> > b/recipes-xenomai/xenomai/xenomai.inc
 index 8f13767..454dd7b 100644
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
> >=20
> >  }
>=20
>=20


=2D-=20
Uladzimir Bely
Promwad Ltd.
External service provider of ilbers GmbH
Maria-Merian-Str. 8
85521 Ottobrunn, Germany
+49 (89) 122 67 24-0
Commercial register Munich, HRB 214197
General Manager: Baurzhan Ismagulov



