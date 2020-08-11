MIME-Version: 1.0
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
 <7a76268b-84f6-0073-7830-54a317106c7d@siemens.com>
 <fc87600a-0797-849d-2d35-f2d32d1a7a90@siemens.com>
 <CAAvDm6a2VPs_0uqZZChXc=mhnx7c4Z1sPstbbMRNGceYKZg7_Q@mail.gmail.com>
 <65a89852-1f02-663a-3d08-6e0ad2716044@siemens.com>
In-Reply-To: <65a89852-1f02-663a-3d08-6e0ad2716044@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Tue, 11 Aug 2020 17:17:20 +0800
Message-ID: <CAAvDm6b8DoYYz47K0VDoAzedk9y3w5kv3UA-4TzLipHxkX=z2Q@mail.gmail.com>
Subject: Re: [PATCH] kernel:cobalt:heap: replace kzalloc with kvzalloc
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
Cc: Pintu Kumar <pintu@codeaurora.org>, xenomai <xenomai@xenomai.org>, Pintu Agarwal <pintu.ping@gmail.com>

Hi, Jan Kiszka, Pintu Kunmar

With CONFIG_XENO_OPT_PRIVATE_HEAPSZ, users that request any heap size
based on their needs. For some application needs, this can grow as large
as 4MB that is, 2^10 order pages, which is unlikely to succeed with
kzalloc.
Even the default (256KB) may fail on a highly fragmented system.
Further without COMPACTION enabled, the situation can be worse.

Moreover, for this heap allocation, we don't need physical contiguous
memory. Thus vmalloc may be sufficient here.
But for performance benefit, we may like to stick to malloc.

Thus, it is better to replace kzalloc with kvmalloc which will first try
to use kmalloc and if fails, fallback to vmalloc.

TIPS: Since kvzalloc is not available on Linux-4.4, it's better to use kvma=
lloc
to initialize the memory instead of kvzmalloc.

For a more detailed explanation of the problem and consequence involved in
the original code snippet, see
https://xenomai.org/pipermail/xenomai/2020-July/043137.html

Signed-off-by: sunshilong <sunshilong369@gmail.com> Pintu Kumar
<pintu@codeaurora.org>
Tested-by: sunshilong <sunshilong369@gmail.com>

---
 kernel/cobalt/heap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
index d01a2e0..f9d9a05 100644
--- a/kernel/cobalt/heap.c
+++ b/kernel/cobalt/heap.c
@@ -749,8 +749,8 @@ int xnheap_init(struct xnheap *heap, void *membase,
size_t size)
        xnlock_init(&heap->lock);

        nrpages =3D size >> XNHEAP_PAGE_SHIFT;
-       heap->pagemap =3D kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
-                               GFP_KERNEL);
+       heap->pagemap =3D kvmalloc(sizeof(struct xnheap_pgentry) * nrpages,
+                               GFP_KERNEL | __GFP_ZERO);
        if (heap->pagemap =3D=3D NULL)
                return -ENOMEM;

@@ -804,7 +804,7 @@ void xnheap_destroy(struct xnheap *heap)
        nrheaps--;
        xnvfile_touch_tag(&vfile_tag);
        xnlock_put_irqrestore(&nklock, s);
-       kfree(heap->pagemap);
+       kvfree(heap->pagemap);
 }
 EXPORT_SYMBOL_GPL(xnheap_destroy);

On Tue, Aug 11, 2020 at 4:51 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 11.08.20 10:48, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong wrote:
> > Hi, Jan Kiszka, Pintu Kunmar
> >
> >> Breaks 4.4 kernels. Please have a look:
> >> https://travis-ci.com/github/xenomai-ci/xenomai/builds/179223968
> > Sorry, I forgot.
> > It seems that kvzalloc is not available for linux-4.4.
> > So, this patch
> > (see https://xenomai.org/pipermail/xenomai/2020-July/043137.html) may b=
e better.
> >
> > For your convenience, here is the patch:
> > diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
> > index d01a2e0..f9d9a05 100644
> > --- a/kernel/cobalt/heap.c
> > +++ b/kernel/cobalt/heap.c
> > @@ -749,8 +749,8 @@ int xnheap_init(struct xnheap *heap, void
> > *membase, size_t size)
> >         xnlock_init(&heap->lock);
> >
> >         nrpages =3D size >> XNHEAP_PAGE_SHIFT;
> > -       heap->pagemap =3D kzalloc(sizeof(struct xnheap_pgentry) * nrpag=
es,
> > -                               GFP_KERNEL);
> > +       heap->pagemap =3D kvmalloc(sizeof(struct xnheap_pgentry) * nrpa=
ges,
> > +                               GFP_KERNEL | __GFP_ZERO);
> >         if (heap->pagemap =3D=3D NULL)
> >                 return -ENOMEM;
> >
> > @@ -804,7 +804,7 @@ void xnheap_destroy(struct xnheap *heap)
> >         nrheaps--;
> >         xnvfile_touch_tag(&vfile_tag);
> >         xnlock_put_irqrestore(&nklock, s);
> > -       kfree(heap->pagemap);
> > +       kvfree(heap->pagemap);
> >  }
> >  EXPORT_SYMBOL_GPL(xnheap_destroy);
> >
> >
>
> Could you send a v2 of this patch with the more exhaustive description
> you had in v1?
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

