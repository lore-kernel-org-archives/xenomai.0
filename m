MIME-Version: 1.0
In-Reply-To: <50F66343.4060508@xenomai.org>
References: <50F5741A.9060404@grandegger.com> <50F5B1FD.3040901@xenomai.org>
	<50F658BA.7050107@grandegger.com> <50F66343.4060508@xenomai.org>
Date: Fri, 27 Sep 2013 11:25:03 +0200
Message-ID: <CANKLDmv1nQhB3=D=Z5ed6vwEpn5385NisvBTKoWK1ZmHwMgwhA@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm_iomap_to_user: fix caching and page fault issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Wed, Jan 16, 2013 at 9:22 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 01/16/2013 08:37 AM, Wolfgang Grandegger wrote:
>
> > On 01/15/2013 08:46 PM, Gilles Chanteperdrix wrote:
> >> On 01/15/2013 04:22 PM, Wolfgang Grandegger wrote:
> >>
> >>> From: Wolfgang Grandegger <wg@denx.de>
> >>>
> >>> Pages mapped by rtdm_iomap_to_user() might be cached and may
> >>> page fault on the first write. At least that's the behaviour
> >>> we observed on an ARM mx6q system. This patch fixes these
> >>> issues.
> >>>
> >>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> >>> ---
> >>>  include/asm-generic/wrappers.h | 2 +-
> >>>  ksrc/skins/rtdm/drvlib.c       | 8 +++++---
> >>>  2 files changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/include/asm-generic/wrappers.h
> b/include/asm-generic/wrappers.h
> >>> index de1f0d7..e71bcc3 100644
> >>> --- a/include/asm-generic/wrappers.h
> >>> +++ b/include/asm-generic/wrappers.h
> >>> @@ -394,7 +394,7 @@ static inline void *kzalloc(size_t size, int flag=
s)
> >>>  #define wrap_remap_io_page_range(vma,from,to,size,prot)  ({
>      \
> >>>      (vma)->vm_page_prot =3D pgprot_noncached((vma)->vm_page_prot);  =
 \
> >
> > Hm, here pgprot_noncached() is already used.
> >
> >>>      /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */         \
> >>> -    remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot);
>      \
> >>> +    remap_pfn_range(vma,from,(to) >>
> PAGE_SHIFT,size,pgprot_noncached(prot));              \
> >>
> >>
> >> Should not this be decided in the upper layers?
> >
> > Upper layers? You mean calling xnarch_remap_io_page_range() with the
> > protection argument "pgprot_noncached(PAGE_SHARED)" in
> rtdm_mmap_buffer()?
>
>
> I mean users could want to map i/o regions cacheable, but as you say,
> the pgprot_noncached is already hardcoded in the vma, so, I will merge
> your patch.
>

I used rtdm_iomap_to_user() to map the iMX6 EIM device into user space and
still see caching behavior.

Wolfgang, your patch didn't apply the pgprot_noncached(prot) to the #if
LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,15) && defined(CONFIG_MMU) case.
Was that intended? Were you using a non-mmu configuration or an old kernel?

Anyway, when I apply that change to the >v2.6.15&mmu case, then the caching
behavior is gone. I think that is correct, because my assumption is the
>v2.6.15&mmu check should only switch the use of vm_insert_page(). Please
comment on this assumption.

If the assumption is correct, then select one of the attached patches. The
first one just adds the pgprot_noncached(prot) to the >v2.6.15&mmu case,
while version 2 removes removes the duplicate code
for wrap_remap_io_page_range() and wrap_remap_kmem_page_range(). So NOTE to
only select one of the patches.

Thanks,
Henri

>
> --
>                                                                 Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fix_wrap_remap_io_page_range_cached_mapping_v1.patch
Type: application/octet-stream
Size: 729 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130927/03f29aa=
d/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fix_wrap_remap_io_page_range_cached_mapping_v2.patch
Type: application/octet-stream
Size: 2085 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130927/03f29aa=
d/attachment-0001.obj>
