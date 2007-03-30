Message-ID: <460CFFB6.7010902@domain.hid>
Date: Fri, 30 Mar 2007 14:16:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Porting to Intel IXP425
References: <899865CA54E4444DAF2E3639C04C5F4805EC5C@trillian.at.omicron.at>
	<E1HXFOe-0003Vm-25@domain.hid>
In-Reply-To: <E1HXFOe-0003Vm-25@domain.hid>
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org, Richard Cochran <richard.cochran@domain.hid>

Sebastian Smolorz wrote:
> Richard Cochran wrote:
> 
>>Looking at __ipipe_mach_irq_mux_p and __ipipe_mach_demux_irq:
>>
>>The 'mux_p' seems to identify one of the IRQs, and this IRQ is special
>>in some way. The 'mux' here stands for 'multiplex', I guess. But what
>>exactly is the meaning of this macro?
> 
> 
> It has to determine whether a given IRQ is cascaded and therefore must be 
> specially serviced WRT acknowledging. The required acknowledging of 
> IRQ-subchannels is done in __ipipe_mach_demux_irq together with the call of 
> __ipipe_handle_irq() after having determined the correct IRQ number where 
> necessary.
> 

Right. And I think the IXP425 has no cascaded IRQ, so you can define
__ipipe_mach_irq_mux_p to 0, and do not have to implement
__ipipe_mach_demux_irq.

-- 
                                                 Gilles Chanteperdrix

