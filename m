Message-ID: <45B3DD0A.3010303@domain.hid>
Date: Sun, 21 Jan 2007 22:37:14 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PPC405: DMA-problem solved!
References: <200701172333.25574.niklaus.giger@domain.hid>	<45AF306E.4070606@domain.hid>
	<200701200006.45387.niklaus.giger@domain.hid>
	<45B1CD21.1090307@domain.hid>
In-Reply-To: <45B1CD21.1090307@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Niklaus Giger wrote:
>> Am Donnerstag, 18. Januar 2007 09:31 schrieb Wolfgang Grandegger:
>>> Niklaus Giger wrote:
>>>> Hi
>>>>
>>>> I tried to simply an example program how to use interrupts
>>>> with Xenomai (see attached Makefile & dma_4xx_int_module.c).
>>>>
>>>> The interrupt part of the example works, but the DMA transfer (memory to
>>>> memory) using the OnChipMemory fails. I think I must somewhere specify
>>>> that the src/dst adressed should not be cached, but I do not know how to
>>>> do it.
>>> consistant_alloc() should help. It's used in the kernel in various
>>> places, e.g. in "drivers/net/ibm_emac".
>> Thank you for your tips.
>>
>> After fixing two bugs in arch/ppc/syslib/ppc4xx_dma.c. See  
>>  * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025697.html
>>  * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025700.html
>> my example code worked (tested with DMA channel 0 and DMA channel 3).
>> <..>
>>
>> Interrupt code is ported to RTDM.
>>
>> @Jan: Can the attached patch be applied?
> 
> Almost, just the usual nitpicking comments below. :)
> 
>> Best regards
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> Index: examples/rtdm/pp4xx_interrupt/dma_4xx_int_module.c
>> ===================================================================
>> --- examples/rtdm/pp4xx_interrupt/dma_4xx_int_module.c	(Revision 0)
>> +++ examples/rtdm/pp4xx_interrupt/dma_4xx_int_module.c	(Revision 0)
> 
> This demo is about how to use the driver API (/wrt interrupts) + how to
> do PPC4xx-specific DMA. So my suggestion:
> 
> examples/rtdm/driver-api/dma-ppc4xx.c
> 
> In any case, we need to resolve the arch dependency somehow. I guess
> it will  currently not fly when I kick the full build in examples/ for a
> non-PPC platform. Any *simple* way to catch this? Would also be
> applicable to the heartbeat-x86 example then, though this will not cause
> build troubles.

The only simple way I see is referencing the configured kernel tree.

>> @@ -0,0 +1,167 @@
>> +/* * Written by Niklaus Giger <niklaus.giger@domain.hid>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of the
>> + * License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>> + *
>> + ****************************************************************************
>> + *
>> + * This is an example howto write a Xenomai kernel module which handles a
>> + * HW interrupt. The example is PPC4xx specific (testd on a PPC405 board)
>> + * Probably also works on a PPC44x (not yet tested, needs a different irq?).
>> + *
>> + * Beware!
>> + * The following patches must be applied to your kernel to fix bugs
> 
> Which kernel? I guess this issue will not persist forever.

Hopefully not.

> 
>> + * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025697.html
>> + * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025700.html
>> + *
>> + * Beware!
>> + * The kernel option PPC4xx DMA must be activated for this test.
> 
> Please provide the full CONFIG_OPTION_NAME here.
> 
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <asm/ppc4xx_dma.h>
>> +
>> +#include <rtdm/rtdm_driver.h>
>> +#include <rtdm/rtdm.h>
>> +rtdm_irq_t irq_handle;
>> +
>> +MODULE_DESCRIPTION("PPC4xx DMA3 interrupt demo");
>> +MODULE_AUTHOR("niklaus.giger@domain.hid");
>> +MODULE_LICENSE("GPL");
>> +
>> +#define DMA_NR 3
>> +int irq = DMA_NR + 5; /* DMA-x interrupt line  on PPC405GPr */
>> +
>> +#define TEST_STRING  "Could we use a DMA + interrupt to copy a string?"
>> +#define TEST_STRING2 "Should be overwritten."
>> +#define STRING_SIZE 128
>> +
>> +char *SRC;
>> +char *DST;
>> +
>> +static ppc_dma_ch_t p_init;
>> +
>> +#define show_irq(irq) 	{						\
>> +	printk("%32s: IRQ %2d uipr 0x%08x uier 0x%08x uisr 0x%08x\n",	\
>> +		__FUNCTION__, irq, 					\
>> +		mfdcr(DCRN_UIC_PR(UIC0)), mfdcr(DCRN_UIC_ER(UIC0)),	\
>> +		mfdcr(DCRN_UIC_SR(UIC0)));				\
>> +	printk("%32s: residue %d status 0x08%x cntrl 0x%08x\n",__FUNCTION__,\
>> +		ppc4xx_get_dma_residue(DMA_NR),				\
>> +		ppc4xx_get_dma_status(),				\
>> +		mfdcr(DCRN_DMACR0 + (DMA_NR * 0x8)));			\
>> +	printk("src at %p is %s\ndst at %p is %s\n", (char *)SRC,	\
>> +		SRC, &DST[0], &DST[0]); }
>> +
>> +void dma_mem_to_mem(void *src, void *dst, unsigned int length,
>> +			unsigned int use_interrupt)
>> +{
>> +#warning Do not use dma_mem_to_mem for OnChipMemory! It will not work.
> 
> Why do we have a compiler warning here, why not a comment?
> 
>> +	int res = 0;
>> +	memset((char *)&p_init, sizeof(p_init), 0);
>> +	p_init.polarity = 0;
>> +	p_init.pwidth   = PW_8;
>> + 	res = ppc4xx_init_dma_channel(DMA_NR, &p_init);
>> +	if (res) {
>> +		printk("%32s: nit_dma_channel return %d %d bytes dest %p\n",
>> +			__FUNCTION__, res, length, dst);
>> +	}
>> +	res = ppc4xx_clr_dma_status(DMA_NR);
>> +	if (res) { 
>> +		printk("%32s: ppc4xx_clr_dma_status %d\n", __FUNCTION__, res);
>> +	}
>> +#warning flush_dcache_all is a performance killer, but I do not know at the 
>> +#warning moment how to flush only the parts needed
> 
> Can we resolve this? Wolfgang?

flush_dcache_range should do the job. Or even better use the DMA-API 
described in Documentation/DMA-API.txt to get DMA'able memory (as 
pointed out recently on the linuxppc-emmbedded ML).

