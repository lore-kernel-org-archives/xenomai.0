Subject: Re: Question regarding RTnet Ethernet Driver with PCIe MSI interrupts
References: <3ea6dbbecbdf44ceab12d6ffed5d0eba@debo1svwi003091.corp.mooginc.com>
 <38113fb102834811a76f4dfb99d94ac2@debo1svwi003091.corp.mooginc.com>
 <CAPRPZsBneN19U93PVT=WqWyUqwS9MJd+Yk4KBQJpi5Lh4hMBvw@mail.gmail.com>
 <0f0cb9dc-5ff4-58ce-ddae-b0c2f6b7abf5@siemens.com>
 <ce5d6a24e1cd46f8a8ba1e14baf599b7@debo1svwi003091.corp.mooginc.com>
 <f38fea62-2c2a-0674-ef97-ef6af3df82a3@siemens.com>
 <98779fb158c14f0d968be1f9441aad45@debo1svwi003091.corp.mooginc.com>
 <c393084a-8236-3229-3cfc-f84ad2e8f6ee@arcor.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <030ff83e-245c-1492-4c18-b6021833a61c@siemens.com>
Date: Mon, 23 Aug 2021 12:27:18 +0200
MIME-Version: 1.0
In-Reply-To: <c393084a-8236-3229-3cfc-f84ad2e8f6ee@arcor.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 23.08.21 10:59, Scott Reed via Xenomai wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> On 18.08.21 12:15, Reed, Scott via Xenomai wrote:
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> On 17.08.21 22:01, Jeroen Van den Keybus via Xenomai wrote:
>>>>> FWIW, in the past I have worked with e1000 NICs in RTnet that
>>>>> registered their MSI interrupt with the kernel.
>>>>>
>>>>> I do not recall that I had to do anything out of the ordinary.
>>>>>
>>>>
>>>> The main difference was likely that you were on x86 while Scott is dealing
>>>> with an i.MX6-based SoC.
>>>>
>>>> I'm not familiar with the details of MSI routing on that target. If I quickly
>>>> understand arch/arm/boot/dts/imx6qdl.dtsi correctly, all MSIs will be folded
>>>> by the PCI host controller into a single SPI (120), the only interrupt source
>>>> that old SoC understands. In that case, you need to make sure that this SPI is
>>>> handled by I-pipe and, indeed, it treated as muxing IRQ. But I have no idea
>>>> how the demuxing will happen in details. You likely need to study and then
>>>> patch the PCI host controller driver.
>>>>
>>>> Jan
>>>
>>> That is correct that I am working with an iMX6-based SoC.
>>>
>>> For anyone who might face similar issues, for information here is my patch to
>>> the Linux 4.14.62 PCI host controller (Xenomai 3.0.7 patch already applied).
>>>
>>
>> Patch got mangled, as you can see below. Seems your client or server
>> decided to have tabs for lunch today.
>>
> Sorry about that! I have incorporated your suggestions from below
> and re-posted the patch hopefully this time not mangled.
>>> Regards,
>>>
>>> Scott
>>>
>>> Subject: [PATCH] Modify PCI MSI interrupts for Xenomai RTDM
>>>
>>> Since we have Xenomai RTDM drivers which are "tied" to PCI MSI
>>> interrupts (e.g. Altera TSE driver), we need to also make the PCI MSI
>>> interrupt an RTDM interrupt to avoid latency when the PCI MSI interrupt
>>> is serviced.
>>>
>>> Since we have Xenomai RTDM drivers which are "tied" to PCI MSI
>>> interrupts (e.g. Altera TSE driver), we need to first pass the MSI
>>> interrupt to the i-ipipe handler. If there is not an RTDM driver for
>>> the interrupt, then the i-pipe handler calls generic_handle_irq.
>>> ---
>>>   drivers/pci/dwc/pci-imx6.c             | 17 ++++++++++-------
>>>   drivers/pci/dwc/pcie-designware-host.c |  2 +-
>>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
>>> index b7348353..65eb9ba5 100644
>>> --- a/drivers/pci/dwc/pci-imx6.c
>>> +++ b/drivers/pci/dwc/pci-imx6.c
>>> @@ -33,6 +33,10 @@
>>>
>>>   #include "pcie-designware.h"
>>>
>>> +#include <xenomai/rtdm/driver.h>
>>> +
>>> +static rtdm_irq_t pcie_msi_irq_handle;
>>> +
>>>   #define to_imx6_pcie(x)dev_get_drvdata((x)->dev)
>>>
>>>   enum imx6_pcie_variants {
>>> @@ -545,13 +549,14 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
>>>   return -EINVAL;
>>>   }
>>>
>>> -static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
>>> +static int imx6_pcie_msi_handler_rtdm(rtdm_irq_t *irq_handle)
>>>   {
>>> -struct imx6_pcie *imx6_pcie = arg;
>>> +struct imx6_pcie *imx6_pcie = rtdm_irq_get_arg(irq_handle, struct imx6_pcie);
>>>   struct dw_pcie *pci = imx6_pcie->pci;
>>>   struct pcie_port *pp = &pci->pp;
>>>
>>> -return dw_handle_msi_irq(pp);
>>> +dw_handle_msi_irq(pp);
>>> +return RTDM_IRQ_HANDLED;
>>
>> Nasty - if dw_handle_msi_irq decides to return UNHANDLED...
>>
> Yes, I was lazy since I (incorrectly) assumed dw_handle_msi_irq always
> returns HANDLED and therefore did not process the return value.
> Is handled in new patch posted below.
>>>   }
>>>
>>>   static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>>> @@ -678,10 +683,8 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>>>   return -ENODEV;
>>>   }
>>>
>>> -ret = devm_request_irq(dev, pp->msi_irq,
>>> -       imx6_pcie_msi_handler,
>>> -       IRQF_SHARED | IRQF_NO_THREAD,
>>> -       "mx6-pcie-msi", imx6_pcie);
>>> +ret = rtdm_irq_request(&pcie_msi_irq_handle, pp->msi_irq, imx6_pcie_msi_handler_rtdm,
>>> +RTDM_IRQTYPE_SHARED, "mx6-pcie-msi", imx6_pcie);
>>>   if (ret) {
>>>   dev_err(dev, "failed to request MSI irq\n");
>>>   return ret;
>>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>>> index a5b8dd07..d0af2cfa 100644
>>> --- a/drivers/pci/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>>> @@ -72,7 +72,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>>   while ((pos = find_next_bit((unsigned long *) &val, 32,
>>>       pos)) != 32) {
>>>   irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
>>> -generic_handle_irq(irq);
>>> +ipipe_handle_demuxed_irq(irq);
>>>   dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
>>>       4, 1 << pos);
>>>   pos++;
>>
>> This function and likely more will no run in primary domain. But, if you
>> are unlucky, it may still used Linux locking or other incompatible
>> calls. Did you check, e.g by enabling I-pipe debugging or by careful
>> code inspection, if there is no such call remaining? It's a classic if
>> that is a trigger for lockups etc.
> I assume your comment above is "will no run"->"will now run".

Yeah, my w-key must have been broken.

> Thanks for the feedback!
> 
> Yes, I did run with I-pipe debugging and other debugging options enabled 
> and saw no issues. The configuration options I turned on are
>   IPIPE_DEBUG
>   IPIPE_DEBUG_CONTEXT
>   IPIPE_DEBUG_INTERNAL
>   XENO_OPT_DEBUG_COBALT
>   XENO_OPT_DEBUG_CONTEXT
> 
> Is this enough to be confident that there are no Linux locking or other
> incompatible calls or is a careful code inspection still necessary?

DEBUG_CONTEXT will catch a brought range of potential issues already,
but only those where the "right" (problematic) patch is actually taken
during the test.

> 
> If careful code inspection is still necessary, can you give me some
> more guidance on what I should be looking for and how to generally
> mitigate problems if they exist?

Well, you generally need to dive into each function called from the
converted IRQ handler, check which locks they may take and possibly
recurse deeper.

> 
> In addition to the Ethernet Rx/Tx PCI MSI interrupts which are 
> distributed to an RTDM (RTnet) Ethernet driver, we have other PCI MSI 
> interrupts which are distributed to non-RTDM drivers. My understanding
> is that the non-RTDM based PCI MSI interrupts are handled by the
> root domain (i.e Linux kernel) and therefore do not need to be checked 
> for Linux locking or other incompatible calls. Is that correct?

Right, handlers registered by Linux against the Linux domain will
continue to run in that context.

> 
> I did inspect the PCI driver code which dispatches the MSI interrupt
> and saw that dw_handle_msi_irq looks like it calls rcu_read_lock/
> rcu_read_unlock via the irq_find_mapping call. Is this problematic?

Conceptually, in any case. Practically, it may depend on the RCU
configuration of the kernel, e.g. what actually is checked and my happen
on unlock. I've just dropped the idea of using a kernel call with
rcu_read_lock internally over Xenomai [1] because I-pipe is not fully
compatible with that. Dovetail (5.10+) is by now, though.

Interestingly, there is also other I-pipe-converted code that calls
irq_find_mapping. Maybe sleeping issues...

Jan

[1] https://xenomai.org/pipermail/xenomai/2021-August/046166.html

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

