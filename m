Message-ID: <4506E45B.8090605@domain.hid>
Date: Tue, 12 Sep 2006 18:46:19 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<4506A66F.5080801@domain.hid>
	<200609121807.49179.matthias.fuchs@domain.hid>
In-Reply-To: <200609121807.49179.matthias.fuchs@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Matthias Fuchs wrote:
> Hi,
> 
> here's the 2nd try:
> - updated external clock frequency handling
> - use request_mem_region() before remapping memory
> - renamed local variable mem to vmem in clean loop because it shadowed a 	
> module parameter

I have one more comment, sorry. I think you should use:

     volatile void __iomem *vmem;

and the cleanup in case of error is not OK. See below.

> Now it's on you to decide if we should merge and/or rename. I wouldn't merge 
> because of my former arguments. But do not care about me:-)

Fine for me for the time being.

> Matthias

Wolfgang

> On Tuesday 12 September 2006 14:22, Wolfgang Grandegger wrote:
>> Hi Matthias,
>>
>> Matthias Fuchs wrote:
>>> Hi,
>>>
>>> attached you will find a patch that adds support for memory mapped
>>> SJA1000 CAN controllers as they often can be found on embedded boards.
>>> The driver is based on the rtmen_isa driver.
>> What about using request_mem_region()? While looking to the driver I now
>> realize, that it's mainly duplicated code. Does it not make more sense
>> to make a combined io/mem driver. If io address < 32K it's an io driver
>> else a mem driver.
>>
>>
>> ------------------------------------------------------------------------
>>
>> Index: ksrc/drivers/can/sja1000/Kconfig
>> ===================================================================
>> --- ksrc/drivers/can/sja1000/Kconfig	(revision 1564)
>> +++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
>> @@ -13,6 +13,16 @@
>>         int "Maximum number of ISA devices"
>>         default 4       
>>  
>> +config XENO_DRIVERS_RTCAN_SJA1000_MEM
>> +       depends on XENO_DRIVERS_RTCAN_SJA1000
>> +       tristate "Memory mapped controllers"
>> +       default n
>> +
>> +config XENO_DRIVERS_RTCAN_SJA1000_MEM_MAX_DEV
>> +       depends on XENO_DRIVERS_RTCAN_SJA1000_MEM
>> +       int "Maximum number of memory mapped controllers"
>> +       default 4       
>> +
>>  config XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI
>>         depends on XENO_DRIVERS_RTCAN_SJA1000
>>         tristate "PEAK PCI Card"
>> Index: ksrc/drivers/can/sja1000/rtcan_mem.c
>> ===================================================================
>> --- ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 0)
>> +++ ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 0)
>> @@ -0,0 +1,213 @@
>> +/*
>> + * Copyright (C) 2006 Matthias Fuchs <matthias.fuchs@domain.hid>,
>> + *                    Jan Kiszka <jan.kiszka@domain.hid>
>> + * 
>> + * RTCAN driver for memory mapped SJA1000 CAN controller
>> + * This code has been tested on esd's CPCI405/EPPC405 PPC405 systems.
>> + * 
>> + * This driver is derived from the rtcan-isa driver by 
>> + * Wolfgang Grandegger and Sebastian Smolorz. 
>> + *
>> + * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
>> + * Copyright (C) 2005, 2006 Sebastian Smolorz
>> + *                          <Sebastian.Smolorz@domain.hid>
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; eitherer version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software Foundation,
>> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/ioport.h>
>> +#include <linux/delay.h>
>> +
>> +#include <rtdm/rtdm_driver.h>
>> +
>> +#include <rtdm/rtcan.h>
>> +#include <rtcan_dev.h>
>> +#include <rtcan_raw.h>
>> +#include <rtcan_internal.h>
>> +#include <rtcan_sja1000.h>
>> +#include <rtcan_sja1000_regs.h>
>> +
>> +#define RTCAN_DEV_NAME    "rtcan%d"
>> +#define RTCAN_DRV_NAME    "sja1000-mem"
>> +
>> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_MEM_MAX_DEVS
>> +#define RTCAN_MEM_MAX_DEV CONFIG_XENO_DRIVERS_RTCAN_MEM_MAX_DEV
>> +#else
>> +#define RTCAN_MEM_MAX_DEV 2
>> +#endif
>> +
>> +static char *mem_board_name = "mem mapped";
>> +
>> +MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@domain.hid>");
>> +MODULE_DESCRIPTION("RTCAN driver for memory mapped SJA1000 controller");
>> +MODULE_SUPPORTED_DEVICE("mem mapped");
>> +MODULE_LICENSE("GPL");
>> +
>> +static u32 mem[RTCAN_MEM_MAX_DEV];
>> +static int irq[RTCAN_MEM_MAX_DEV];
>> +static u32 clock[RTCAN_MEM_MAX_DEV];
>> +static u8 ocr[RTCAN_MEM_MAX_DEV];
>> +static u8 cdr[RTCAN_MEM_MAX_DEV];
>> +
>> +compat_module_int_param_array(mem, RTCAN_MEM_MAX_DEV);
>> +compat_module_int_param_array(irq, RTCAN_MEM_MAX_DEV);
>> +compat_module_int_param_array(clock, RTCAN_MEM_MAX_DEV);
>> +compat_module_byte_param_array(ocr, RTCAN_MEM_MAX_DEV);
>> +compat_module_byte_param_array(cdr, RTCAN_MEM_MAX_DEV);
>> +
>> +MODULE_PARM_DESC(mem, "The io-memory address");
>> +MODULE_PARM_DESC(irq, "The interrupt number");
>> +MODULE_PARM_DESC(clock, "External clock frequency (default 16 MHz)");
>> +MODULE_PARM_DESC(ocr, "Value of output control register (default 0x1a)");
>> +MODULE_PARM_DESC(cdr, "Value of clock divider register (default 0xc8");
>> +
>> +#define RTCAN_MEM_RANGE 0x80
>> +
>> +struct rtcan_mem
>> +{
>> +    u8 *vmem; 
>> +};
>> +
>> +static struct rtcan_device *rtcan_mem_devs[RTCAN_MEM_MAX_DEV];
>> +
>> +static u8 rtcan_mem_readreg(struct rtcan_device *dev, int reg)
>> +{
>> +    struct rtcan_mem *board = (struct rtcan_mem *)dev->board_priv;
>> +    return readb(board->vmem + reg);
>> +}
>> +
>> +static void rtcan_mem_writereg(struct rtcan_device *dev, int reg, u8 val)
>> +{
>> +    struct rtcan_mem *board = (struct rtcan_mem *)dev->board_priv;
>> +    writeb(val, board->vmem + reg);
>> +}
>> +
>> +int __init rtcan_mem_init_one(int idx)
>> +{
>> +    struct rtcan_device *dev;
>> +    struct rtcan_sja1000 *chip;
>> +    struct rtcan_mem *board;
>> +    int ret;
>> +    
>> +    if ((dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
>> +			       sizeof(struct rtcan_mem))) == NULL)
>> +        return -ENOMEM;
>> +
>> +    chip = (struct rtcan_sja1000 *)dev->priv;
>> +    board = (struct rtcan_mem *)dev->board_priv;
>> +
>> +    dev->board_name = mem_board_name; 
>> +
>> +    chip->irq_num = irq[idx];
>> +    chip->irq_flags = RTDM_IRQTYPE_SHARED;
>> +    chip->read_reg = rtcan_mem_readreg;
>> +    chip->write_reg = rtcan_mem_writereg;
>> +
>> +    if (!request_mem_region(mem[idx], RTCAN_MEM_RANGE, RTCAN_DRV_NAME)) {
>> +	ret = -EBUSY;
>> +	goto out_dev_free;
>> +    }
>> +
>> +    /* ioremap io memory */
>> +    if (!(board->vmem = (u8*)ioremap(mem[idx], RTCAN_MEM_RANGE))) {
>> +        release_mem_region(mem[idx], RTCAN_MEM_RANGE);
>> +	ret = -EBUSY;
         goto out_release_mem;
>> +    }
>> +
>> +    /* Clock frequency in Hz */
>> +    if (clock[idx])
>> +	dev->can_sys_clock = clock[idx] / 2;
>> +    else
>> +	dev->can_sys_clock = 8000000; /* 16/2 MHz */
>> +
>> +    /* Output control register */
>> +    if (ocr[idx])
>> +	chip->ocr = ocr[idx];
>> +    else
>> +	chip->ocr = SJA_OCR_MODE_NORMAL | SJA_OCR_TX0_PUSHPULL;
>> +
>> +    if (cdr[idx])
>> +	chip->cdr = cdr[idx];
>> +    else
>> +	chip->cdr = SJA_CDR_CAN_MODE | SJA_CDR_CLK_OFF | SJA_CDR_CBP;
>> +
>> +    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
>> +
>> +    ret = rtcan_sja1000_register(dev);
>> +    if (ret) {
>> +	printk(KERN_ERR "ERROR %d while trying to register SJA1000 device!\n",
>> +	       ret);
	goto out_iounmap;
>> +    }
>> +    
>> +    rtcan_mem_devs[idx] = dev;
>> +    return 0;
>> +    
>> + out_iounmap:
>> +    iounmap(board->vmem);

      out_release_mem:
	release_mem_region(mem[idx], RTCAN_MEM_RANGE);
