Message-ID: <4B44E349.1000305@domain.hid>
Date: Wed, 06 Jan 2010 20:23:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	
	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>	
	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>	
	<4B3CC62D.6070709@domain.hid>	
	<1262643246.20365.10.camel@domain.hid>	
	<4B426A3D.5020706@domain.hid>
	<1262775394.7828.9.camel@domain.hid>	
	<4B446D99.708@domain.hid>	
	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>	
	<4B4497BE.7040605@domain.hid>
	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>
In-Reply-To: <4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>
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
> I believe there is a lockup during the irq handling process.
> 
> I could not find where it is blocking.
> 
> I performed the following tests:
> 
> 1) add traces in every function related to interrupt ... and none was called

Well, obviously, you missed some, because your boot logs indicate
clearly that at least the timer interrupt is working.

If you are interested in what happens at I-pipe level, the functions you
are interested in are ipipe_grab_irq, ipipe_handle_irq,
ipipe_mach_demux_irq, etc...

> 
> 2) add traces in every function in time.c file. After the last message
> ("ata1: SATA max UDMA/133 irq 67"), the following functions were called:
> - read_cycles()
> - timer32_read()
> 
> Looking at these functions, they seam to be fine. I have no clue about where
> to start debugging.
> 
> Thank you for all your help.

Try this:

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 5a324c9..22ddbe2 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -360,9 +360,11 @@ void __init davinci_irq_init(void)
        for (i = 0; i < DAVINCI_N_AINTC_IRQ; i++) {
                set_irq_chip(i, &davinci_irq_chip_0);
                set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+#ifndef CONFIG_IPIPE
                if (i != IRQ_TINT1_TINT34)
                        set_irq_handler(i, handle_edge_irq);
                else
+#endif /* CONFIG_IPIPE */
                        set_irq_handler(i, handle_level_irq);
        }
 }

-- 
					    Gilles.

