Message-ID: <467A5EEA.1020608@domain.hid>
Date: Thu, 21 Jun 2007 13:20:10 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4677B095.3070903@domain.hid>
In-Reply-To: <4677B095.3070903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Switch to pci_register_driver
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

Hi Jan,

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> can we just switch over to pci_register_driver in order to avoid
> deprecated (and soon removed) pci_module_init? Or do we also need some
> wrapper for older 2.4 kernels (latest 2.4 is already aligned with 2.6)?

It works with 2.4.25, at least and from my point of view it can be applied.

Thanks.

Wolfgang.

> Jan
> 
> 
> Index: ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
> ===================================================================
> --- ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Revision 2609)
> +++ ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Arbeitskopie)
> @@ -307,7 +307,7 @@ static struct pci_driver rtcan_ixxat_pci
> 
>  static int __init rtcan_ixxat_pci_init(void)
>  {
> -    return pci_module_init(&rtcan_ixxat_pci_driver);
> +    return pci_register_driver(&rtcan_ixxat_pci_driver);
>  }
> 
> 
> Index: ksrc/drivers/can/sja1000/rtcan_peak_pci.c
> ===================================================================
> --- ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(Revision 2609)
> +++ ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(Arbeitskopie)
> @@ -346,7 +346,7 @@ static struct pci_driver rtcan_peak_pci_
> 
>  static int __init rtcan_peak_pci_init(void)
>  {
> -    return pci_module_init(&rtcan_peak_pci_driver);
> +    return pci_register_driver(&rtcan_peak_pci_driver);
>  }
> 
> 
> 


