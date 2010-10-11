Message-ID: <4CB367AA.6020403@domain.hid>
Date: Mon, 11 Oct 2010 21:38:18 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<1286611432.13186.200.camel@domain.hid>	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>	<4CB2B98A.8010605@domain.hid>	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
	<4CB36116.8090507@domain.hid>
In-Reply-To: <4CB36116.8090507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Peter Pastor <peter.pastor@domain.hid>

On 10/11/2010 09:10 PM, Gilles Chanteperdrix wrote:
> Peter Pastor wrote:
>> Hey Gilles,
>>
>> Thanks for the hint. I "fixed" this problem by loading the nvidia driver
>> (instead of nv) as default. Now the graphic cards uses IRQ 24 which does not
>> collide with IRQ 11 of the CAN bus card (see attached lspci.txt).
>>
>> The only other device that uses IRQ 11 is
>> # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port
>> [8086:3406] (rev 13)
>>
>> But I guess that is ok, is it ? I checked the FAQs and went through the list
>> but I feel I can't do much. I will try a few things and disable everything
>> that is unneeded. The FAQ list also suggests to enable CONFIG_PCI_MSI which
>> is disabled right now. What would now be a reasonable thing to do ?
> 
> Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.
> 
>>
>> How can I find out and about which device is causing the address space
>> collision ?
>>
>> # address space collision: host bridge window [mem 0xd7f00000-0xe0000000]
>> conflicts with PCI Bus 0000:00 [mem 0xe0000000-0xf7ffffff]
>>
>> I attached the syslog of the latest boot. I enabled some debugging infos
>> which hopefully allow to trace down the problem. Interestingly, this time,
>> the kernel spit out
>>
>> # RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>>
>> right before it froze.
> 
> You should try and put some printks in RTCan code to see how far it
> goes. But I guess Wolfgang may be of more help.

Well, normally messages like:

  RTCAN SJA1000 driver initialized
  PEAK-PCI-CAN: initializing device 001c:0001
  PEAK-PCI-CAN: base_addr=c907c000 conf_addr=c907a000 irq=16
  rtcan: registered rtcan0
  PEAK-PCI-CAN: base_addr=c907e400 conf_addr=c907a000 irq=16
  rtcan: registered rtcan1

should follow. I would add printk's into peak_pci_init_one() and
rtcan_peak_pci_add_chan() in ksrc/drivers/can/sja1000/rtcan_peak_pci.c.
Did you compile the SJA1000 driver's into the kernel? Try building
modules, which you then can load manually.

BTW: what PEAK PCI card are you using?

Wolfgang.

