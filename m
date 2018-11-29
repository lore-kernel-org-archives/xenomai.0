MIME-Version: 1.0
References: <6a75de9a.bb14.1675e7e151a.Coremail.liang_1911@163.com>
 <6c00eb9f-37b7-1500-0da5-ceab4f4db112@xenomai.org>
 <5ff90fcc.1120f.16760156d36.Coremail.liang_1911@163.com>
In-Reply-To: <5ff90fcc.1120f.16760156d36.Coremail.liang_1911@163.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 29 Nov 2018 10:39:03 -0500
Message-ID: <CALLqZ8QSQjNQDpfYx-gjodj+9PR7J7nzi=S09CDkOw=eQhRLyQ@mail.gmail.com>
Subject: Re: Re: every millicsecond interrupt in xenomai domain on a am355x
 board can cause something wrong?
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
To: liang_1911@163.com
Cc: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

This doc will help explain how the ipipe handles interrupts.

https://gitlab.denx.de/Xenomai/ipipe-noarch/blob/master/Documentation/ipipe=
.rst


I don't think the interrupt is being missed, what domain do you want
to handle the interrupt?

-Greg
On Thu, Nov 29, 2018 at 10:28 AM =E6=A2=81=E6=9D=83 via Xenomai <xenomai@xe=
nomai.org> wrote:
>
> it is neither NMI nor FIQ; "cannot be mask" just for emphasize this inter=
rupt is so important that cannot be missed even once.
>  it maybe my fault for this unclear expression
>
>
>
>
> --
>
> ----------------------------------------------
>           =E6=A2=81=E6=9D=83
> THANKS & BR!
>
>
>
>
>
> =E5=9C=A8 2018-11-29 22:34:03=EF=BC=8C"Philippe Gerum" <rpm@xenomai.org> =
=E5=86=99=E9=81=93=EF=BC=9A
> >On 11/29/18 9:03 AM, =E6=A2=81=E6=9D=83 via Xenomai wrote:
> >> hi=EF=BC=8C
> >> i'm work on a customed board with TI am335X; i have installed xenomai =
3 on it correcttly , and can run the latency test.
> >> On this board, an interrupt which cannot be masked and delayed will be=
 generated every millicsecond by a FPGA ;
> >
> >What do you mean precisely by "cannot be masked"? Are you referring to
> >NMI or FIQ?
> >
> >--
> >Philippe.

