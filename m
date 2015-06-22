Message-ID: <1434986459.50378.YahooMailBasic@web173201.mail.ir2.yahoo.com>
Date: Mon, 22 Jun 2015 16:20:59 +0100
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
In-Reply-To: <55882075.3000005@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] include guard trank/posix/pthread.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>--------------------------------------------
>On Mon, 22/6/15, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Subject: Re: [Xenomai] include guard trank/posix/pthread.h
> To: "Frederik Bayart" <frederik_bayart@yahoo.co.uk>, xenomai@xenomai.org
> Date: Monday, 22 June, 2015, 16:49
>=20
> On 06/22/2015 04:37 PM,
> Frederik Bayart wrote:
> >> On Mon,
> 22/6/15, Frederik Bayart <frederik_bayart@yahoo.co.uk>
> wrote:
> >>
> >>
> Subject: Re: [Xenomai] include guard
> trank/posix/pthread.h
> >> To: xenomai@xenomai.org
> >> Date: Monday, 22 June, 2015, 15:41
> >>
> >>
> >>>
> --------------------------------------------
> >>> On Mon, 22/6/15, Philippe Gerum
> <rpm@xenomai.org>
> >> wrote:
> >>>
> >>> Subject:
> >>
> Re: [Xenomai] include guard trank/posix/pthread.h
> >>> To: "Frederik Bayart"
> <frederik_bayart@yahoo.co.uk>,
> >> xenomai@xenomai.org
> >>> Date: Monday, 22 June, 2015,
> 14:48
> >>>
> >>> On 06/22/2015 12:26
> >> PM,
> >>>
> Philippe Gerum wrote:
> >>>> On
> 06/22/2015
> >>>
> >> 11:54 AM, Frederik Bayart wrote:
> >>>
> >>>>
> >>>>>
> >>>
> >>>>
> >>>>> On Friday, 19 June
> >> 2015, 15:07,
> >>> Philippe Gerum <rpm@xenomai.org>
> >>> wrote:
> >>>>>>
> >> On 06/19/2015 03:02 PM,
> >>> Frederik Bayart
> >> wrote:
> >>>>>>
> >>>>>>
> >>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>
> >> Hallo,
> >>>>>>> I noticed that
> >> both
> >>>
> /usr/xenomai/include/trank/trank.h
> >>
> and=20
> >>>
> >>
> /usr/xenomai/include/trank/posix/pthread.h share the same
> >>> include guard
> (_XENOMAI_TRANK_TRANK_H).Can
> >> this
> be an error
> >>> ? I use compile
> flags
> >> 'xeno-config
> --skin=3Dnative
> >>>
> >> --cflags' and get compile errors.
> If I change the
> >>> include guard
> of pthread.h to
> >>>
> _XENOMAI_TRANK_POSIX_PTHREAD_H, the
> >>
> problem seems to be
> >>>
> solved.In
> >> attachment a diff with my
> changes.
> >>>
> >>>>>> Frederik
> >>>
> >>>>>>
> >>>>>>
> >>>>>> Yes,
> >>> the
> >> guard
> is definitely wrong, will fix. Thanks for pointing
> >>> this out.
> >>>
> >>>>>
> >>>>>> --=20
> >>>>>>
> >>>
> >>
> Philippe.
> >>>>>
> >>>
> >>>>
> >>>
> In the same context : to make
> >> it
> compile, I had to add
> >>>>>
> >>
> /usr/xenomai/include/trank/posix to
> >>>
> >>>>=20
> $(shell xeno-config --skin=3Dnative
> >>> --cflags).
> >>>>>
> >>
> At the moment
> >>>
> >> -I/usr/xenomai/include/trank
> -D__XENO_COMPAT__
> >>>>>
> >> -I/usr/xenomai/include/cobalt
> >>>
> >>
> -I/usr/xenomai/include -D_GNU_SOURCE
> >>>
> >>>>=20
> -D_REENTRANT -D__COBALT__
> >>>
> >> -I/usr/xenomai/include/alchemy
> >>>>>
> >>
> is
> >>> returned.
> >>>
> >>>>
> >>>>>
> >>>
> >> If this
> is the correct solution, I can prepare a patch
> >>> for
> >>>>>
> >>
> xeno-config if desired.
> >>>>>
> >>>>
> >>>
> --------------------------------------------
> >>> On Mon, 22/6/15, Philippe Gerum
> <rpm@xenomai.org>
> >> wrote:
> >>>
> >>> Subject:
> >>
> Re: [Xenomai] include guard trank/posix/pthread.h
> >>> To: "Frederik Bayart"
> <frederik_bayart@yahoo.co.uk>,
> >> xenomai@xenomai.org
> >>> Date: Monday, 22 June, 2015,
> 14:48
> >>>
> >>> On 06/22/2015 12:26
> >> PM,
> >>>
> Philippe Gerum wrote:
> >>>> On
> 06/22/2015
> >>>
> >> 11:54 AM, Frederik Bayart wrote:
> >>>
> >>>>
> >>>>>
> >>>
> >>>>
> >>>>> On Friday, 19 June
> >> 2015, 15:07,
> >>> Philippe Gerum <rpm@xenomai.org>
> >>> wrote:
> >>>>>>
> >> On 06/19/2015 03:02 PM,
> >>> Frederik Bayart
> >> wrote:
> >>>>>>
> >>>>>>
> >>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>
> >> Hallo,
> >>>>>>> I noticed that
> >> both
> >>>
> /usr/xenomai/include/trank/trank.h
> >>
> and=20
> >>>
> >>
> /usr/xenomai/include/trank/posix/pthread.h share the same
> >>> include guard
> (_XENOMAI_TRANK_TRANK_H).Can
> >> this
> be an error
> >>> ? I use compile
> flags
> >> 'xeno-config
> --skin=3Dnative
> >>>
> >> --cflags' and get compile errors.
> If I change the
> >>> include guard
> of pthread.h to
> >>>
> _XENOMAI_TRANK_POSIX_PTHREAD_H, the
> >>
> problem seems to be
> >>>
> solved.In
> >> attachment a diff with my
> changes.
> >>>
> >>>>>> Frederik
> >>>
> >>>>>>
> >>>>>>
> >>>>>> Yes,
> >>> the
> >> guard
> is definitely wrong, will fix. Thanks for pointing
> >>> this out.
> >>>
> >>>>>
> >>>>>> --=20
> >>>>>>
> >>>
> >>
> Philippe.
> >>>>>
> >>>
> >>>>
> >>>
> In the same context : to make
> >> it
> compile, I had to add
> >>>>>
> >>
> /usr/xenomai/include/trank/posix to
> >>>
> >>>>=20
> $(shell xeno-config --skin=3Dnative
> >>> --cflags).
> >>>>>
> >>
> At the moment
> >>>
> >> -I/usr/xenomai/include/trank
> -D__XENO_COMPAT__
> >>>>>
> >> -I/usr/xenomai/include/cobalt
> >>>
> >>
> -I/usr/xenomai/include -D_GNU_SOURCE
> >>>
> >>>>=20
> -D_REENTRANT -D__COBALT__
> >>>
> >> -I/usr/xenomai/include/alchemy
> >>>>>
> >>
> is
> >>> returned.
> >>>
> >>>>
> >>>>>
> >>>
> >> If this
> is the correct solution, I can prepare a patch
> >>> for
> >>>>>
> >>
> xeno-config if desired.
> >>>>>
> >>>>
> >>>> Please
> >> do.
> >>>>
> >>>
> >>> -rc5
> is ready and I don't
> >>> want
> to hold it for too long, so if
> >>
> possible,
> >>> any feedback
> regarding this
> >> asap would be
> >>> great. By default,
> >> I'll merge
> >>> the patch
> >>> below, which should address this
> issue.
> >>>
> >>> diff --git
> >> a/scripts/xeno-config-cobalt.in
> >>>
> >>
> b/scripts/xeno-config-cobalt.in
> >>>
> >> index
> >>> c6e51d1..7b623db 100644
> >>> ---
> >>>
> >>
> a/scripts/xeno-config-cobalt.in
> >>>
> +++
> >>>
> b/scripts/xeno-config-cobalt.in
> >>>
> @@ -198,7
> >>> +198,10 @@
> >> if test x$do_cflags =3D xy; then
> >>> =20
> >>>=20
>   test x$compat =3D xy &&
> >>>
> cflags=3D"-I$XENO_INCLUDE_DIR/trank
> >>> -D__XENO_COMPAT__ $cflags"
> >>>      for skin in $skin_list;
> do
> >>>      case
> "$skin" in
> >>> -    =20
>   posix|cobalt|rtdm)
> >>> +    =20
>   posix|rtdm)
> >>> +      =20
> test x$compat =3D xy
> >> &&
> >>> cflags=3D"$cflags
> >>>
> -I$XENO_INCLUDE_DIR/trank/posix"
> >>> +        ;;
> >>> +=20
> >>  =20
>  =20
> >>> cobalt)
> >>>          ;;
> >>>
> >>>=20
>   =20
> >>  =20
> vxworks|psos|alchemy|smokey)
> >>>
> >>>    =20
> >>    cflags=3D"$cflags
> >>>
> >>
> -I$XENO_INCLUDE_DIR/$skin"
> >>>
> >>> --
>=20
> >>> Philippe.
> >>>
> >>>>
> Please do.
> >>>>
> >>>
> >>> -rc5
> is ready and I don't
> >>> want
> to hold it for too long, so if
> >>
> possible,
> >>> any feedback
> regarding this
> >> asap would be
> >>> great. By default,
> >> I'll merge
> >>> the patch
> >>> below, which should address this
> issue.
> >>>
> >>> diff --git
> >> a/scripts/xeno-config-cobalt.in
> >>>
> >>
> b/scripts/xeno-config-cobalt.in
> >>>
> >> index
> >>> c6e51d1..7b623db 100644
> >>> ---
> >>>
> >>
> a/scripts/xeno-config-cobalt.in
> >>>
> +++
> >>>
> b/scripts/xeno-config-cobalt.in
> >>>
> @@ -198,7
> >>> +198,10 @@
> >> if test x$do_cflags =3D xy; then
> >>> =20
> >>>=20
>   test x$compat =3D xy &&
> >>>
> cflags=3D"-I$XENO_INCLUDE_DIR/trank
> >>> -D__XENO_COMPAT__ $cflags"
> >>>      for skin in $skin_list;
> do
> >>>      case
> "$skin" in
> >>> -    =20
>   posix|cobalt|rtdm)
> >>> +    =20
>   posix|rtdm)
> >>> +      =20
> test x$compat =3D xy
> >> &&
> >>> cflags=3D"$cflags
> >>>
> -I$XENO_INCLUDE_DIR/trank/posix"
> >>> +        ;;
> >>> +=20
> >>  =20
>  =20
> >>> cobalt)
> >>>          ;;
> >>>
> >>>=20
>   =20
> >>  =20
> vxworks|psos|alchemy|smokey)
> >>>
> >>>    =20
> >>    cflags=3D"$cflags
> >>>
> >>
> -I$XENO_INCLUDE_DIR/$skin"
> >>>
> >>> --
>=20
> >>> Philippe.
> >>>
> >>
> >> Philippe,
> >>
> >> With
> >> this
> patch, xeno-config works with --native and --posix.
> >>
> >> Thank you for
> the quick
> >> fix.
> >>
> >> I noticed
> also that
> >> xeno-config is in 2
> debian packages so that you yet an
> >>
> install error.
> >> I'm busy to
> write a mail
> >> to report this, and to
> fix this, but maybe this is not
> >>
> urgent for rc5
> >>
> >> Regards,
> >>
> >> Frederik
> >=20
> > Philippe
> >=20
> > I haven't test the ldflags yet. I will
> have a look at it right now and keep you informed. I noticed
> that in older xenomai versions there was a dependency on
> libpthread_rt.so.1 but now I don't see that dependency
> anymore, I don't know yet whether this a problem.
> >=20
>=20
> That's correct, this library is named
> libcobalt in xenomai 3. With the
> compat mode
> enabled, you only need -ltrank in addition to the usual
> deps.
>=20
> --=20
> Philippe.
>=20

Ok, libtrank is in the dependencies, server proces starts and I have severa=
l tasks. I have still some problems but I think these are on application le=
vel, not on compile and link level. So I think the xeno-config is correct n=
ow.

Frederik




