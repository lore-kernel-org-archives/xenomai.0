Message-ID: <de83bb21-4a49-b100-3903-a9842fc84ae1@siemens.com>
Date: Mon, 21 Mar 2022 13:43:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ipipe: noarch: Fix handling of PCIe MSI interrupts for
 dwc PCIe controller
Content-Language: en-US
References: <e8077dad-f6ae-329a-d7df-a6be28b43b76@arcor.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e8077dad-f6ae-329a-d7df-a6be28b43b76@arcor.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Scott Reed <scott.reed@arcor.de>, xenomai@xenomai.org

On 18.03.22 17:53, Scott Reed wrote:
> Handling of PCIe MSI interrupts resulted in system
> hanging or high latencies.
> 
> Fix is to replaced missed call to generic_handle_irq with
> ipipe_handle_irq().
> 
> Signed-off-by: Scott Reed <scott.reed@arcor.de>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c9fd4e4966ba..7b566da64438 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -100,7 +100,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  			irq = irq_find_mapping(pp->irq_domain,
>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
>  					       pos);
> -			generic_handle_irq(irq);
> +			ipipe_handle_demuxed_irq(irq);
>  			pos++;
>  		}
>  	}

Thanks, applied to noarch, ipipe/master and stable/4.19.x.

Greg, you can pick up.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

