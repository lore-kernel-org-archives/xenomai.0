From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] Porting to Intel IXP425
Date: Fri, 30 Mar 2007 13:35:55 +0200
References: <899865CA54E4444DAF2E3639C04C5F4805EC5C@trillian.at.omicron.at>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC5C@trillian.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HXFOe-0003Vm-25@domain.hid>
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
> Looking at __ipipe_mach_irq_mux_p and __ipipe_mach_demux_irq:
>
> The 'mux_p' seems to identify one of the IRQs, and this IRQ is special
> in some way. The 'mux' here stands for 'multiplex', I guess. But what
> exactly is the meaning of this macro?

It has to determine whether a given IRQ is cascaded and therefore must be 
specially serviced WRT acknowledging. The required acknowledging of 
IRQ-subchannels is done in __ipipe_mach_demux_irq together with the call of 
__ipipe_handle_irq() after having determined the correct IRQ number where 
necessary.

-- 
Sebastian

