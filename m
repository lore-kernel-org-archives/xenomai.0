From: Uladzimir Bely <ubely@ilbers.de>
Subject: Re: [xenomai-images] [PATCH v2 2/2] linux-xenomai: handle
 xenomai-kernel patch in Debian way
Date: Thu, 27 Jan 2022 08:08:30 +0300
Message-ID: <1704169.9hSmTKtgW7@home>
In-Reply-To: <5991440c-9a6e-e460-8cbe-191113c44f12@siemens.com>
References: <20220118105128.3007-1-ubely@ilbers.de>
 <20220118105128.3007-3-ubely@ilbers.de>
 <5991440c-9a6e-e460-8cbe-191113c44f12@siemens.com>
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
To: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>

In the email from =D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=B8=D0=BA, 24 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2022 =D0=B3. 20:56:31 +0=
3 user Jan Kiszka=20
wrote:
> On 18.01.22 11:51, Uladzimir Bely via Xenomai wrote:
> > This change moves generating xenomai-kernel.patch and applying it
> > from the recipe into a build script in 'debian/' subdirectory.
> >=20
> > This makes linux-xenomai recipe buildchroot-independent and
> > allows to use it with any build system (e.g. sbuild).
> >=20
> > Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> > ---
> >=20
> >   recipes-kernel/linux/linux-xenomai.inc | 13 ++++++++-----
> >   1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/recipes-kernel/linux/linux-xenomai.inc
> > b/recipes-kernel/linux/linux-xenomai.inc index 7dba96e..bd7db7d 100644
> > --- a/recipes-kernel/linux/linux-xenomai.inc
> > +++ b/recipes-kernel/linux/linux-xenomai.inc
> > @@ -49,9 +49,12 @@ dpkg_runbuild_prepend() {
> >=20
> >   	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
> >   =09
> >   			 ${PV} ${LINUX_COMMIT})
> >=20
> > -	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-
kernel.
> > sh \ -		--linux=3D${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=3D$ARCH=20
\
> > -		--outpatch=3D${WORKDIR}/xenomai-kernel.patch
> > -	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
> > -		-p1 -i ${WORKDIR}/xenomai-kernel.patch
> > +	if ! grep -q "prepare-kernel.sh" ${S}/debian/isar/build; then
> > +		cat << EOF | sed -i '/^do_build/ r /dev/stdin' ${S}/
debian/isar/build
> > +    /usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \\
> > +        --linux=3D. --arch=3D$ARCH \\
> > +        --outpatch=3D../xenomai-kernel.patch
> > +    patch -d . -p1 -i ../xenomai-kernel.patch
> > +EOF
>=20
> Can't we pick up ARCH from the environment of the build and use a static
> script? This conditional patching-in is not so nice.

Yes, we can do it. Instead of using $ARCH we could use \$ARCH, so the varia=
ble=20
will take the value not in "dpkg_runbuild", but in 'debian/isar/build', fro=
m=20
the environment. In this case the architecture will be calculated by simila=
r=20
function get_kernel_arch() from `isar/meta/recipes-kernel/linux/linux-
custom.inc`

I first wanted to do it this way, but notices, that Isar's function handles=
=20
more architectures than arm/arm64/x86. For example, in case of=20
DISTRO_ARCH=3D"mipsel" function from 'linux-xenoami.ing' produces an error=
=20
("Unsupported architecture"), while one from 'linux-custom.inc' returns=20
"mips".

If it's not a problem, we can simplify it and remove more code.

>=20
> Jan
>=20
> > +	fi
> >=20
> >   }





