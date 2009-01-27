Message-ID: <497EBA3A.2050504@domain.hid>
Date: Tue, 27 Jan 2009 08:39:38 +0100
From: Federico Ridolfo <federico.ridolfo@domain.hid>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid> <49799B02.1010202@domain.hid>	
	<4979F92A.70702@domain.hid> <497A074A.1050104@domain.hid>	
	<497A09E5.5080906@domain.hid> <497AE64B.2000304@domain.hid>	
	<497DA01E.1070305@domain.hid>
	<d6c8ef150901260652w1f0ecf5cmfd0b48ff75adb9c9@domain.hid>
In-Reply-To: <d6c8ef150901260652w1f0ecf5cmfd0b48ff75adb9c9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: federico.ridolfo@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai@xenomai.org

Sure. I'll describe what i did for SPI driver on PSC3
in order to use OF:
- add a right node in dts file:
       spi@domain.hid {        // PSC3 in spi mode
            compatible = "rtdm-spi","rtdm-spi";
            cell-index = <2>;
            reg = <0x2400 0x100>;
            interrupts = <2 3 0>;
            interrupt-parent = <&mpc5200_pic>;
        };
       
- add headers in my rtdm driver:
#if defined(CONFIG_PPC_MERGE)
#include <linux/of.h>
#include <linux/of_platform.h>
#endif

- use OF to get irq in the rtdm driver:
#ifdef CONFIG_PPC_MERGE
    /* Use Open Firmware device tree */
    struct device_node *np = NULL;
    struct resource r[2] = {};

    np = of_find_compatible_node(np, NULL, "rtdm-spi");
   
    if (np == NULL)
    {
        rtdm_printk("np = NULL!??!");
        return -ENODEV;
    }
   
    ret = of_address_to_resource(np, 0, &r[0]);
    if (ret)
    {
        rtdm_printk("of_address_to_resource returns: %d",ret);
        return ret;
    }

    of_irq_to_resource(np, 0, &r[1]);
   
    intr = r[1].start;
    rtdm_printk("irq from OF:%d\n",intr);
#else
    intr = MPC52xx_PSC3_IRQ;
#endif

- compile kernel and make dtb

I'm using u-boot 1.3.0 and both uImage, dtb and rootfs
are in a UDMA Compact Flash on ATA.

Ciao

Bosko Radivojevic wrote:
> Federico,
>
> may you write a small comment regarding what you had to change
> (especially regarding OF). Just for the rest of us ;)
>
> Thanks.
>
> On Mon, Jan 26, 2009 at 12:35 PM, Federico Ridolfo
> <federico.ridolfo@domain.hid> wrote:
>   
>> Thanks, now my rtdm drrivers work!!
>> You are great.
>>     
>
>   


