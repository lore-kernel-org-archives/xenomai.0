MIME-Version: 1.0
References: <CAAvDm6azJWrtUeOsiwB3F4AJtGJCAs=vV=NBenocR4zw4jy0TA@mail.gmail.com>
 <CAFLxGvyuv2sM1QK1EYeLdHL46nSXuvGNbB1K4Qcb5jN0y=TG_w@mail.gmail.com>
In-Reply-To: <CAFLxGvyuv2sM1QK1EYeLdHL46nSXuvGNbB1K4Qcb5jN0y=TG_w@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 16 Apr 2020 22:08:18 +0800
Message-ID: <CAAvDm6ZkvMoJRamqOdr9s2Mn-LzuMDjDyEmG23WBn_kP4B0H0A@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

>>      What puzzled me is that i could not locate the corresponding source
>> code.
>>
>>    For example.
>>     The log to locate the system call named as cobalt_sched_yield.
> >    $ grep -inr cobalt_sched_yield

>Grep for COBALT_SYSCALL and sched_yield.
>Richard

      I am glad to hear from you.
      Thank you for your prompt reply.

      It does not work well.
      For detials, see below.

      ~/linux-4.9.38$   grep -nr COBALT  |  grep  sched_yield
      kernel/xenomai/posix/syscall_entries.h:38:
 __COBALT_CALL_ENTRY(sched_yield) \
      kernel/xenomai/posix/syscall_entries.h:137:
__COBALT_MODE(sched_yield, primary) \
       ~/linux-4.9.38$  #log ends

      I have found some clue in the comments at
xenomai-3.1/kernel/cobalt/posix/syscall.c.
      For your convinence,  the comments mentioned  above is listed in this
email.
      As the last email shows, I could not loate the right source code
either while grep for cobalt_sched_yield .

     /* sc_cobalt_sched_yield - which do not require any thunk -
     * would also appear twice, but both entries would point at the native
     * syscall implementation:
     *
     * [sc_cobalt_sched_yield] =3D cobalt_sched_yield,*/

     Best regards.

Richard Weinberger <richard.weinberger@gmail.com> =E4=BA=8E2020=E5=B9=B44=
=E6=9C=8816=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:48=E5=86=99=E9=
=81=93=EF=BC=9A

> On Thu, Apr 16, 2020 at 2:45 PM =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai <=
xenomai@xenomai.org>
> wrote:
> >
> >      Could give me some guideline on how to locate the source code of
> > the xenomai system calls.
> >
> >      I confirm that there is corresponding binary file after compiling
> > the source code which include xenomai and linux.You can see the log
> > listed below for detail.
> >
> >      What puzzled me is that i could not locate the corresponding sourc=
e
> > code.
> >
> >     For example.
> >     The log to locate the system call named as cobalt_sched_yield.
> >     $ grep -inr cobalt_sched_yield
>
> Grep for COBALT_SYSCALL and sched_yield.
>
> >     Binary file kernel/xenomai/built-in.o matches
> >     Binary file kernel/xenomai/posix/xenomai.o matches
> >     Binary file kernel/xenomai/posix/syscall.o matches
> >     Binary file kernel/xenomai/posix/sched.o matches
> >     Binary file kernel/xenomai/posix/built-in.o matches
> >     Binary file kernel/built-in.o matches
> >     Binary file vmlinux matches
> >     Binary file .tmp_vmlinux2 matches
> >     $ #log end
> >
> >     Look forward to hearing from you.
> >     Best regards.
>
>
>
> --
> Thanks,
> //richard
>
