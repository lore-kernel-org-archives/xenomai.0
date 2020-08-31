MIME-Version: 1.0
References: <CAAvDm6Zx4oWB13b9g5_B-3M=AMCoPmcOu0FGrSOK_NPqtXjPUw@mail.gmail.com>
 <dc509fef-852f-55bb-94c6-890bdf704fc9@siemens.com>
In-Reply-To: <dc509fef-852f-55bb-94c6-890bdf704fc9@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Mon, 31 Aug 2020 19:48:32 +0800
Message-ID: <CAAvDm6bEwfvrn8ZbskSvU+dG=VfyF7rVnbeaUNAqzcWWkUMM4A@mail.gmail.com>
Subject: Re: Adivces on Xenomai-3.0.9 support linux-4.19.
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

Hi, Jan

Thank you for taking the time to respond to my question.

>>We want to make Xenomai-3.0.9 work on Linux-4.19
>It's doable with reasonable effort if you do not need RTnet drivers.
It's a pity that we do need RTnet drivers and the wireless network
drivers for Linux.
Maybe, we'll try some other Linux versions later to work along with
Xenomai-3.0.9.

Best Regards.
Sunshilong.

On Mon, Aug 31, 2020 at 5:31 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 31.08.20 11:17, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong via Xenomai wro=
te:
> > Hi, list
> >
> > Our project depends on Xenomai-3.0.9. And we can't upgrade it to
> > Xenomai-3.1 indeed.
> >
> > We want to make Xenomai-3.0.9 work on Linux-4.19
> > (as far as I know, the latest version that it supports is Linux-4.14 an=
d
> > Xenomai-3.1 supports Linux-4.19).
> >
> > Is it possible?
> > Could you give me some advice on how to make Xenomai-3.0.9 work on Linu=
x-4.19?
> >
>
> It's doable with reasonable effort if you do not need RTnet drivers.
> Pick these from 3.1 (bottom first)
>
> Replace sigset_to/from_compat with post 4.14 versions
> kernel: cobalt: trace: replace dummy array with field
> kernel: cobalt: forward SRCARCH from the scripts/prepare-kernel.sh
> kernel: cobalt: use printk instead of print_symbol on v4.16 and later
> kernel: cobalt: replace ACCESS_ONCE with READ_ONCE
>
> and additionally patch
>
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 5bba5bc703..5710c13f1c 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -2121,7 +2121,7 @@ void xnthread_relax(int notify, int reason)
>                 suspension |=3D XNDBGSTOP;
>         }
>
> -       set_task_state(p, p->state & ~TASK_NOWAKEUP);
> +       set_current_state(p->state & ~TASK_NOWAKEUP);
>         xnthread_run_handler_stack(thread, relax_thread);
>         xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NU=
LL);
>         splnone();
>
> I'm using this in local version as well. If things do not build, I might
> have missed some commit. Report the error then.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