>> +	flush_dcache_all(); /* from arch/ppc/kernel/misc.S */
>> +
>> +	ppc4xx_set_dma_mode(DMA_NR, DMA_MODE_MM);
>> +	ppc4xx_set_src_addr(DMA_NR, virt_to_bus(src));
>> +	ppc4xx_set_dst_addr(DMA_NR, virt_to_bus(dst));
>> +	ppc4xx_set_dma_count(DMA_NR, length);
>> +	ppc4xx_enable_dma(DMA_NR);
>> +	if (use_interrupt) {
>> +		res = ppc4xx_enable_dma_interrupt(DMA_NR);
>> +	} else {
>> +		res = ppc4xx_disable_dma_interrupt(DMA_NR);
>> +	}
>> +	if (res) { 
>> +		printk("%32s: en/disable_dma_interrupt %d return %d per %d\n",
>> +		__FUNCTION__, use_interrupt, res, 
>> +		ppc4xx_get_peripheral_width(DMA_NR));
>> +	}
>> +}
>> +
>> +int dma_irq_handler(rtdm_irq_t *irq_handle)
>> +{
>> +	ppc4xx_disable_dma(DMA_NR);
>> +	ppc4xx_disable_dma_interrupt(DMA_NR);
>> +	show_irq(irq);
>> +	return RTDM_IRQ_HANDLED;
>> +}
>> +
>> +int init_module()
>> +{
>> +	if (rtdm_irq_request(&irq_handle, irq,  dma_irq_handler, 0, "dma3_4xx", 0)) {
>> +		printk("%s:%s Error: rtdm_irq_request failed\n",
>> +			 __FILE__, __FUNCTION__);
>> +		return 1;
>> +	}
>> +	show_irq(irq);
>> +	if (rtdm_irq_enable (&irq_handle)) {
>> +		printk("%s:%s Error: rtdm_irq_enable failed\n",
>> +			 __FILE__, __FUNCTION__);
>> +		return 1;
>> +	}
> 
> This demo will go to trunk, thus rtdm_irq_enable is no longer needed.
> 
>> +
>> +	SRC = (char *)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(STRING_SIZE));
>> +	DST = (char *)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(STRING_SIZE));
>> +
>> +	strncpy(SRC, TEST_STRING,  STRING_SIZE);
>> +	strncpy(DST, TEST_STRING2, STRING_SIZE);
>> +
>> +	flush_dcache_all(); /* from arch/ppc/kernel/misc.S */
>> +	dma_mem_to_mem(SRC, DST, STRING_SIZE, 1);
>> +	if (ppc4xx_get_dma_residue(DMA_NR)) { 
>> +		printk("%32s: residue %d status 0x%x\n",__FUNCTION__,
>> +		ppc4xx_get_dma_residue(DMA_NR),
>> +		ppc4xx_get_dma_status());
>> +	}
>> +	return 0;
>> +	
>> +	
>> +}
>> +
>> +void cleanup_module ()
>> +{
>> +	ppc_dma_ch_t dma_ch;
>> +	if (ppc4xx_get_dma_residue(DMA_NR)) {
>> +		printk("%32s: residue %d status 0x%x\n",__FUNCTION__,
>> +		ppc4xx_get_dma_residue(DMA_NR),
>> +		ppc4xx_get_dma_status());
>> +	}
>> +	ppc4xx_get_channel_config(DMA_NR, &dma_ch);
>> +	printk("%32s: dma_ch.control 0x%x %d SRC %p %s\n",__FUNCTION__, dma_ch.control,
>> +		dma_ch.pwidth, SRC,__TIME__);
>> +
>> +	if (rtdm_irq_disable (&irq_handle)) {
>> +		printk("%32s: rtdm_irq_disable failed\n",__FUNCTION__);
>> +	}
> 
> Disabling is typically not needed, unless it is the only way to silence
> the IRQ source. Keep in mind that this disabling would be fatal if the
> IRQ happened to be shared (though unusual on PPC, AFAIK).
> 
>> +	if (rtdm_irq_free (&irq_handle)) {
>> +		printk("%32s: rtdm_irq_free failed\n",__FUNCTION__);
>> +	}
>> +	show_irq(irq);
>> +}

And should we not also use rtdm_prinkt()?

>> Index: examples/rtdm/pp4xx_interrupt/Makefile
>> ===================================================================
>> --- examples/rtdm/pp4xx_interrupt/Makefile	(Revision 0)
>> +++ examples/rtdm/pp4xx_interrupt/Makefile	(Revision 0)
>> @@ -0,0 +1,47 @@
>> +###### CONFIGURATION ######
>> +###### Please adapt it to your needs
>> +O:=/usr/src/build-hcu3-2.6.19.1
>> +DESTDIR:=/home/hcu/rootfs/niklaus_2.6.19
>> +KSRC:=/usr/src/linux-2.6.19.1
>> +
>> +ARCH:=ppc
>> +CROSS_COMPILE:=ppc_4xx-
>> +PATH:=/home/opt/eldk/4_0/usr/bin:/usr/local/bin:/usr/bin:/bin
>> +M:=$(shell pwd)

This is your private stuff and should be removed.

