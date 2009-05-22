Message-ID: <4A16C110.8040303@domain.hid>
Date: Fri, 22 May 2009 17:13:20 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4A008DC9.1000603@domain.hid> <4A13E8BF.3030703@domain.hid>
	<4A150514.2030901@domain.hid>
	<200905221016.07433.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200905221016.07433.Sebastian.Smolorz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IXXAT-PCI-CAN driver hijacks my pci board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Hi Wolfgang,
> 
> Wolfgang Grandegger wrote:
>> Stefan Kisdaroczi wrote:
>>> Hi Wolfgang,
>>>
>>> Wolfgang Grandegger schrieb:
>>>> [...]
>>>>
>>>>>> dmesg output, there is no IXXAT-PCI-CAN board installed:
>>>>>>> RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>>>>>>> RTCAN SJA1000 driver initialized
>>>>>>> PCI: setting IRQ 12 as level-triggered
>>>>>>> IXXAT-PCI-CAN 0000:00:11.0: found PCI INT A -> IRQ 12
>>>>>>> IXXAT-PCI-CAN: Initializing device 10b5:9050:2503
>>>> OK, it finding a variant of the PLX9050, but it will not use the device
>>>> because of the following lines after the above printout:
>>>>
>>>>     if (sub_sys_id != IXXAT_PCI_SUB_SYS_ID)
>>>>              return -ENODEV;
>>>>
>>>> But ...
>>>>
>>>>>> The following patch fixed it for me (my own driver loads again).
>>>> ... obviously it does  not probe again.
>>> it probes again, but pci_request_regions() failed in my driver.
>>>
>>> In the -ENODEV case, the function pci_release_regions() is not
>>> called in the ixxat driver, so access is blocked for other drivers.
>> That's a bug. Will fix.
> 
> please see:
> 
> https://mail.gna.org/public/xenomai-core/2009-03/msg00055.html
> 
> I sent a patch for exactly this issue on March 10.

Obviously I missed that one as well, sorry. Will send a proper patch
later today or tomorrow. Sebastian, does that mean that you have an
IXXAT PCI card available for testing?

Wolfgang.


