MIME-Version: 1.0
References: <CAAvDm6YF-PcERwDrV2C6NVHqKLE9+_z6R6tQq29uyHff=Oyj3A@mail.gmail.com>
 <846f8be9-c102-ef57-36f9-1c9b769805ab@siemens.com>
In-Reply-To: <846f8be9-c102-ef57-36f9-1c9b769805ab@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 13 Aug 2020 15:46:57 +0800
Message-ID: <CAAvDm6Y+EeaEu6+=D+3BPV6OvdwzLShgJ_HuUu4n_r67oz24iw@mail.gmail.com>
Subject: Re: Question about round-robin scheduling.
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

Thank you for your reply.

>Look how SCHED_RR is commonly configured, nothing special in Xenomai.
>The only specialty is CONFIG_XENO_OPT_RR_QUANTUM.
As per the documentation(
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__t=
ask.html#ga03387550693c21d0223f739570ccd992),
what confuses me is that it only explicitly states that the
rt_task_create() function supports
SCHED_FIFO (other than supporting both SCHED_FIFO and SCHED_RR).

Then, how can I configure the scheduling policy of SCHED_RR?

Thank you for your attention to this matter.


On Thu, Aug 13, 2020 at 12:00 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 06.08.20 14:27, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong via Xenomai wro=
te:
> > Hi, list
> >
> > As per the Kconfig(
> > https://gitlab.denx.de/Xenomai/xenomai/-/blob/5714ceede70ccd39b1bf6c41a=
72cfa94f98e169a/kernel/cobalt/Kconfig
> > ),
> > which says [emphasise mine]:
> > Cobalt has a built-in real-time class, which supports both
> > preemptive fixed-priority FIFO, and **round-robin scheduling**.
> > Cobalt supports  round-robin scheduling whereas
> > rt_task_create function only supports SCHED_FIFO and SCHED
> > (
> > https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchem=
y__task.html#ga03387550693c21d0223f739570ccd992
> > ).
> >
> > So, I wonder how to set a real-time task to use round-robin scheduling.
> > Or, am I missing something?
> >
>
> Look how SCHED_RR is commonly configured, nothing special in Xenomai.
> The only specialty is CONFIG_XENO_OPT_RR_QUANTUM.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

