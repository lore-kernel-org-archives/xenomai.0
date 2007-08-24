Message-ID: <46CF319B.1030602@domain.hid>
Date: Fri, 24 Aug 2007 21:29:31 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46CC16CD.7080603@domain.hid> <46CF2970.6070804@domain.hid>
In-Reply-To: <46CF2970.6070804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN driver for EMS CPC PCI card
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
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> the following patch changes:
>>
>> 2007-08-22  Wolfgang Grandegger  <wg@domain.hid>
>>
>>     * ksrc/drivers/can/sja1000: Add the RT-Socket-CAN SJA1000 driver
>>     rtcan_ems_pci.c for the EMS CPC PCI card from EMS Dr. Thomas
>>     Wuensche (http://www.ems-wuensche.de).
>>
>> I would like to apply it to Xenomai's trunk and v2.3.x branch.
>>
> 
> I few quick comments from my side:
> 
>  - Could you submit new code already Lindent'ified? This keeps the
>    effort bounded to convert the rest one day.

I was already thinking about it.

>> Index: ksrc/drivers/can/sja1000/rtcan_ems_pci.c
>> ===================================================================
>> --- ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 0)
>> +++ ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 0)
> ...
>> +#define EMS_PCI_SINGLE 0 /* this is a single channel device */
> 
> This define is unused - is this intended?

Well, there are more. I'm going to remove them.

>> +static int rtcan_ems_pci_add_chan(struct pci_dev *pdev, int channel,
>> +				   struct rtcan_device **master_dev)
>> +{
>> +    struct rtcan_device *dev;
>> +    struct rtcan_sja1000 *chip;
>> +    struct rtcan_ems_pci *board;
>> +    unsigned long addr;
>> +    int ret, init_step = 1;
> 
> ret!=0 always means error here? In that case I find "err" a more telling
> variable name ("if (err) ..." -- personal flavour).

Agreed.

>> +    /* Register and setup interrupt handling */
>> +#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
>> +    chip->irq_flags = RTDM_IRQTYPE_SHARED;
>> +#else
>> +    chip->irq_flags = 0;
>> +#endif
> 
> That #ifdef is redundant, just use RTDM_IRQTYPE_SHARED unconditionally.

OK.

>> +#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
>> +    if ((ret = rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
>> +				      &master_dev)))
>> +	    goto failure_cleanup;
>> +    if ((ret = rtcan_ems_pci_add_chan(pdev, EMS_PCI_SLAVE,
>> +				      &master_dev)))
>> +	    goto failure_cleanup;
>> +#else
>> +    printk("Shared interrupts not enabled, using single channel!\n");
>> +    if ((ret = rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
>> +				      &master_dev)))
>> +	    goto failure_cleanup;
>> +#endif
> 
> The master registration should be moved out off the #ifdef - it's identical.

Yes, right.

> Besides this, I have no concerns merging it, also into 2.3. Thanks for
> your effort!

OK, thanks for reviewing the code.

Wolfgang.


