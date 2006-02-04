Message-ID: <43E50376.1000205@domain.hid>
Date: Sat, 04 Feb 2006 20:41:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] SMI-doc improvement / RTDM paper
References: <43E4F63C.4090200@domain.hid> <43E4F739.90204@domain.hid>
	<43E50233.8020807@domain.hid>
In-Reply-To: <43E50233.8020807@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Hi Philippe,
>>>
>>>this patch tries to clarify where to solve SMI-related latencies. Or
>>>should we even mention the kconfig path?
>>>
>>
>>The name of the config switch involved should be enough, I guess.
> 
> 
> What about this? Please apply if it's ok.
> 

Done, thanks.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/arch/i386/smi.c
> ===================================================================
> --- ksrc/arch/i386/smi.c	(Revision 539)
> +++ ksrc/arch/i386/smi.c	(Arbeitskopie)
> @@ -209,8 +209,9 @@
>  
>  #else /* ! CONFIG_XENO_HW_SMI_WORKAROUND */
>  
> -    printk("Xenomai: Intel chipset found and SMI workaround not enabled,\n"
> -           "       you may encounter high interrupt latencies.\n");
> +    printk("Xenomai: Intel chipset found but SMI workaround not enabled (check\n"
> +           "         CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter high\n"
> +           "         interrupt latencies!\n");
>      pci_dev_put(dev);
>  
>  #endif /* ! CONFIG_XENO_HW_SMI_WORKAROUND */


-- 

Philippe.

