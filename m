MIME-Version: 1.0
References: <CAAvDm6azJWrtUeOsiwB3F4AJtGJCAs=vV=NBenocR4zw4jy0TA@mail.gmail.com>
 <CAFLxGvyuv2sM1QK1EYeLdHL46nSXuvGNbB1K4Qcb5jN0y=TG_w@mail.gmail.com>
 <CAAvDm6ZkvMoJRamqOdr9s2Mn-LzuMDjDyEmG23WBn_kP4B0H0A@mail.gmail.com>
In-Reply-To: <CAAvDm6ZkvMoJRamqOdr9s2Mn-LzuMDjDyEmG23WBn_kP4B0H0A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 16 Apr 2020 16:22:59 +0200
Message-ID: <CAFLxGvyoRgN1ut1Pg1y4ebWCXqKTZpbqCXqEoHErWKE1KTfmaw@mail.gmail.com>
Subject: Re: Could give me some guideline on how to locate the source code of
 the xenomai system calls.
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Apr 16, 2020 at 4:08 PM =E5=AD=99=E4=B8=96=E9=BE=99 <sunshilong369@=
gmail.com> wrote:
>
> >>      What puzzled me is that i could not locate the corresponding sour=
ce
> >> code.
> >>
> >>    For example.
> >>     The log to locate the system call named as cobalt_sched_yield.
> > >    $ grep -inr cobalt_sched_yield
>
> >Grep for COBALT_SYSCALL and sched_yield.
> >Richard
>
>       I am glad to hear from you.
>       Thank you for your prompt reply.
>
>       It does not work well.
>       For detials, see below.
>
>       ~/linux-4.9.38$   grep -nr COBALT  |  grep  sched_yield

-R, not -r. You have to follow symlinks.
Or just work in the xenomai source dir.

--=20
Thanks,
//richard

