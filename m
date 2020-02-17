MIME-Version: 1.0
References: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
 <cd4f3b32-d2bf-a96d-527a-5f7f3403e4d2@siemens.com>
 <CAPnNZ0Vt=mVk-JQoZM3TSGBBFOwqc+7KtnhtHVR89iLBo+cRqg@mail.gmail.com>
 <b6aa1c1a-7f68-c678-01ca-7cbb0fddffde@siemens.com>
 <CAPnNZ0Xv3gB5xnXaGN8wBfbgZgBB5XfDv9zBmyO9wD4T4WOBbA@mail.gmail.com>
 <c0ac33c8-51a8-d2c9-e8cf-088bc17f033a@siemens.com>
In-Reply-To: <c0ac33c8-51a8-d2c9-e8cf-088bc17f033a@siemens.com>
From: Antoine Hoarau <antoine@flr.io>
Date: Tue, 18 Feb 2020 00:04:46 +0100
Message-ID: <CAPnNZ0WyMCjodtJopJ7h0=28OVxeZHSgN6sQ9KJFKvf-aKYhug@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

# ldd /usr/lib/xenomai/testsuite/libalchemy-test.so
        linux-vdso.so.1 (0x00007fff1f944000)
        libcobalt.so.2 =3D> /usr/lib/libcobalt.so.2 (0x00007f2a40bc9000)
        libalchemy.so.0 =3D> /usr/lib/libalchemy.so.0 (0x00007f2a409b1000)
        libcopperplate.so.0 =3D> /usr/lib/libcopperplate.so.0
(0x00007f2a407a3000)
        libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007f2a403b2000)
        librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00007f2a401aa00=
0)
        libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
(0x00007f2a3ff8b000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f2a40ff4000)


For info I added --enable-dlopen-libs
As in https://xenomai.org/pipermail/xenomai/2020-January/042306.html

Le lun. 17 f=C3=A9vr. 2020 =C3=A0 17:51, Jan Kiszka <jan.kiszka@siemens.com=
> a =C3=A9crit :

> On 14.02.20 15:15, Antoine Hoarau wrote:
> > I just built the debians:
> > debchange -v 3.1 Release 3.1
> > debuild -uc -us
> >
>
> I've done that (well, minus debchange) on a Debian 10, installed a
> Xenomai kernel, and ran xeno-test - no problem. I would need this info:
>
> ldd /usr/lib/xenomai/testsuite/libalchemy-test.so
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
