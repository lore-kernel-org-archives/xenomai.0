Date: Tue, 25 Feb 2020 16:37:47 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH] libs: Add linking dependencies to libraries
Message-ID: <20200225163747.27c2c234@md1za8fc.ad001.siemens.net>
In-Reply-To: <a7e13035-2f7b-2f2e-a0b7-05f6986109d9@siemens.com>
References: <4d132aef-75ce-3b7a-21b7-d8f8afde1967@siemens.com>
 <20200225153054.5c7830da@md1za8fc.ad001.siemens.net>
 <ff952c07-e291-46c6-82bb-9aade7479fe1@siemens.com>
 <a7e13035-2f7b-2f2e-a0b7-05f6986109d9@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Antoine Hoarau <antoine@flr.io>, Xenomai <xenomai@xenomai.org>

On Tue, 25 Feb 2020 15:33:45 +0100
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> [adding the list]
>=20
> On 25.02.20 15:32, Jan Kiszka wrote:
> > On 25.02.20 15:30, Henning Schild wrote: =20
> >> I guess that is related to lds --(no-)as-needed which is different
> >> in the ubuntu toolchain. Back when i looked into it Ubuntu managed
> >> to patch the default behaviour but forgot to patch the man-pages ;)
> >>
> >> See
> >> https://gitlab.denx.de/Xenomai/xenomai/commit/83dea2ad712ee2d2137942c7=
ab9891da7d4ef841=20
> >>
> >>
> >> Maybe this can actually be reverted after the proposed fix. =20
> >=20
> > If someone can validate that, I'm happy to do so...

That is why i pulled in Antoine again. He has a ubuntu setup and can
probably check whether applying your fix works, and reverting the other
one still works.

Henning

