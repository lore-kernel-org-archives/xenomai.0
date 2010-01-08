Message-ID: <4B4742B7.5010306@domain.hid>
Date: Fri, 08 Jan 2010 15:35:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4B3CC62D.6070709@domain.hid>	<1262643246.20365.10.camel@domain.hid>	<4B426A3D.5020706@domain.hid>
	<1262775394.7828.9.camel@domain.hid>	<4B446D99.708@domain.hid>	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>	<4B4497BE.7040605@domain.hid>	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>	<4B44E349.1000305@domain.hid>
	<4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>
In-Reply-To: <4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Flavio de Castro Alves Filho wrote:
> Hello Gilles,
> 
> Unfortunately the patch didn't help... :-(
> 
> But ... adding more traces on the code, I can see the irq number when the
> function __ipipe_grab_irq() is called.
> 
> When everything works fine, the irq number is 21 (IRQ_DA8XX_TINT12_0).
> 
> And, sometime, the irq number starts to be 22 (IRQ_DA8XX_TINT34_0). It is
> the other timer present at the processor. I believe that, somehow, the
> information about the timer (at least, the interrupt location) has been
> changed by some code.
> 
> I will investigate more, according to these observations. I accept
> suggestions :-)

Are you sure you recompiled the kernel ? This other timer's irq seems to
be the one for which the handle_edge_irq handler is used, which could
really cause a lockup.

Anyway, the reason why this other timer is used is probably because
clockevent decided it had a better score. But that should not cause a
lockup, unless handle_edge_irq is used.

So, you are probably better off using that timer for xenomai too. If you
do not want that, you will have to give a higher score to the timer you
want Linux to use.

-- 
					    Gilles.

