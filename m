MIME-Version: 1.0
References: <CAAvDm6azJWrtUeOsiwB3F4AJtGJCAs=vV=NBenocR4zw4jy0TA@mail.gmail.com>
In-Reply-To: <CAAvDm6azJWrtUeOsiwB3F4AJtGJCAs=vV=NBenocR4zw4jy0TA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 16 Apr 2020 14:48:44 +0200
Message-ID: <CAFLxGvyuv2sM1QK1EYeLdHL46nSXuvGNbB1K4Qcb5jN0y=TG_w@mail.gmail.com>
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

On Thu, Apr 16, 2020 at 2:45 PM =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai <xe=
nomai@xenomai.org> wrote:
>
>      Could give me some guideline on how to locate the source code of
> the xenomai system calls.
>
>      I confirm that there is corresponding binary file after compiling
> the source code which include xenomai and linux.You can see the log
> listed below for detail.
>
>      What puzzled me is that i could not locate the corresponding source
> code.
>
>     For example.
>     The log to locate the system call named as cobalt_sched_yield.
>     $ grep -inr cobalt_sched_yield

Grep for COBALT_SYSCALL and sched_yield.

>     Binary file kernel/xenomai/built-in.o matches
>     Binary file kernel/xenomai/posix/xenomai.o matches
>     Binary file kernel/xenomai/posix/syscall.o matches
>     Binary file kernel/xenomai/posix/sched.o matches
>     Binary file kernel/xenomai/posix/built-in.o matches
>     Binary file kernel/built-in.o matches
>     Binary file vmlinux matches
>     Binary file .tmp_vmlinux2 matches
>     $ #log end
>
>     Look forward to hearing from you.
>     Best regards.



--=20
Thanks,
//richard

