MIME-Version: 1.0
References: <CAAvDm6bm0dd5KMfZuC9n2f8h7hBJb4ppmigKdQhfwEEy1_SRrQ@mail.gmail.com>
 <782cb718-1bfb-c933-6ce4-0c29c40a28c1@siemens.com>
 <CAAvDm6aYF9E0maLf9+KFYAHqAJf9HxHAXExAeuf=j3fAA68WuQ@mail.gmail.com>
 <cc1d6e4f-ab28-06a6-5afe-ebc5c6d85775@siemens.com>
In-Reply-To: <cc1d6e4f-ab28-06a6-5afe-ebc5c6d85775@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 16 Apr 2020 17:25:52 +0800
Message-ID: <CAAvDm6Z4+eKoMa37=9mWNyxGvYBv-DP1aNfa3=qWd4nV8zE_Fg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_ERR_MSG=EF=BC=9A_called_regular_read=28=29_on_=2Fdev=2Frtdm=2Ffa?=
 =?UTF-8?Q?ke=5Fdev?=
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
Cc: xenomai <xenomai@xenomai.org>

Hi,
    >>Then you need to mark the POSIX IO calls that target your RTDM device
    >>with __RT() explicitly.

     It works!
     Could you give me some guide to understand it?
     What a magic!
     Why it works after adding  __RT() explicitly?

     Best regards.


Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A

> On 16.04.20 11:09, =E5=AD=99=E4=B8=96=E9=BE=99 wrote:
> > Hi,
> >        I am using native calls.I intentionally not to use the posix
> > calls to avoid the conflicts with the posix calls provided by linux.
> >        My makefile is listed below.
> >
> >       My makefile:
> >
> >       CFLAGS  :=3D $(shell $(XENO_CONFIG) --skin=3Dnative --cflags) -Wa=
ll
> >       LDFLAGS :=3D $(shell $(XENO_CONFIG) --skin=3Dnative --ldflags)
>
> Then you need to mark the POSIX IO calls that target your RTDM device
> with __RT() explicitly.
>
> Jan
>
> >
> >      Look forward to hearing from you.
> >      Thanks a lot.
> >
> > Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> =E4=
=BA=8E
> > 2020=E5=B9=B44=E6=9C=8816=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=88=
5:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     On 16.04.20 10:57, =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai wrote:
> >      > Hi,
> >      >         I got the error message listed below when I called read
> >     operation to
> >      > an opened rtdm file handle in main function.
> >      >         I have implemented the rt read operation in my rtdm
> >     driver allready.
> >      >         I think the main thread is allready turned into xenomai
> >     thread
> >      > because I have called rt_shadow_task function before the reading
> >     opreation.
> >      >         I wonder why this error message occurs.
> >      >
> >      >         Error message from kernel.
> >      >         [155453.637967] [Xenomai] task@1[42395][42395] called
> >     regular read()
> >      > on /dev/rtdm/fake_dev.
> >      >         Look forward to hearing from you.
> >      >        Thanks a lot.
> >      >
> >
> >     Your application is not properly wrapping the posix calls, in this
> case
> >     read. Check you makefile, ensure that you use the output of
> >     "xeno-config
> >     --skin posix --ldflags" for linking.
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >     Corporate Competence Center Embedded Linux
> >
>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
