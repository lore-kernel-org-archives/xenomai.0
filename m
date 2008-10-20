From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 21 Oct 2008 00:45:15 +0200
References: <48F1D15F.3010902@domain.hid>
In-Reply-To: <48F1D15F.3010902@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810210045.16020.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-core] Comedi buffer management.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Gilles,

Sorry for answering so late. I was unable to regularly check my private mails 
the last week; I missed yours.

> I commited in trunk a fix of Xenomai heap management for the highmem
> case. What the patch does is essentially replacing __va_to_kva (which
> does not work correctly with highmem) with vmalloc_to_page, which is
> available on all linux versions Xenomai supports.
>
> However, I found that comedi buffer management also uses __va_to_kva. We
> can fix SetPageReserved and ClearPageReserved easily to use
> vmalloc_to_page, however, I do not see what pg_list is used for, so do
> not really know how to fix it. Here is a proposed patch:

If I remember well, pg_list may be used by some PCI/PCIe DMA components which 
can dump acquired data to physically non-contiguous buffers. In such cases, 
the driver has to provide a list of the pages addresses into which the DMA 
controller can trigger shots.

Many thanks for your fix. 

Alexis.

> Index: ksrc/drivers/comedi/buffer.c
> ===================================================================
> --- ksrc/drivers/comedi/buffer.c	(revision 4211)
> +++ ksrc/drivers/comedi/buffer.c	(working copy)
> @@ -46,7 +46,7 @@ void comedi_free_buffer(comedi_buf_t * b
>  		unsigned long vaddr, vabase = (unsigned long)buf_desc->buf;
>  		for (vaddr = vabase; vaddr < vabase + buf_desc->size;
>  		     vaddr += PAGE_SIZE)
> -			ClearPageReserved(virt_to_page(__va_to_kva(vaddr)));
> +			ClearPageReserved(vmalloc_to_page(vaddr));
>  		vfree(buf_desc->buf);
>  		buf_desc->buf = NULL;
>  	}
> @@ -73,7 +73,7 @@ int comedi_alloc_buffer(comedi_buf_t * b
>
>  	for (vaddr = vabase; vaddr < vabase + buf_desc->size;
>  	     vaddr += PAGE_SIZE)
> -		SetPageReserved(virt_to_page(__va_to_kva(vaddr)));
> +		SetPageReserved(vmalloc_to_page(vaddr));
>
>  	buf_desc->pg_list = comedi_kmalloc(((buf_desc->size) >> PAGE_SHIFT) *
>  					   sizeof(unsigned long));
> @@ -85,7 +85,7 @@ int comedi_alloc_buffer(comedi_buf_t * b
>  	for (vaddr = vabase; vaddr < vabase + buf_desc->size;
>  	     vaddr += PAGE_SIZE)
>  		buf_desc->pg_list[(vaddr - vabase) >> PAGE_SHIFT] =
> -		    __va_to_kva(vaddr);
> +			(unsigned long) vmalloc_to_page(vaddr);
>
>        out_virt_contig_alloc:
>  	if (ret != 0)
>
> Cheers.


