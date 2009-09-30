Message-ID: <4AC346C7.4040600@domain.hid>
Date: Wed, 30 Sep 2009 13:53:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>
In-Reply-To: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Guide] To patch Linux Kernel with Xenomai for
 Unknown core
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org, Jorge Ramirez <jorge.ramirez.ortiz@domain.hid>, mohamad.sharifi@domain.hid

Didenko Sergey wrote:
> Dear Xenomai experts,
> 
> So far there is:
> 
> - xenomai-2.4.9.1
> - linux-2.6.29
> - ARM architecture based on (unknown for Xenomai core)
> - It supports CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS
> - there is no cascaded interrupts
> 
> 1) I'm following the steps described in README.INSTALL and HOWTO -
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
> And since I'm very new in Linux as well is in Xenomai (thank God for
> this project) all my problems are from that I'm not quite sure whether
> I'm doing all steps correct or not.
> 
> For now on I have done with:
> 
> - prepare kernel with adeos patch
> - configure kernel with its original defconfig file (the original
> configuration is verified and working fine on target board)
> - building kernel (and here we are!)
> 
> 2) I did add implementation for (even though the  I did not find any
> link to it in HOWTO, so I referred to PXA's implementation):
> __ipipe_check_tickdev (called from kernel\core.c)
> 
> And for:
> mv88f6290_osmr0_set_mode
> mv88f6290_osmr0_set_next_event
> ckevt_mv88f6290_osmr0

> Even though all of them are required by __ipipe_mach_release_timer() I
> did not find in HOWTO how these functions should be implemented for
> MYCORE, so I referred to PXA's implementation again.

No, you should not add these functions. They already exist if your board
supports GENERIC_CLOCKEVENT and GENERIC_TIME.

> 
> 3) Then I did define all next things:
> 
> #define IRQ_OST0    IRQ_MV88F6290_TIMER0    /* OS Timer IRQ number match */
> #define OSCR        __REG(TIMER0_VAL)        /* (TIMER_VIRT_BASE +
> 0x0014) - OS timer 0 Register*/
> #define OSMR0        __REG(TIMER_CTRL)        /* (TIMER_VIRT_BASE +
> 0x0000) - OS timers Control Register*/
> #define OIER_E0        (1 << 0)                    /* Interrupt enable
> channel 0 */
> 
> Since, according to documentation, there is no PENDING (Status) register
> for the timer I did comment all the lines required these definitions.
> *QUESTION: Please tell me am I right or not and what to do if it is
> still required?*
> 
> //#define OSSR        __REG(TIMER0_RELOAD)     /* OS Timer Status
> Register */
> //#define OSSR_M0        (1 << 0)                    /* Match status
> channel 0 */
> 
> 4) Now I have a problem to define OIER value /* OS Timer Interrupt
> Enable Register */
> According to Documentation, timer has 3 registers: Control, Reload and
> Timer Register.
> *QUESTION: What to do with OIER, have no idea, need some one kick me in
> right direction!*

These registers are specific to the PXA hardware timer. The reason why
we do have to implement the I-pipe support for each and every ARM SOC is
that well, hardware timers are really different from ARM to ARM. So,
what you should do is implement the support for the hardware timer of
your SOC, not copy the PXA hardware timer implementation. The PXA
implementation in the guide is an example, it is not meant to be
reproduced literally.

-- 
                                          Gilles


