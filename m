MIME-Version: 1.0
References: <a2c9518f-8468-e8c5-c4fa-c266b29000be@siemens.com>
 <60b53af5-352f-b4ee-089e-961616896fda@siemens.com>
In-Reply-To: <60b53af5-352f-b4ee-089e-961616896fda@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 1 Jul 2021 08:03:10 -0400
Message-ID: <CALLqZ8SzYPTHnwOkWBPAgi-1ZbmjX6bjwemOPTwRaZD7PNAQ2A@mail.gmail.com>
Subject: Re: [PATCH] ipipe: Avoid recursive faults on root work overflow
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

On Thu, Jul 1, 2021 at 5:02 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 01.07.21 09:19, Jan Kiszka via Xenomai wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > On some archs, WARN* is implemented by triggering a fault. This can
> > cause troubles if we are already in a fault and try to submit too much
> > root work. Convert to open-coded warning and stack dump.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > Doesn't solve the overflow you've seen, Mauro, but should give a better
> > hint.
> >
> >  kernel/ipipe/core.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> > index 99a88e4d620e..485db973b81b 100644
> > --- a/kernel/ipipe/core.c
> > +++ b/kernel/ipipe/core.c
> > @@ -2027,9 +2027,16 @@ void __ipipe_post_work_root(struct
> ipipe_work_header *work)
> >       cpu =3D ipipe_processor_id();
> >       tail =3D per_cpu(work_tail, cpu);
> >
> > -     if (WARN_ON_ONCE((unsigned char *)tail + work->size >=3D
> > -                      per_cpu(work_buf, cpu) + WORKBUF_SIZE))
> > +     if (unlikely((unsigned char *)tail + work->size >=3D
> > +                  per_cpu(work_buf, cpu) + WORKBUF_SIZE)) {
> > +             static volatile unsigned long once;
> > +             if (!test_and_set_bit(0, &once)) {
> > +                     ipipe_prepare_panic();
> > +                     pr_err("I-pipe root work queue overflow! System
> may be unstable now.\n");
> > +                     dump_stack();
> > +             }
> >               goto out;
> > +     }
> >
> >       /* Work handling is deferred, so data has to be copied. */
> >       memcpy(tail, work, work->size);
> >
>
> Possibly relevant for ARM/64 as well. Patch is in 4.19 and head noarch
> trees now.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


Thanks, I=E2=80=99ll pull these in and do a new release shortly.

Greg

>
>
