From: Joshua Karch <jkarch48@hotmail.com>
Subject: Re: xeno-gpio-xilinx causes gpio-xilinx's IRQ
 callback(xgpio_irqhandler) to trigger rather than gpio-core's
 "gpio_pin_interrupt"
Date: Mon, 19 Oct 2020 20:21:00 +0000
Message-ID: <BLAPR19MB4500867CA7117889C80CCB3ADA1E0@BLAPR19MB4500.namprd19.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Greg,


It=92s been a while since I=92ve attacked this issue, but I started looking=
 into the problem again.  I had to add EXPORT_SYMBOL(__ipipe_dispatch_irq) =
in order to suppress the following message:



gpio_xilinx: Unknown symbol __ipipe_dispatch_irq (err -2)

> modprobe: ERROR: could not insert 'gpio_xilinx': Unknown symbol in module=
, or

>  unknown parameter (see dmesg)

Doing this still did not stop the device from remaining trapped in an infin=
ite loop once the IRQ was triggered, but the =93pipeline safe=94 warnings w=
ent away and overall the system seemed more stable before arming the interr=
upt system, however the handler is still not occurring it seems. I=92ve tho=
ught about combining gpio-xilinx.c and the xeno_gpio_xilinx driver into a s=
ingle unified Xenomai only driver, but that seems like quite the task.  I=
=92m still not sure where to go from here.

Best,

Josh Karch

