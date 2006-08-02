From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17616.42011.663899.554796@domain.hid>
Date: Wed, 2 Aug 2006 15:09:47 +0200
Subject: Re: [Xenomai-core] Xenomai on PXA
In-Reply-To: <44CDE4C2.77465253@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai@xenomai.org

Detlef Vollmann wrote:
 > > I also added an interrupt handler on a button which is connected to GPIO
 > > pin. The interrupt handler should print something when it is executed.
 > > When I push the button a couple of times nothing happens. So GPIO
 > > interrupts doesn't seems to work.
 > Probably GPIO0 and GPIO1 work.
 > I suspect it's the cascading interrupt that doesn't work.
 > When I played around with an earlier version of ipipe, I found that
 > the IRQ_GPIO_2_80 (IRQ 10 on PXA270) is masked, but never unmasked
 > again.
 > 
 > The problem is that for the cascading interrupt you need a special
 > IPIPE handler, and I don't think there is currently one for PXA.
 > 
 > How is that done on other machines/architectures?

When looking at the ipipe_enable_pipeline function, we see that
interrupts management routines are all intercepted by the I-pipe, so the
cascaded interrupts management routines should be automatically
intercepted. 

In order to have a better understanding of the issue, it would be
interesting if you could trace the functions that are called on the path
from the interrupt to the execution of the final handler.

Re-reading the patch I sent, I also realised that an important part of
the work is missing: the function gettimeoffset should be changed by the
patch too. I would be surprised if your problem was related to this,
though.

-- 


					    Gilles Chanteperdrix.

