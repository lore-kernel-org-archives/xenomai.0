Message-ID: <59e12ca2-6c6f-09ff-5365-985586dc4e4e@siemens.com>
Date: Tue, 14 Jun 2022 20:02:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] rtdm/drvlib: Prevent pagefaults on arm on io mapping
Content-Language: en-US
References: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gunter Grau <gunter.grau@philips.com>, xenomai@xenomai.org
Cc: Gunter Grau <guntgrau@bbl.ma.philips.com>

On 23.05.22 16:04, Gunter Grau via Xenomai wrote:
> From: Gunter Grau <gunter.grau@philips.com>
> 
> When mapping io memory into userspace an extra simulated pagefault for all
> pages is added to prevent later pagefaults because of copy on write
> mechanisms. This happens only on architectures that have defined the
> needed cobalt_machine.prefault function.
> 
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  kernel/cobalt/rtdm/drvlib.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 4eaf3a57c..db8431ee1 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>  {
>  	pgprot_t prot = PAGE_SHARED;
>  	unsigned long len;
> +	int ret;
>  
>  	len = vma->vm_end - vma->vm_start;
>  #ifndef CONFIG_MMU
> @@ -1774,8 +1775,15 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>  #endif
>  	vma->vm_page_prot = pgprot_noncached(prot);
>  
> -	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
> +	ret = remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>  			       len, vma->vm_page_prot);
> +	if (ret)
> +		return ret;
> +
> +	if (cobalt_machine.prefault)
> +		cobalt_machine.prefault(vma);
> +
> +	return ret;
>  }
>  
>  static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struct *vma)

Wow, that was likely broken by the refactoring in c8e9e166, long ago.

Applied to next

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

