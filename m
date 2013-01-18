MIME-Version: 1.0
From: Pierre LE COZ <peter.le.coz@gmail.com>
Date: Fri, 18 Jan 2013 16:15:47 +0100
Message-ID: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I have simple program to manage the GPIO of my raspberry Pi using RTDM.

I use :
"rtdm_irq_request(& irq_exemple, num_irq, exemple_handler,
RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE, "MyProgram", NULL);"
in order to detect interrupts.

After repeated presses on a pushbutton linking my input GPIO to 3,3v, I run
:
# cat /proc/xenomai/irq
IRQ CPU0
3: 1134 [timer]
108: 0 MyProgram
259: 0 [virtual]

No interrupt is taken into account.

Please, does anyone can help?




PS : Without Xenomai, I can detect interrupts with the same set-up :

# cat /proc/interrupts
CPU0
3: 14053 ARMCTRL BCM2708 Timer Tick
52: 10 ARMCTRL BCM2708 GPIO catchall handler
65: 6 ARMCTRL ARM Mailbox IRQ
66: 0 ARMCTRL VCHIQ doorbell
75: 7942676 ARMCTRL dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb1
77: 148 ARMCTRL bcm2708_sdhci (dma)
83: 452 ARMCTRL uart-pl011
84: 1297 ARMCTRL mmc0
108: 10 GPIO MyProgram
Err: 0

To do so I use "request_irq(gpio_to_irq(RPI_GPIO_IN), rpi_gpio_2_handler,
IRQF_SHARED | IRQF_TRIGGER_RISING, THIS_MODULE->name, THIS_MODULE->name);"
