Message-ID: <53F4B4DA.6050703@mitre.org>
Date: Wed, 20 Aug 2014 10:46:50 -0400
From: Jeffrey Melville <jmelville@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtdm_iomap_to_user caching followup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

All,

There was a patch applied back in January 2013 to disable caching with 
memory areas mapped with rtdm_iomap_to_user. 
(http://www.xenomai.org/pipermail/xenomai/2013-January/027370.html)

Henri Roosen followed up in September 2013 to say that he still saw 
caching behavior with rtdm_iomap_to_user. The original patch didn't 
cover the ifdef LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,16) && 
defined(CONFIG_MMU). He submitted two patch options but I didn't see any 
responses. 
(http://www.xenomai.org/pipermail/xenomai/2013-September/029211.html)

I'm currently working with a Zynq ZC706, using Xenomai 2.6.3 on top of 
the Xilinx fork of the 3.8 kernel, as described in the README. The FPGA 
guys gave me a test FPGA image with a (dumb) AXI slave that has a very 
small register space. Pulling a cache line actually overflows the 
register space and causes the bus to lock up. I added a logic analyzer 
block to the FPGA to confirm the access addresses.

More importantly, I don't want any of that address space cached even 
when the register space gets bigger. I was able to fix my problems by 
changing this line:

- remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot); \
+ remap_pfn_range(vma,from,(to) >> 
PAGE_SHIFT,size,pgprot_noncached(prot)); \

Can we apply the patch? I can provide a new one if it is lost. Or is 
there a better way to use rtdm_iomap_to_user that lets the caller 
specify caching behavior? I couldn't find one.

As a side note, has anyone successfully used Xenomai with Zynq on 
kernels newer than 3.8? I haven't found any newer pre/post patches and 
haven't had time to play around with manually merging it yet. I'd be 
willing to help if this is an area of need.

Cheers,
Jeff

