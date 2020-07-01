MIME-Version: 1.0
References: <CAAvDm6b-4a-n8HDRRQZScEKF1AmeJyWvYA1MH9MdOC43DMGzvw@mail.gmail.com>
 <5d727e35-c291-a917-f64b-90a1cfcb37b6@siemens.com>
In-Reply-To: <5d727e35-c291-a917-f64b-90a1cfcb37b6@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Wed, 1 Jul 2020 19:37:47 +0800
Message-ID: <CAAvDm6bQ9bOxBHutXbtoCQ918xCZR=CeqzOMhhmetOtrhDxjjg@mail.gmail.com>
Subject: Re: [RFC]Are there some potential problems that I should be aware of
 if I use the kvmalloc() instead of kmalloc() in xnheap_init()?
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
Thank you for taking the time to respond.

Here is the corresponding patch:

>From 46e248e89c99bdce99fe5f112c4bf5d17ad10b1d Mon Sep 17 00:00:00 2001
From: sunshilong <sunshilong369@gmail.com>
Date: Tue, 30 Jun 2020 22:37:07 -0700
Subject: [PATCH] Replace kzalloc by kvmalloc in function xnheap_init to
avoid
 the error of page allocation failure because of memory fragmentation.

Signed-off-by: sunshilong <sunshilong369@gmail.com>
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

--
2.7.4

Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:48=E5=86=99=E9=81=93=EF=BC=9A


Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:48=E5=86=99=E9=81=93=EF=BC=9A

> On 27.06.20 09:23, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong wrote:
> > Hi, list
> >
> > I found a solution to solve the problem(i.e. page allocation failure:
> > order:9, mode:0x60c0c0 (GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> > nodemask=3D(null)). But I don't know whether there are some potential
> problems
> > or not if I repalce kmalloc() function by kvmalloc() (or vmalloc()) in
> > xnheap_init()?
> >
> > I'm using xenomai3.1+linux4.19.84.
> >
> > Here is the related call trace
> > (the whole log is seen at the footnote, I'd try to explain
> > my current understanding to the related code snippet blow):
> > dump_stack+0x9e/0xc8
> > warn_alloc+0x100/0x190
> > __alloc_pages_slowpath+0xb93/0xbd0
> > __alloc_pages_nodemask+0x26d/0x2b0
> > alloc_pages_current+0x6a/0xe0
> > kmalloc_order+0x18/0x40
> > kmalloc_order_trace+0x24/0xb0
> > __kmalloc+0x20e/0x230
> > ? __vmalloc_node_range+0x171/0x250
> > xnheap_init+0x87/0x200
> > ? remove_process+0xc0/0xc0
> > cobalt_umm_init+0x61/0xb0
> >
> > Here is my current understanding of the most related snippet:
> > As the aforementioned call trace, the failure has some relation
> > to xnheap_init().
> >
> > Kzalloc() is invoked by xnheap_init() in the xenomai source code(see
> > https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/kernel/cobalt/heap.c
> ).
> > For your convenience, here is the most related code:
> > int xnheap_init(struct xnheap *heap, void *membase, size_t size)
> > {
> >      ...
> > nrpages =3D size >> XNHEAP_PAGE_SHIFT;
> > heap->pagemap =3D kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
> > GFP_KERNEL);
> > ...
> > }
> >
> >
> > As per the source of Linux kernel
> > (
> https://elixir.bootlin.com/linux/v4.9.182/source/include/linux/slab.h#L63=
4
> ),
> > kzalloc() invokes kmalloc() with a option of __GFP_ZERO.
> > So, we can say that kmalloc() is finally called by xnheap_init().
> >
> > What's the exact value of the variable "size" (which is one of the inpu=
t
> > arguments of xnheap_init())?
> > There is a clue from the said call trace.
> >
> > Attach_process() is invoked by cobalt_umm_init().
> > It's the attach_proceess function passes the value to xnheap_init
> function(
> > see
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/kernel/cobalt/posix/pr=
ocess.c
> ).
> > For your convenience, here is the most related code:
> > static int attach_process(struct cobalt_process *process)
> > {
> > ...
> > ret =3D cobalt_umm_init(&p->umm, CONFIG_XENO_OPT_PRIVATE_HEAPSZ * 1024,
> >       post_ppd_release);
> > if (ret)
> > return ret;
> > ...
> > }
> >
> > So, the size passes to kmalloc() has a direct relation (for details,
> > see below) to
> > CONFIG_XENO_OPT_PRIVATE_HEAPSZ.
> > And CONFIG_XENO_OPT_PRIVATE_HEAPSZ is set to 81920(i.e. 81920KB
> > memory needs to be allocated by vmalloc()) when setting the kconfig.
> > Our user application may report the error of out of memory if I set
> > CONFIG_XENO_OPT_PRIVATE_HEAPSZ to a relatively small value(say 40MB).
> >
> > As I said before, I have set the size of  private heap to a huge value.
> > This huge memory could be allocated by __vmalloc() successfully.
> > The private heap is managed by "pages" and each of the pages is 512Byte=
s.
> > Xenomai uses the struct named xnheap_pgentry to indicates the usage of
> > each page(of the private heap).
> > Each xnheap_pgentry needs 12Bytes(i.e. sizeof(xnheap_pgentry)=3D12).
> >
> > And the said variable named nrpages is equivalent to the above equation=
.
> > So another 1920KB(i.e. nrpages*sizeof(xnheap_pgentry) memory
> > (to indicates the usage of each page of the private heap)
> > has to be allocated by kmalloc(). And it finally caused the allocation
> > failure.
> >
> > I think the kmalloc function should be replaced by kvmalloc() or
> >   vmalloc(). It just needs some memory to store the array of
> > struct xnheap_pgentry. So the memory does not need to be physically
> > continuous. What do you think about it?
> >
>
> Good analysis! I see no issue in replacing kmalloc with kvmalloc. Would
> you write such a patch with a short reasoning?
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
