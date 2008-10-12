Message-ID: <48F1F2C8.3040802@domain.hid>
Date: Sun, 12 Oct 2008 14:51:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F1D15F.3010902@domain.hid>
In-Reply-To: <48F1D15F.3010902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Hi Alex,
> 
> I commited in trunk a fix of Xenomai heap management for the highmem 
> case. What the patch does is essentially replacing __va_to_kva (which 
> does not work correctly with highmem) with vmalloc_to_page, which is 
> available on all linux versions Xenomai supports.
> 
> However, I found that comedi buffer management also uses __va_to_kva. We 
> can fix SetPageReserved and ClearPageReserved easily to use 
> vmalloc_to_page, however, I do not see what pg_list is used for, so do 
> not really know how to fix it. Here is a proposed patch:
> 
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

Ok. Due to my change the trunk was no longer compiling with comedi
enabled, so I commited a temporary change: instead of storing
__va_to_kva(vaddr) into the pg_list array, I store
page_address(vmalloc_to_page(vaddr)), which should have the same value.
But is incorrect with highmem.

-- 
					    Gilles.