> > Jan
> >  =20
> >>
> >> Henning
> >>
> >> On Wed, 19 Feb 2020 13:31:29 +0100
> >> Jan Kiszka via Xenomai <xenomai@xenomai.org> wrote:
> >> =20
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> This ensures that no optimization will drop dependencies of our
> >>> shared objects, preventing to load them via dlopen without
> >>> explicitly loading those dropped dependencies first. See also
> >>> https://xenomai.org/pipermail/xenomai/2020-February/042449.html
> >>>
> >>> As trank now explicitly depends on alchemy, reorder the build to
> >>> ensure that the latter is available before the former is built
> >>> (analogy is only moved for consistency reasons).
> >>>
> >>> Reported-by: Antoine Hoarau <antoine@flr.io>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>> ---
> >>> =C2=A0 lib/Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 +++++++----
> >>> =C2=A0 lib/alchemy/Makefile.am |=C2=A0 4 ++++
> >>> =C2=A0 lib/analogy/Makefile.am |=C2=A0 2 ++
> >>> =C2=A0 lib/psos/Makefile.am=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> >>> =C2=A0 lib/trank/Makefile.am=C2=A0=C2=A0 |=C2=A0 4 ++++
> >>> =C2=A0 lib/vxworks/Makefile.am |=C2=A0 4 ++++
> >>> =C2=A0 6 files changed, 25 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/lib/Makefile.am b/lib/Makefile.am
> >>> index c927a9bd85..e909030564 100644
> >>> --- a/lib/Makefile.am
> >>> +++ b/lib/Makefile.am
> >>> @@ -1,10 +1,7 @@
> >>> =C2=A0 SUBDIRS =3D boilerplate
> >>> =C2=A0 if XENO_COBALT
> >>> -SUBDIRS +=3D=C2=A0=C2=A0=C2=A0 \
> >>> -=C2=A0=C2=A0=C2=A0 cobalt=C2=A0=C2=A0=C2=A0 \
> >>> -=C2=A0=C2=A0=C2=A0 analogy=C2=A0=C2=A0=C2=A0 \
> >>> -=C2=A0=C2=A0=C2=A0 trank
> >>> +SUBDIRS +=3D cobalt
> >>> =C2=A0 else
> >>> =C2=A0 SUBDIRS +=3D mercury
> >>> =C2=A0 endif
> >>> @@ -16,6 +13,12 @@ SUBDIRS +=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vxworks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psos
> >>> +if XENO_COBALT
> >>> +SUBDIRS +=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 analogy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
> >>> +=C2=A0=C2=A0=C2=A0 trank
> >>> +endif
> >>> +
> >>> =C2=A0 DIST_SUBDIRS =3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alchemy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 analogy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> diff --git a/lib/alchemy/Makefile.am b/lib/alchemy/Makefile.am
> >>> index 5362695ed2..f97bd69bf8 100644
> >>> --- a/lib/alchemy/Makefile.am
> >>> +++ b/lib/alchemy/Makefile.am
> >>> @@ -2,6 +2,10 @@ lib_LTLIBRARIES =3D libalchemy.la
> >>> =C2=A0 libalchemy_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@ -version-info 0:0=
:0
> >>> +libalchemy_la_LIBADD =3D
> >>> =C2=A0=C2=A0=C2=A0=C2=A0\
> >>> +=C2=A0=C2=A0=C2=A0 @XENO_CORE_LDADD@=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 $(top_builddir)/lib/copperplate/libcopperplate.la
> >>> +
> >>> =C2=A0 libalchemy_la_SOURCES =3D=C2=A0=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 internal.c=C2=A0=C2=A0=C2=A0 \
> >>> diff --git a/lib/analogy/Makefile.am b/lib/analogy/Makefile.am
> >>> index e53d8a11ab..4c6f0de013 100644
> >>> --- a/lib/analogy/Makefile.am
> >>> +++ b/lib/analogy/Makefile.am
> >>> @@ -2,6 +2,8 @@ lib_LTLIBRARIES =3D libanalogy.la
> >>> =C2=A0 libanalogy_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@ -version-info 1:0=
:0
> >>> -lm +libanalogy_la_LIBADD =3D @XENO_CORE_LDADD@
> >>> +
> >>> =C2=A0 libanalogy_la_SOURCES =3D=C2=A0=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 descriptor.c=C2=A0=C2=A0=C2=A0 \
> >>> diff --git a/lib/psos/Makefile.am b/lib/psos/Makefile.am
> >>> index 4eb7ad84ce..6fe50881cc 100644
> >>> --- a/lib/psos/Makefile.am
> >>> +++ b/lib/psos/Makefile.am
> >>> @@ -2,6 +2,10 @@ lib_LTLIBRARIES =3D libpsos.la
> >>> =C2=A0 libpsos_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@ -version-info 0:0:0
> >>> +libpsos_la_LIBADD =3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 @XENO_CORE_LDADD@=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 $(top_builddir)/lib/copperplate/libcopperplate.la
> >>> +
> >>> =C2=A0 libpsos_la_SOURCES =3D=C2=A0=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 internal.h=C2=A0=C2=A0=C2=A0 \
> >>> diff --git a/lib/trank/Makefile.am b/lib/trank/Makefile.am
> >>> index 816a1a4047..ee353c6f20 100644
> >>> --- a/lib/trank/Makefile.am
> >>> +++ b/lib/trank/Makefile.am
> >>> @@ -3,6 +3,10 @@ lib_LTLIBRARIES =3D libtrank.la
> >>> =C2=A0 libtrank_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@ -version-info 0:0:0
> >>> +libtrank_la_LIBADD =3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 @XENO_CORE_LDADD@=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 $(top_builddir)/lib/alchemy/libalchemy.la
> >>> +
> >>> =C2=A0 libtrank_la_SOURCES =3D=C2=A0=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 internal.c=C2=A0=C2=A0=C2=A0 \
> >>> diff --git a/lib/vxworks/Makefile.am b/lib/vxworks/Makefile.am
> >>> index a123864079..4217a994b0 100644
> >>> --- a/lib/vxworks/Makefile.am
> >>> +++ b/lib/vxworks/Makefile.am
> >>> @@ -2,6 +2,10 @@ lib_LTLIBRARIES =3D libvxworks.la
> >>> =C2=A0 libvxworks_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@ -version-info 0:0=
:0
> >>> +libvxworks_la_LIBADD =3D
> >>> =C2=A0=C2=A0=C2=A0=C2=A0\
> >>> +=C2=A0=C2=A0=C2=A0 @XENO_CORE_LDADD@=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> >>> +=C2=A0=C2=A0=C2=A0 $(top_builddir)/lib/copperplate/libcopperplate.la
> >>> +
> >>> =C2=A0 libvxworks_la_SOURCES =3D \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errnoLib.c=C2=A0=C2=A0=C2=A0 \ =20
> >> =20
> >  =20
>=20


