Message-ID: <46E14935.3020902@domain.hid>
Date: Fri, 07 Sep 2007 14:51:01 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_iomap_to_user() with PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>
Cc: xenomai@xenomai.org

Markus Osterried (BA/EDD) wrote:
>
> Hello,
>
> I want to use rtdm_iomap_to_user() to map our device registers to user 
> space.
> But this doesn't work, our application just crashes when I read from 
> the mapped registers.
>
> When I insert the line
>
>         vma->vm_page_prot = phys_mem_access_prot(filp, 
> paddr>>PAGE_SHIFT, size, vma->vm_page_prot);
>
> in rtdm_mmap_buffer() just before calling xnarch_remap_io_page_range() 
> it works fine.
> This is just like it is done in /drivers/char/mem.c and in 
> /drivers/video/fbmem.c.
>
> But I think this is architecture and kernel version dependent and I 
> don't know whether rtdm_mmap_buffer() is the right place.
>
> I use Xenomai 2.3.1 and Linux 2.6.18 with PowerPC CPU.
> What is the best solution? Everyone else seen this problem?
>

I had the same problem, but I solved this by using 2 drivers, one linux 
driver that implemented mmap, and an RTDM driver for the realtime 
functions.  On startup I do the mmap, and then enter RT-mode and can use 
this mapped area in my RT-application. But it would be better if the 
mmap function would also be supported by Xenomai.

Kind regards,
    Johan Borkhuis

