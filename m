From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17359.34362.870823.168739@domain.hid>
Date: Thu, 19 Jan 2006 13:29:46 +0100
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
In-Reply-To: <43CE1C28.6060001@domain.hid>
References: <43CE1C28.6060001@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > with RTnet over Xenomai and Linux 2.4 on PowerPC I realized that Xenomai 
 > does not distinguish between a normal IRQ enable and an IRQ unmask at 
 > the end of an ISR (to reenable the IRQ). In the latter case the IRQ 
 > should be enabled on PowerPC as shown:
 > 
 >     if (rthal_irq_descp(irq)->handler->end != NULL)
 >   	   rthal_irq_descp(irq)->handler->end(irq);
 >      else
 > 	   rthal_irq_descp(irq)->handler->enable(irq);
 > 
 > To handle this case properly, we need to different functions, I think.

I am not sure I understand what you mean. Would you want functions
rthal_end_irq and xnarch_end_irq added and that this xnarch_end_irq
would be called in xnintr_irq_handler when XN_ISR_ENABLE is set ?

-- 


					    Gilles Chanteperdrix.