>> +
>> + out_dev_free:
>> +    rtcan_dev_free(dev);
>> +
>> +    return ret;
>> +}
>> +
>> +/** Init module */
>> +static int __init rtcan_mem_init(void)
>> +{
>> +    int                         i;
>> +    int                         ret;
>> +    int done = 0;
>> +    for (i = 0; 
>> +	 i < RTCAN_MEM_MAX_DEV && mem[i] != 0; 
>> +	 i++) {
>> +
>> +	if ((ret = rtcan_mem_init_one(i) != 0)) {
>> +	    return ret;
>> +	}
>> +	done++;
>> +    }
>> +    if (done)
>> +	return 0;
>> +    printk(KERN_ERR "ERROR! No devices specified! "
>> +	   "Use mem=<base_addr1>[,...] irq=<irq1>[,...]\n");
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +
>> +/** Cleanup module */
>> +static void __exit rtcan_mem_exit(void)
>> +{
>> +    int i;
>> +    struct rtcan_device *dev;
>> +    u8 *vmem;
>> +
>> +    for (i = 0; i < RTCAN_MEM_MAX_DEV; i++) {
>> +	    dev = rtcan_mem_devs[i];
>> +	    if (!dev)
>> +		    continue;
>> +	    vmem = ((struct rtcan_mem *)dev->board_priv)->vmem;
>> +	    rtcan_sja1000_unregister(dev);
>> +	    iounmap(vmem);
>> +	    release_mem_region(mem[i], RTCAN_MEM_RANGE);
>> +    }
>> +}
>> +
>> +module_init(rtcan_mem_init);
>> +module_exit(rtcan_mem_exit);
>> Index: ksrc/drivers/can/sja1000/Makefile
>> ===================================================================
>> --- ksrc/drivers/can/sja1000/Makefile	(revision 1564)
>> +++ ksrc/drivers/can/sja1000/Makefile	(working copy)
>> @@ -8,11 +8,13 @@
>>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI) += xeno_rtcan_peak_pci.o
>>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG) += xeno_rtcan_peak_dng.o
>>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_ISA) += xeno_rtcan_isa.o
>> +obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_MEM) += xeno_rtcan_mem.o
>>  
>>  xeno_rtcan_sja1000-y := rtcan_sja1000.o rtcan_sja1000_proc.o
>>  xeno_rtcan_peak_pci-y := rtcan_peak_pci.o
>>  xeno_rtcan_peak_dng-y := rtcan_peak_dng.o
>>  xeno_rtcan_isa-y := rtcan_isa.o
>> +xeno_rtcan_mem-y := rtcan_mem.o
>>  
>>  else
>>  
>> @@ -24,6 +26,7 @@
>>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI) += xeno_rtcan_peak_pci.o 
>>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG) += xeno_rtcan_peak_dng.o 
>>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_ISA) += xeno_rtcan_isa.o 
>> +obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_MEM) += xeno_rtcan_mem.o
>>  
>>  list-multi := xeno_rtcan_sja1000.o 
>>  
>> @@ -31,6 +34,7 @@
>>  xeno_rtcan_peak_pci-objs := rtcan_peak_pci.o
>>  xeno_rtcan_peak_dng-objs := rtcan_peak_dng.o
>>  xeno_rtcan_isa-objs := rtcan_isa.o
>> +xeno_rtcan_mem-objs := rtcan_mem.o
>>  
>>  export-objs := $(xeno_rtcan_sja1000-objs)
>>  
>> @@ -49,4 +53,7 @@
>>  
>>  xeno_rtcan_isa.o: $(xeno_rtcan_isa-objs)
>>  	$(LD) -r -o $@ $(xeno_rtcan_isa-objs)
>> +
>> +xeno_rtcan_mem.o: $(xeno_rtcan_mem-objs)
>> +	$(LD) -r -o $@ $(xeno_rtcan_mem-objs)
>>  endif


