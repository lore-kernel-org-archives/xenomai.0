Message-ID: <460D1932.5010305@domain.hid>
Date: Fri, 30 Mar 2007 16:05:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting to Intel IXP425
References: <899865CA54E4444DAF2E3639C04C5F4805EC5F@trillian.at.omicron.at>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC5F@trillian.at.omicron.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

Richard Cochran wrote:
>>Right. And I think the IXP425 has no cascaded IRQ, so you can define
>>__ipipe_mach_irq_mux_p to 0, and do not have to implement
>>__ipipe_mach_demux_irq.
> 
> 
> That was easy.
> 
> (The IXP425 has no cascaded interrupts.)
> 
> Now, about the rest, by reading the other arm ports, I learned the
> following:
> 
> __ipipe_mach_get_dec()
> 
> Returns the periodic timer interval in HW ticks.
> 
> __ipipe_mach_set_dec()
> 
> Sets the periodic timer interval.

The timer is aperiodic (most of the time) when running Xenomai, so
__ipipe_mach_set_dec is called for each timer tick and programs the
timer hardware for the next tick.

> 
> __ipipe_mach_get_tsc()
> 
> Returns the free flowing time stamp register as a 64 bit integer.
> 
> __ipipe_mach_acktimer()
> 
> Called by the timer ISR, clears the timer interrupt.
> 
> __ipipe_mach_release_timer()
> 
> Restores the timer interval to the value expected by Linux.

__ipipe_mach_release_timer is called when Xenomai stops handling the
timer and let Linux handle it.


-- 
                                                 Gilles Chanteperdrix

