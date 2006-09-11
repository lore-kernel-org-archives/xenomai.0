Message-ID: <4505A75B.8000601@domain.hid>
Date: Mon, 11 Sep 2006 20:13:47 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
References: <4503EB88.2040309@domain.hid>
	<1157988739.4991.11.camel@domain.hid> <450584D7.6050009@domain.hid>
	<200609111904.16512.matthias.fuchs@domain.hid>
In-Reply-To: <200609111904.16512.matthias.fuchs@domain.hid>
Content-Type: multipart/mixed; boundary="------------020307090508070309040204"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020307090508070309040204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthias Fuchs wrote:
> On Monday 11 September 2006 17:46, Wolfgang Grandegger wrote:
>>> A possible explanation is that configurations only using the timer IRQ
>>> are not affected, since the decrementer is not subject to this issue
>>> (the tick handler returns XN_ISR_NOENABLE anyway).
>> I run RT-Socket-CAN on a CAN PCI Card on my MPC5200 without any 
>> problems, so far (under Linux 2.4). Here the end function of the PIC:
>>
>>    static void
>>    mpc5xxx_ic_end(unsigned int irq)
>>    {
>>          if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
>>                  mpc5xxx_ic_enable(irq);
>>    }
>>
>> Matthias, have you printed out the value of status? I'm just curious.
>>
>> Wolfgang.
> 
> Here it comes:
> bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
> _end: status=00000042
> bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
> _end: status=00000042
> bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
> _end: status=00000042
> 
> So it's IRQ_DISABLED (=2).

In 2.6 the interrupts are disabled by default. Then the attached patch 
for Xenomai should help.

Wolfgang.

--------------020307090508070309040204
Content-Type: text/x-patch;
 name="xenomai-irqend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-irqend.patch"

+ diff -u xenomai/ksrc/arch/powerpc/hal.c.IRQEND xenomai/ksrc/arch/powerpc/hal.c
--- xenomai/ksrc/arch/powerpc/hal.c.IRQEND	2006-08-23 22:12:17.000000000 +0200
+++ xenomai/ksrc/arch/powerpc/hal.c	2006-09-11 20:00:32.000000000 +0200
@@ -326,6 +326,7 @@
         rthal_irq_descp(irq)->handler->enable == NULL)
         return -ENODEV;
 
+    rthal_irq_descp(irq)->status &= ~IRQ_DISABLED;
     rthal_irq_descp(irq)->handler->enable(irq);
 
     return 0;
@@ -341,6 +342,7 @@
         rthal_irq_descp(irq)->handler->disable == NULL)
         return -ENODEV;
 
+    rthal_irq_descp(irq)->status |= IRQ_DISABLED;
     rthal_irq_descp(irq)->handler->disable(irq);
 
     return 0;

--------------020307090508070309040204--

