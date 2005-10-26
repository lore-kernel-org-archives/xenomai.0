Message-ID: <435FC965.8040400@domain.hid>
Date: Wed, 26 Oct 2005 20:22:29 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid> <435F2DDA.1030702@domain.hid>
	<435FB6CB.9030307@domain.hid> <435FBDB1.2010109@domain.hid>
In-Reply-To: <435FBDB1.2010109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan!

Jan Kiszka wrote:
[...]
>>rtser[X] should be available as soon as xeno_16550A is loaded, right ?
> 
> 
> Only when you provided the correct module parameters... Isn't that
> documented somewhere? Don't remember right now, but if not, this
> requires fixing. Check what's available on your box via /proc/xenomai/rtdm.

E.g.:
# cat named_devices
Hash    Name                            /proc

I didn't find any page so far documenting the parameters, but they should be
something like this ?
# insmod /usr/realtime/modules/xeno_16550A.ko ioaddr=3f8 irq=4 tx_fifo=10 start_index=0
But I get:
insmod: error inserting '/usr/realtime/modules/xeno_16550A.ko': -1 Device or resource busy

During boot, this appears in the kernel log:
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Maybe this is causing the device to be busy ?

Thanks a lot and best regards,
Hannes.

