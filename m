Message-ID: <43CE1C28.6060001@domain.hid>
Date: Wed, 18 Jan 2006 11:44:56 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Missing IRQ end function on PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

with RTnet over Xenomai and Linux 2.4 on PowerPC I realized that Xenomai 
does not distinguish between a normal IRQ enable and an IRQ unmask at 
the end of an ISR (to reenable the IRQ). In the latter case the IRQ 
should be enabled on PowerPC as shown:

    if (rthal_irq_descp(irq)->handler->end != NULL)
  	   rthal_irq_descp(irq)->handler->end(irq);
     else
	   rthal_irq_descp(irq)->handler->enable(irq);

To handle this case properly, we need to different functions, I think.

Wolfgang.


