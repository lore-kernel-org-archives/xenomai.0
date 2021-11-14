Subject: Re: [PATCH 1/1] kernel/cobalt/rtdm: Further documentation for
 rtdm_mmap_kmem/vmem/iomem() and rtdm_mmap_to_user()
References: <20211113003314.8758-1-csmithquestions@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7709ec6f-0d3e-e84a-96a0-7345dfe8a2ee@siemens.com>
Date: Sun, 14 Nov 2021 21:11:35 +0100
MIME-Version: 1.0
In-Reply-To: <20211113003314.8758-1-csmithquestions@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: csmith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 13.11.21 01:33, csmith via Xenomai wrote:
> kernel/cobalt/rtdm: Further documentation for rtdm_mmap_kmem/vmem/iomem() 
> Signed-off-by: csmith <csmithquestions@gmail.com>

For legal reasons (same as in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1),
we need a real name here.

> ---
>  kernel/cobalt/rtdm/drvlib.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 7b7b0830c..56da04bf8 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -1973,6 +1973,10 @@ int __rtdm_mmap_from_fdop(struct rtdm_fd *fd, size_t len, off_t offset,
>   * vmalloc(). To map physical I/O memory to user-space use
>   * rtdm_iomap_to_user() instead.
>   *
> + * @note This service is provided only for use in .ioctl operation handlers. 
> + * Otherwise RTDM drivers implementing a .mmap operation should use 
> + * rtdm_mmap_kmem(), rtdm_mmap_vmem(), or rtdm_mmap_iomem().
> + * 

3 trailing whitespaces, says git.

>   * @note RTDM supports two models for unmapping the memory area:
>   * - manual unmapping via rtdm_munmap(), which may be issued from a
>   * driver in response to an IOCTL call, or by a call to the regular
> @@ -2084,7 +2088,7 @@ EXPORT_SYMBOL_GPL(rtdm_iomap_to_user);
>  /**
>   * Map a kernel logical memory range to a virtual user area.
>   *
> - * This routine is commonly used from a ->mmap() handler of a RTDM
> + * This routine is commonly used from a .mmap operation handler of a RTDM
>   * driver, for mapping a virtual memory area with a direct physical
>   * mapping over the user address space referred to by @a vma.
>   *
> @@ -2107,10 +2111,10 @@ int rtdm_mmap_kmem(struct vm_area_struct *vma, void *va)
>  EXPORT_SYMBOL_GPL(rtdm_mmap_kmem);
>  
>  /**
> - * Map a virtual memory range to a virtual user area.
> + * Map a driver's kernel virtual memory range to a virtual user area.

Drop "driver's" - the driver has no private view on the kernel virtual
memory.

>   *
> - * This routine is commonly used from a ->mmap() handler of a RTDM
> - * driver, for mapping a purely virtual memory area over the user
> + * This routine is commonly used from a .mmap operation handler of a RTDM
> + * driver, for mapping a purely virtual kernel memory area over the user

"kernel virtual"

>   * address space referred to by @a vma.
>   *
>   * @param[in] vma The VMA descriptor to receive the mapping.
> @@ -2138,7 +2142,7 @@ EXPORT_SYMBOL_GPL(rtdm_mmap_vmem);
>  /**
>   * Map an I/O memory range to a virtual user area.
>   *
> - * This routine is commonly used from a ->mmap() handler of a RTDM
> + * This routine is commonly used from a .mmap operation handler of a RTDM
>   * driver, for mapping an I/O memory area over the user address space
>   * referred to by @a vma.
>   *
> 

Looks good otherwise.

Thanks!
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

