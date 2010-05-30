Message-ID: <4C02124C.6070000@domain.hid>
Date: Sun, 30 May 2010 09:22:52 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTimibgE4TlTLTaehsyZWQbrJBXCAeRaMTj0dEdZR@mail.gmail.com>
In-Reply-To: <AANLkTimibgE4TlTLTaehsyZWQbrJBXCAeRaMTj0dEdZR@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Beagleboard and RTDM serial example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

On 05/30/2010 03:44 AM, Everett Wang wrote:
> Hi All,
> 
> I have made some progress in getting RTDM 16550A working for my
> beagleboard. Followed
> Wolfgang's instructions, I first set uart 0,1 free from kernel then
> load 16550A driver.
> 
> setserial /dev/ttyS0 uart none
> setserial /dev/ttyS1 uart none
> 
> I can load the driver fine:
> insmod /lib/modules/2.6.33.3/kernel/drivers/xenomai/serial/xeno_16550A.ko
> mem=0x4806a000 irq=72 baud_base=3000000
> 
> The baud_base is set to 3000000 since the
> linux/arch/arm/plat-omap/include/plat/serial.h defined
> OMAP24XX_BASE_BAUD  3000000. Hope this is OK.
> after that I can see the rtser0 in the /proc/xenomai/rtdm:
> 
> cat /proc/xenomai/rtdm/rtser0/information
> driver:         xeno_16550A
> version:        1.5.2
> peripheral:     UART 16550A
> provider:       Jan Kiszka
> class:          2
> sub-class:      0
> flags:          EXCLUSIVE  NAMED_DEVICE
> 
> But I can only create one rtser. When I tried to create an other rtser
> for ttyS1, I had this:
> 
> insmod /lib/modules/2.6.33.3/kernel/drivers/xenomai/serial/xeno_16550A.ko
> mem=0x4806c000 irq=73 baud_base=3000000
> insmod: error inserting
> '/lib/modules/2.6.33.3/kernel/drivers/xenomai/serial/xeno_16550A.ko':
> -1 File exists
> 
> I could also do the ttyS1 first. It will create an rtser0 as well. But
> when I do insmod for ttyS0, it will have the same error message.
> 
> How can I create rtser0 and rtser1 for beagleboard?

insmod ... mem=0x4806a000,0x4806c000 irq=72,73 baud_base=3000000,3000000

Wolfgang.

