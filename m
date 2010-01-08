Message-ID: <4B4750E1.20703@domain.hid>
Date: Fri, 08 Jan 2010 16:36:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4B426A3D.5020706@domain.hid>
	<1262775394.7828.9.camel@domain.hid>	<4B446D99.708@domain.hid>	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>	<4B4497BE.7040605@domain.hid>	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>	<4B44E349.1000305@domain.hid>	<4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>	<4B4742B7.5010306@domain.hid>
	<4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>
In-Reply-To: <4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>
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
> In fact,
> 
> The problem is not really related to the other timer, I believe.
> 
> Before the timer with irq 22 is called, another irq is called by
> __ipipe_grab_irq(): the irq number 12 (IRQ_DA8XX_CCERRINT).
> 
> Now I'm looking for the place there this irq number is passed.
> 
> And thank you for this important information about the timers.

I think your problem really is that irq22 uses handle_edge_irq, somehow.
Could you check whether this is the case, for instance by putting a
printk in the __ipipe_ack_edge_irq function, file kernel/irq/chip.c ?

-- 
					    Gilles.

