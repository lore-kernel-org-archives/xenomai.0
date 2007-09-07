From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F9@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 16:13:59 +0200
Message-Id: <1189174439.26986.89.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] rtdm_iomap_to_user() with PowerPC
Reply-To: rpm@xenomai.org
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

On Thu, 2007-09-06 at 10:45 +0200, Markus Osterried (BA/EDD) wrote:
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
> This is just like it is done in /drivers/char/mem.c and
> in /drivers/video/fbmem.c.
> 
> But I think this is architecture and kernel version dependent and I
> don't know whether rtdm_mmap_buffer() is the right place.
> 
> I use Xenomai 2.3.1 and Linux 2.6.18 with PowerPC CPU. 
> What is the best solution?

The best and only solution is to mark the the I/O pages as guarded
+uncached as expected on powerpc as you did indirectly, but this is
likely to add a great amount of ugly code to the arch-dep wrappers, in
order to do that according to the 2.4 x 2.6 x powerpc x i386 [ x ia64 ]
matrix. This said, wrappers are usually the place where disgusting code
lives anyway.

>  Everyone else seen this problem?
> 
Not sure that many people use rtdm to map some I/O space on powerpc yet,
but in any case, this can't work the way it is done right now. I'll
submit a fix along your suggested lines. Thanks for the report.

> Thanks 
> Markus
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



