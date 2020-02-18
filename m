MIME-Version: 1.0
References: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
 <cd4f3b32-d2bf-a96d-527a-5f7f3403e4d2@siemens.com>
 <CAPnNZ0Vt=mVk-JQoZM3TSGBBFOwqc+7KtnhtHVR89iLBo+cRqg@mail.gmail.com>
 <b6aa1c1a-7f68-c678-01ca-7cbb0fddffde@siemens.com>
 <CAPnNZ0Xv3gB5xnXaGN8wBfbgZgBB5XfDv9zBmyO9wD4T4WOBbA@mail.gmail.com>
 <c0ac33c8-51a8-d2c9-e8cf-088bc17f033a@siemens.com>
 <CAPnNZ0WyMCjodtJopJ7h0=28OVxeZHSgN6sQ9KJFKvf-aKYhug@mail.gmail.com>
 <00236a7b-33bc-a8ee-859e-6956d3679ce2@siemens.com>
In-Reply-To: <00236a7b-33bc-a8ee-859e-6956d3679ce2@siemens.com>
From: Antoine Hoarau <antoine@flr.io>
Date: Tue, 18 Feb 2020 18:45:28 +0100
Message-ID: <CAPnNZ0WnsfxCrGWRhV0J0ROYB6t0wHTD25w4f8-cm1k5y4yvWg@mail.gmail.com>
Subject: Re: undefined symbol in tests
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
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Le mar. 18 f=C3=A9vr. 2020 =C3=A0 12:12, Gylstorff Quirin <
quirin.gylstorff@siemens.com> a =C3=A9crit :

> Hi Antoine,
>
> On 2/18/20 12:04 AM, Antoine Hoarau via Xenomai wrote:
> > # ldd /usr/lib/xenomai/testsuite/libalchemy-test.so
> >          linux-vdso.so.1 (0x00007fff1f944000)
> >          libcobalt.so.2 =3D> /usr/lib/libcobalt.so.2 (0x00007f2a40bc900=
0)
> >          libalchemy.so.0 =3D> /usr/lib/libalchemy.so.0 (0x00007f2a409b1=
000)
> >          libcopperplate.so.0 =3D> /usr/lib/libcopperplate.so.0
> > (0x00007f2a407a3000)
> >          libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> (0x00007f2a403b2000)
> >          librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
> (0x00007f2a401aa000)
> >          libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> > (0x00007f2a3ff8b000)
> >          /lib64/ld-linux-x86-64.so.2 (0x00007f2a40ff4000)
> >
> >
> > For info I added --enable-dlopen-libs
> > As in https://xenomai.org/pipermail/xenomai/2020-January/042306.html
> >
> > Le lun. 17 f=C3=A9vr. 2020 =C3=A0 17:51, Jan Kiszka <jan.kiszka@siemens=
.com> a
> =C3=A9crit :
> >
> >> On 14.02.20 15:15, Antoine Hoarau wrote:
> >>> I just built the debians:
> >>> debchange -v 3.1 Release 3.1
> >>> debuild -uc -us
> >>>
>
> What is the Debian version and CPU architecture of your build system?A


A very standard Ubuntu 18.04 x64.
Debuild version 2.17.12ubuntu1.1

>
>
> >>
> >> I've done that (well, minus debchange) on a Debian 10, installed a
> >> Xenomai kernel, and ran xeno-test - no problem. I would need this info=
:
> >>
> >> ldd /usr/lib/xenomai/testsuite/libalchemy-test.so
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >> Corporate Competence Center Embedded Linux
> >>Quirin
>
> Siemens AG
> Corporate Technology
> CT RDA IOT SES-DE
>
>
