Message-ID: <45814504.7050905@domain.hid>
Content-Class: urn:content-classes:message
Date: Thu, 14 Dec 2006 13:35:16 +0100
From: "Niklaus Burren" <niklaus.burren@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Registering Interrupt Handler [Scanned]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello

I try to register an interrupt handler for an externel interrupt(GPIO 
105) in a xenomai (2.2.2) kernel module on a ARM processor (PXA 270).
I create a interrupt object with the rt_intr_create() function without 
an error. After that I enable the interrupt with rt_intr_enable(). When 
I run the kernel module on the PXA270 board and put a square signal to 
the GPIO 105 pin the interrupt handler is never called.

// Interrupt Handler
int int_handler(struct xnintr *intr)
{
    printk("Interrupt detected\n");
    return RT_INTR_HANDLED;
}

----

// Enalbe Interrupt in init_module()
err = rt_intr_create(&intr_desc, "GPIO_INT", 10, &int_handler, NULL, NULL);

rt_intr_enable(&intr_desc);

On PXA270 all externel interrupts on GPIO's have the same interrupt 
number (10). Is that a problem? When I get the pin status from the pin 
level register GPLR3 I can detect the square signal at the pin. But the 
interrupt handler function int_handler() is never called.

Is there any other initialization that I had to do?

Kind Regards

Niklaus Burren


