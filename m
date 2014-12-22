Date: Mon, 22 Dec 2014 12:39:01 +0100 (CET)
From: tbultel@free.fr
Message-ID: <313558430.28992900.1419248341128.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <1390423758.28955749.1419246785381.JavaMail.root@zimbra90-e16.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] How to properly steal the interrupt line of a linux
 device from rtdm driver ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

On a x86 machine, we historically had an issue due to a conflict on IRQ18,
between the rtcan_ixx_pci driver and uhci-hcd.
It was not possible to workaround it, by switching the card to another slot.

As the machine has 6 USB ports, and we could afford losing 2 of them, 
we decided to disable the USB controllerthat uses the IRQ18, by adding:

request_irq(chip->irq_num, fake_irq_handler, 0, "ixxat_irq_requested", chip)

... in the code of the rtcan_ixx_pci driver, before calling rtcan_sja1000_register.

And it worked fine, because the usb driver was loaded later, as kernel module,
and as the IRQ is not flagged as shared, it does not get it. 
The "fake" handler does nothing but returns IRQ_NONE.


It worked until today, because we now want to boot on USB, and therefore the USB drivers must
be builtin.


Thus, I am attempting to hack a little more, by unregistering all the linux IRQs handlers
of IRQ18, before registering the fake handler in place.

I have taken __free_irq as a base, and written a free_irq_force(unsigned int irq)
that does not need a devid, because I want to unregister all devices.
The function can be summarized as "desc->action = NULL",
but I kept all the things around.

I checked that the action list is empty after the call, but for some reason, that does not work.
If I plug an USB keyboard, the IRQ happens again, and I am getting a:

Xenomai: xnintr_shirq_handler: IRQ18 not handled. Disabling IRQ line.

... and the USB keyboard works. My fake handler is not called, either.

I am a little puzzled, and do not understand what I am missing. It sounds just like I modified the wrong action list,
or if it was cached somewhere else.

Any ideas ?
Regards
Thierry

