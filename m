MIME-Version: 1.0
References: <87mtyr1abi.fsf@xenomai.org>
 <5fcd902b.1c69fb81.79300.444fSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5fcd902b.1c69fb81.79300.444fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 7 Dec 2020 01:59:33 -0500
Message-ID: <CALLqZ8TZkVBO4=AQD=0SKA_uJ++NJ8+dCW81scEeCs4UmcSBnA@mail.gmail.com>
Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
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
To: chensong <chensong@tj.kylinos.cn>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Dec 6, 2020 at 9:15 PM chensong via Xenomai <xenomai@xenomai.org>
wrote:

> hi Philippe,
>
> As far as i know, some vxworks customers like xenomai because they can
> move their RT processes from vxworks to linux without rewriting their
> code by the help of vxworks skin.
>
> These are legacy vxworks applications?


> If we "Excluding the legacy RTOS emulators such as VxWorks", we will
> lose them. It could depend on the balance of the request and effort.
>
It might make sense to only support the vxworks skin, would any of these
users be willing to help with support?

-Greg


>
> BR
>
> song
>
> On 2020=E5=B9=B412=E6=9C=8806=E6=97=A5 18:46, Philippe Gerum via Xenomai =
wrote:
> >
> > The common Xenomai platform specification is about defining the
> > commonalities among future Xenomai releases starting from 3.3, includin=
g
> > the Xenomai 4 series based on a next generation (EVL) core. A common AP=
I
> > available to applications for issuing requests to the real-time core is
> > part of this specification.
> >
> > Implementing such interface would not preclude other APIs from
> > co-existing in particular releases. However, use of this common API
> > only would guarantee portability > Excluding the legacy RTOS emulators
> such as VxWorks and pSOS, Xenomai
> > 3.x provides two main APIs, a POSIX-compliant one (libcobalt) and a
> > custom RTOS API aka Alchemy (libalchemy) on top of the Copperplate
> > interface.
> >
> > PROPOSAL: Pick libcobalt as the common API defined by the CXP.
> >
> > As a consequence, Xenomai 4 would provide two direct interfaces to the
> > underlying EVL core: via the libevl API [1] which is readily
> > available, and its own implementation of libcobalt as part of a CXP
> > compliance.
> >
> >                    applications
> >        ....................................
> >        libalchemy            libevl libcobalt
> >             |                  |      |
> >             |                  |      |
> >        libcopperplate          |      |
> >             |                  |      |
> >             |                  |      |
> >         libcobalt              |      |
> >             |                  |      |
> >             v                  v      v
> >       (Cobalt core)           (EVL core)
> >        -----------            ---------
> >        Xenomai 3.x            Xenomai 4
> >
> >
> > Thanks,
> >
> > [1] https://evlproject.org/core/user-api/
> >
>
>
