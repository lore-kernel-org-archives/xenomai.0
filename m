MIME-Version: 1.0
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
 <1597487369-20838-1-git-send-email-pintu@codeaurora.org>
 <f2bf536d-f5b0-3957-f960-0d387250e53f@siemens.com>
In-Reply-To: <f2bf536d-f5b0-3957-f960-0d387250e53f@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Tue, 18 Aug 2020 15:40:30 +0800
Message-ID: <CAAvDm6ZhxH8YHk1RF0aHLk_OcVL89PnshWMt5DZALvAJy=d-6w@mail.gmail.com>
Subject: Re: [PATCH v2] kernel:cobalt:heap: replace kzalloc with vmalloc
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
Cc: Pintu Kumar <pintu@codeaurora.org>, xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Pintu Agarwal <pintu.ping@gmail.com>

Hi, Jan, Pintu

>Is vmalloc guaranteed to return zeroed pages? I don't think so.
Maybe, vzalloc is a choice.
I found it is supported on Linux-4.1=E3=80=81Linux-4.4=E3=80=81Linux-4.9 an=
d Linux-4.19
(https://elixir.bootlin.com/linux/v4.1/source/mm/vmalloc.c#L1742).

On Tue, Aug 18, 2020 at 1:44 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 15.08.20 12:29, Pintu Kumar wrote:
> > With CONFIG_XENO_OPT_PRIVATE_HEAPSZ, user can request any heap size
> > based on their needs. For some application needs, this can grow as larg=
e
> > as 4MB that is, 2^10 order pages, which is unlikely to succeed with
> > kzalloc. Even the default (256KB) may fail on highly fragmented system.
> >
> > Moreover, for this heap allocation, we don't need physical contiguous
> > memory. Thus vmalloc may be sufficient here.
> >
> > Note, we may also use kvzalloc/kvmalloc, but unfortunately these are no=
t
> > available in all kernel versions. Thus for backward compatibility we st=
ick
> > to vmalloc at least till we support 4.x kernel.
> >
> > Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> > Signed-off-by: sunshilong <sunshilong369@gmail.com>
> > Tested-by: sunshilong <sunshilong369@gmail.com>
> > ---
> >  kernel/cobalt/heap.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
> > index d01a2e0..17b392b 100644
> > --- a/kernel/cobalt/heap.c
> > +++ b/kernel/cobalt/heap.c
> > @@ -749,8 +749,7 @@ int xnheap_init(struct xnheap *heap, void *membase,=
 size_t size)
> >       xnlock_init(&heap->lock);
> >
> >       nrpages =3D size >> XNHEAP_PAGE_SHIFT;
> > -     heap->pagemap =3D kzalloc(sizeof(struct xnheap_pgentry) * nrpages=
,
> > -                             GFP_KERNEL);
> > +     heap->pagemap =3D vmalloc(sizeof(struct xnheap_pgentry) * nrpages=
);
>
> Is vmalloc guaranteed to return zeroed pages? I don't think so.
>
> Jan
>
> >       if (heap->pagemap =3D=3D NULL)
> >               return -ENOMEM;
> >
> > @@ -804,7 +803,7 @@ void xnheap_destroy(struct xnheap *heap)
> >       nrheaps--;
> >       xnvfile_touch_tag(&vfile_tag);
> >       xnlock_put_irqrestore(&nklock, s);
> > -     kfree(heap->pagemap);
> > +     vfree(heap->pagemap);
> >  }
> >  EXPORT_SYMBOL_GPL(xnheap_destroy);
> >
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