>> +### List of applications to be build
>> +XENO=$(DESTDIR)/usr/xenomai
>> +### Note: to override the search path for the xeno-config script, use "make XENOCONFIG=..."
>> +
>> +
>> +### List of modules to be build
>> +MODULES = dma_4xx_int_module
>> +
>> +### Note: to override the kernel source path, use "make KSRC=..."
>> +
>> +###### KERNEL MODULE BUILD (no change required normally) ######
>> +ifneq ($(MODULES),)
>> +
>> +OBJS     := ${patsubst %, %.o, $(MODULES)}
>> +CLEANMOD := ${patsubst %, .%*, $(MODULES)}
>> +PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
>> +
>> +### Kernel 2.6
>> +obj-m        := $(OBJS)
>> +EXTRA_CFLAGS :=-I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)
>> +
>> +MODMAKE:=make CROSS_COMPILE=$(CROSS_COMPILE)  ARCH=$(ARCH) O=$(O) -C $(KSRC) M=$(M) PATH=$(PATH) -I$(KSRC)/include/xenomai
>> +
>> +modules:
>> +	$(MODMAKE) modules
>> +
>> +install:	modules
>> +	$(MODMAKE) INSTALL_MOD_PATH=$(DESTDIR) modules_install
>> +
>> +all::	modules
>> +
>> +clean::
>> +	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
>> +	$(RM) -R .tmp*
>> +
>> +endif

Anyway, the Makefile /examples/rtdm/driver-api/Makefile should work fine 
for this example as well.

>> Index: examples/common/Makefile
>> ===================================================================
>> --- examples/common/Makefile	(Revision 2079)
>> +++ examples/common/Makefile	(Arbeitskopie)
>> @@ -3,9 +3,9 @@
>>  ### List of applications to be build
>>  APPLICATIONS = hw_direct_io
>>  
>> -### Note: to override the search path for the xeno-config script, use "make XENO=..."
>> +### Note: to override the search path for the xeno-config script, use "make XENOCONFIG=..."
> 
> If you prefer XENOCONFIG, please provide patches for the whole examples
> repos. :)
> 
>> +### Note: if you installed it into a non standard place add DESTDIR=/path/to/installed/xenomai"
> 
> The hint to DESTDIR is useful, but the explanation should be more like
> "if Xenomai was installed with DESTDIR set, the same must be provided here".
> 
>>  
>> -
>>  ### List of modules to be build
>>  MODULES =
>>  
>> @@ -14,6 +14,8 @@
>>  
>>  ### Note: to override the kernel source path, use "make KSRC=..."
>>  
>> +# default place to install the resulting binaries
>> +EXEC_PREFIX := $(DESTDIR)/usr/xenomai/bin
>>  
>>  
>>  ###### USER SPACE BUILD (no change required normally) ######
>> @@ -24,7 +26,9 @@
>>  ### Sanity check
>>  ifeq ($(XENOCONFIG),)
>>  all::
>> -	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
>> +	@echo ">>> Invoke make like this: \"make XENOCONFIG=/path/to/xeno-config\" <<<"
>> +	@echo ">>> add KSRC=.. to override the default kernel source at /lib/modules/$(shell uname -r)/build <<<"
> 
> KSRC is unrelated here (user space part of the makefile).
> 
>> +	@echo ">>> add DESTDIR=/path/to/installed/xenomai if you installed it into a non standard place <<<"
> 
> See earlier comment.
> 
>>  	@echo
>>  endif
>>  
>> @@ -40,6 +44,9 @@
>>  clean::
>>  	$(RM) $(APPLICATIONS) *.o
>>  
>> +install::   $(APPLICATIONS)
>> +	cp $(APPLICATIONS) $(EXEC_PREFIX)/
>> +
> 
> NACK. I'd rather like to keep the makefile focused (the next step would
> be to add uninstall, then ...).
> 
>>  endif
>>  
>>  
>> @@ -80,3 +87,4 @@
>>  	$(RM) -R .tmp*
>>  
>>  endif
>> +
>>
>>

What does the hw_direct_io example do? As I see it, it's not related to 
Xenomai.

Wolfgang.

