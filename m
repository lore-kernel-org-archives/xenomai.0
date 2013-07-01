From: John Pham <jpham4@gmu.edu>
Date: Mon, 1 Jul 2013 23:21:57 +0000 (UTC)
Message-ID: <loom.20130702T010738-643@post.gmane.org>
References: <201302141227.05428.paul_c@tuxcnc.org>	<511D3F8F.8090501@xenomai.org>	<201302151150.44164.paul_c@tuxcnc.org>
	<201302160020.53324.paul_c@tuxcnc.org>
	<51229E79.7030607@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:

> 
> On 02/16/2013 01:20 AM, Paul wrote:
> 
> > On Friday 15 February 2013, Paul wrote:
> >> On Thursday 14 February 2013, Gilles Chanteperdrix wrote:
> >>> On 02/14/2013 01:27 PM, Paul wrote:
> >>>> Attached, a patch set aimed at providing support for the Broadcom
> >>>> BCM2835 SoC as used in the Raspberry Pi[1].
> >>>
> >>> In the meantime, we can put it in a raspberry subdirectory in
> >>> Xenomai sources. Would you mind making a single patch? Or do you
> >>> prefer the patches to be kept separated?
> >>
> >> A single patch would be preferable for most people - The multi-patch
> >> set was mainly for the benefit of the guys who had a working kernel
> >> but were sturggling with the GPIO problem (patch No.4 should apply on
> >> a 3.2.2x kernel).
> >>
> >> I'll rename the defconfig and add some recent changes made to
> >> the "official" Raspberry kernel. Expect a single patch in a day or
> >> two.
> > 
> > Attached, a single patch against ipipe-core-3.5.7. This assumes the 
> > appropriate arm patch has already been applied to a virgin stable 3.5.7 
> > tree as per standard instructions.
> > 
> > The raspberry-post.patch provides support for the BCM2835 SoC backported 
> > from the rpi-3.6.y branch[1] up to, and including commit 871eef1b84. A 
> > minimal config is provided (bcmrpi_xenomai_defconfig) in place of the 
> > usual bcmrpi_*_defconfigs.
> > 
> > Credit for the original 3.2.21 Xenomai support should go to ian-cim as 
> > noted in earlier emails - My efforts are limited to backporting and 
> > hacks to the gpio interrupts.
> 
> >
> >
> > Regards, Paul.
> 
> Included in the repository, thanks.
> 
Hi,

I've run into problems compiling the kernel with the above patch from git
when sound drivers are enabled. It looks like some DMA code from commit
https://github.com/torvalds/linux/commit/64ccc9c033c6089b2d426dad3c56477ab066c999
was missing. I've added them in the patch inlined below (to be applied after
Paul's patch). 

Thanks for the work with getting Xenomai on the Pi! :)





diff --git a/include/asm-generic/dma-coherent.h
b/include/asm-generic/dma-coherent.h
index abfb268..2be8a2d 100644
--- a/include/asm-generic/dma-coherent.h
+++ b/include/asm-generic/dma-coherent.h
@@ -29,6 +29,7 @@ int dma_mmap_from_coherent(struct device *dev, struct
vm_area_struct *vma,
 #else
 #define dma_alloc_from_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_coherent(dev, order, vaddr) (0)
+#define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
 #endif
 
 #endif
diff --git a/include/asm-generic/dma-mapping-common.h
b/include/asm-generic/dma-mapping-common.h
index 2e248d8..9073aeb 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -176,7 +176,44 @@ static inline void
dma_sync_single_range_for_device(struct device *dev,
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
 
+extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
+              void *cpu_addr, dma_addr_t dma_addr, size_t size);
+
+/**
+ * dma_mmap_attrs - map a coherent DMA allocation into user space
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @vma: vm_area_struct describing requested user mapping
+ * @cpu_addr: kernel CPU-view address returned from dma_alloc_attrs
+ * @handle: device-view address returned from dma_alloc_attrs
+ * @size: size of memory originally requested in dma_alloc_attrs
+ * @attrs: attributes of mapping properties requested in dma_alloc_attrs
+ *
+ * Map a coherent DMA buffer previously allocated by dma_alloc_attrs
+ * into user space.  The coherent DMA buffer must not be freed by the
+ * driver until the user space mapping has been released.
+ */
+static inline int
+dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
+          dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+   struct dma_map_ops *ops = get_dma_ops(dev);
+   BUG_ON(!ops);
+   if (ops->mmap)
+       return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+   return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+
+#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, NULL)
+
+static inline int dma_mmap_writecombine(struct device *dev, struct
vm_area_struct *vma,
+             void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+   DEFINE_DMA_ATTRS(attrs);
+   dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+   return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, &attrs);
+}
+
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
 





