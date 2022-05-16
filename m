MIME-Version: 1.0
References: <CAMES2hcz4K0DXAcktWZ0-DCqA1ds9b=oCfwNET8YaCq9sa+NGw@mail.gmail.com>
 <877d6sv1xg.fsf@xenomai.org> <87tu9wtlkk.fsf@xenomai.org>
In-Reply-To: <87tu9wtlkk.fsf@xenomai.org>
From: Roberto Ferri <ironsnetwork@gmail.com>
Date: Mon, 16 May 2022 15:21:46 +0200
Message-ID: <CAMES2hdMDXzs7K6fG10wgfO99w16QKq_vcwdAu=Hi6rg5grfYg@mail.gmail.com>
Subject: Re: Building example code with EVL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, engineervalide@gmail.com

Thanks for your fast response!

I compiled with meson but I got this error message:
~/git/libevl/tests/observable-unicast.c:168:44: error: =E2=80=98EVL_CLONE_U=
NICAST=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98EVL_CLONE_IN=
PUT=E2=80=99?

Getting the same error in [1], but not in [2].
More info at [3].


[1] Files =C2=B7 c6e08a9b029a4c9eaeeb761f8978f9e374834909 =C2=B7 xenomai / =
xenomai4 /
libevl =C2=B7 GitLab (denx.de)
<https://source.denx.de/Xenomai/xenomai4/libevl/-/tree/c6e08a9b029a4c9eaeeb=
761f8978f9e374834909>
[2] Files =C2=B7 bfa2c4b55cc7d237c685bff722b59d816e63cd8f =C2=B7 xenomai / =
xenomai4 /
libevl =C2=B7 GitLab (denx.de)
<https://source.denx.de/Xenomai/xenomai4/libevl/-/tree/bfa2c4b55cc7d237c685=
bff722b59d816e63cd8f>
[3] *https://source.denx.de/Xenomai/xenomai4/libevl/-/issues/1#note_168405
<https://source.denx.de/Xenomai/xenomai4/libevl/-/issues/1#note_168405>*

Il giorno mer 11 mag 2022 alle ore 12:23 Philippe Gerum <rpm@xenomai.org>
ha scritto:

>
> Philippe Gerum <rpm@xenomai.org> writes:
>
> > Roberto Ferri via Xenomai <xenomai@xenomai.org> writes:
> >
> >> Hello!
> >>
> >> My team and I are trying to build an EVL-based application on a
> *Raspberry
> >> Pi 4B* [1] without success. We followed the steps reported in the guid=
e
> [2]
> >> to compile the code in [3].
> >>
> >> It would be great if you could tell us what we did wrong.
> >>
> >> Many thanks for your work!
> >>
> >> [1] kernel 5.15.35-v8, compiled using
> >> https://source.denx.de/Xenomai/xenomai4/linux-evl
> >>
> >> [2] https://evlproject.org/core/user-api/#build-evl-app
> >>
> >> [3] https://evlproject.org/core/user-api/thread/#thread-services
> >>
> >>
> >>
> >> More info Building example code (#1) =C2=B7 Issues =C2=B7 xenomai / xe=
nomai4 /
> libevl
> >> =C2=B7 GitLab (denx.de)
> >> <https://source.denx.de/Xenomai/xenomai4/libevl/-/issues/1>
> >>
> >>
> >
> > Mm, <sched.h> is involuntarily shadowed by the libevl version. This is =
a
> > breakage introduced by two recent changes: 034e4fd, made worse by
> > bfa2c4b.
> >
> > A fix will be available from the master branch in a couple of hours
> > today. Thanks for the test case.
>
> Please let me know if [1] fixes the issue as expected. This passed my
> Yocto build test with a couple of applications here.
>
> [1]
> https://source.denx.de/Xenomai/xenomai4/libevl/-/commit/21e9a5f2154c65bdd=
290122dcfd4ce257da0e199
>
> --
> Philippe.
>
