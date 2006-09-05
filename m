Message-ID: <44FD99E9.6030500@domain.hid>
Date: Tue, 05 Sep 2006 17:38:17 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid>
In-Reply-To: <44FD7463.7010601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> in the process of preparing to merge rtdm_irq_enable into
> rtdm_irq_request I would like to check if the attached patch is ok, thus
> we could finally drop rtdm_irq_enable once the API is refactored. Please
> check carefully when the first IRQs may happen and what the handler
> expects to be initialised! SJA1000 /should/ be ok as it works with

> shared IRQs, but MSCAN does not (why, BTW?) and /may/ stumble.

OK. Why should I use shared interrupts if there is no need? Most 
embedded PowerPC systems have a dedicated interrupt source.

Wolfgang.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/drivers/can/mscan/rtcan_mscan.c
> ===================================================================
> --- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1559)
> +++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
> @@ -801,7 +801,8 @@ int __init rtcan_mscan_init_one(int idx)
>  	printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
>  	goto out_dev_free;
>      }
> -    
> +    rtdm_irq_enable(&dev->irq_handle);
> +
>      mscan_chip_config(regs);
>      
>  
> @@ -814,8 +815,6 @@ int __init rtcan_mscan_init_one(int idx)
>  
>      rtcan_mscan_create_proc(dev);
>  
> -    rtdm_irq_enable(&dev->irq_handle);
> -    
>      /* Remember initialized devices */
>      rtcan_mscan_devs[idx] = dev;
>  
> Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
> ===================================================================
> --- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 1559)
> +++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
> @@ -747,6 +747,7 @@ int rtcan_sja1000_register(struct rtcan_
>  	printk("ERROR! IRQ %d busy or invalid (code=%d)!\n", chip->irq_num, ret);
>  	return ret;
>      }
> +    rtdm_irq_enable(&dev->irq_handle);
>  
>      sja1000_chip_config(dev);
>  
> @@ -759,8 +760,6 @@ int rtcan_sja1000_register(struct rtcan_
>  
>      rtcan_sja_create_proc(dev);
>  
> -    rtdm_irq_enable(&dev->irq_handle);
> -    
>      return 0;
>  
>   out_irq_free:


