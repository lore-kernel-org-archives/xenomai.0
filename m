Message-ID: <4A13DD1C.5080208@domain.hid>
Date: Wed, 20 May 2009 12:36:12 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4A008DC9.1000603@domain.hid> <1242812539.31033.12.camel@domain.hid>
	<4A13D9F6.30602@domain.hid>
In-Reply-To: <4A13D9F6.30602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] IXXAT-PCI-CAN driver hijacks my
 pci board
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Stefan Kisdaroczi <kisda@domain.hid>

Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> Philippe Gerum wrote:
>> It looks like this patch is still pending an ack/nak. Wolfgang, any
>> comment on this? TIA,
> 
> FIFO overrun, sorry.
> 
>> On Tue, 2009-05-05 at 21:04 +0200, Stefan Kisdaroczi wrote:
>>> Hi,
>>>
>>> my pci board has the same pci-interface-chip as the IXXAT-PCI board.
>>> The vendor and device id's are identical, but the subsys id is different.
>>>
>>> The documentation for my board says that it is essential to check all ID values,
>>> because vendor and device id are standard values for the pci-interface-chip.
>>>
>>> dmesg output, there is no IXXAT-PCI-CAN board installed:
>>>> RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>>>> RTCAN SJA1000 driver initialized
>>>> PCI: setting IRQ 12 as level-triggered
>>>> IXXAT-PCI-CAN 0000:00:11.0: found PCI INT A -> IRQ 12
>>>> IXXAT-PCI-CAN: Initializing device 10b5:9050:2503
> 
> OK, it finding a variant of the PLX9050, but it will not use the device  
> because of the following lines after the above printout:
> 
>     if (sub_sys_id != IXXAT_PCI_SUB_SYS_ID)
>              return -ENODEV;
>                 
> But ...
> 
>>> The following patch fixed it for me (my own driver loads again).
> 
> ... obviously it does  not probe again.
> 
>>> However, i could not check if it still detects the CAN board,
>>> as i dont have one.
> 
> 
> 
> 
>>> Thanks
>>> kisda
>>>
>>> --- xenomai-2.4.7.orig/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
>>> +++ xenomai-2.4.7/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
>>> @@ -73,7 +73,7 @@
>>>  #define IXXAT_BASE_PORT_SIZE 0x0400
>>>
>>>  static struct pci_device_id ixxat_pci_tbl[] = {
>>> -	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>>> +	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, IXXAT_PCI_VENDOR_ID, IXXAT_PCI_SUB_SYS_ID, 0, 0, 0},
>>>  	{ }
>>>  };
>>>  MODULE_DEVICE_TABLE (pci, ixxat_pci_tbl);
> 
> I don't have a IXXAT CAN card to check if the sub-vendor id is really
> IXXAT_PCI_VENDOR_ID. Does 
> 
>   {IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, PCI_ANY_ID, IXXAT_PCI_SUB_SYS_ID, 0, 0, 0},
> 
> work as well? A work-around would be to disable the IXXAT-PCI driver in the kernel config.

I just found a lspci output for an IXXAT card and Stefan's patch should
 work fine. Are you going to apply it or should I take care?

Thanks,

Wolfgang.

