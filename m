Message-ID: <4C2DC68C.1040306@domain.hid>
Date: Fri, 02 Jul 2010 12:59:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278061090.2358.33.camel@domain.hid>	
	<4C2DAF63.4040708@domain.hid>
	<1278066286.8669.9.camel@domain.hid>
In-Reply-To: <1278066286.8669.9.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Adeos I-PIPE NS9215 port problem
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Iker Amescua <iamescua@domain.hid>
Cc: adeos-main@gna.org

Iker Amescua wrote:
> Thanks a lot!
> 
> Now at least it boots. This is what I have done (I expect correctly):
> 
> IRQ are now handled by 
> #ifndef CONFIG_IPIPE
> 		set_irq_handler(i, handle_prio_irq);
> #else
> 		set_irq_handler(i, handle_edge_irq);
> #endif /*CONFIG_IPIPE*/
> 
> And in irqs.h
> #define irq_finish(irq) irq_desc[irq].chip->eoi(irq);
> 
> Is this correct?
> 
> The problem now it locks up during boot. This is the console output:

Ok. Try handle_level_irq instead of handle_edge_irq, if your irq
controller is well-behaved enough, it should work.

> What are these errors?
> [42949376.490000] Xenomai: hal/arm started.
> [42949376.490000] Xenomai: scheduling class idle registered.
> [42949376.500000] Xenomai: scheduling class rt registered.
> [42949377.740000] Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts)
> loaded.
> [42949378.290000] Xenomai: native skin init failed, code -38.
> [42949378.290000] Xenomai: starting POSIX services.
> [42949378.830000] Xenomai: POSIX skin init failed, code -38.
> [42949379.370000] Xenomai: RTDM skin init failed, code -38.

Probably something wrong with the timer initialization. Are you sure the
kernel uses the clock you think it uses? One reason may be that the
timer you are requesting is in the CLOCK_EVT_MODE_SHUTDOWN state,
meaning that it is not used by the kernel. Also, I see no trace
indicating that the Linux kernel uses your clock source. You should see
something like:

Switching to clocksource foo

in the kernel sources, unless you have not implemented a clock source?

-- 
					    Gilles.

