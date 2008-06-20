Message-ID: <485B8332.90908@domain.hid>
Date: Fri, 20 Jun 2008 12:15:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5719c6f30805050943p31f3f5eew74d0f7ef3dd2b5a5@domain.hid>	<4820B784.3080306@domain.hid>
	<5719c6f30806190900v5fea670amef6954efaae59882@domain.hid>
In-Reply-To: <5719c6f30806190900v5fea670amef6954efaae59882@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Advice regarding MIPS port
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Florent Audebert <f.audebert@domain.hid>
Cc: adeos-main@gna.org

Florent Audebert wrote:
> Hi,
> 
> I'm back on my work concerning Adeos port on MIPS. I'm a little bit lost atm.
> 
> My kernel is stuck in calibrate_delay() loop. Timer interrupts seem to
> occur well but my i-pipe is stalled. There is no arch-dependent places
> where I explicitely unstall root domain.

The root domain should be unstalled in the start_kernel function, file
init/main.c by the call to local_irq_enable(), which should result in an
ipipe_unstall_root().


> I saw fast stall / unstall
> calls in other archs entry.S. Are these calls mandatory or are they
> here in order to reduce latency ?

They are mandatory in a final I-pipe patch, but you can ignore them for
a first attempt, without them, you will get big latencies, that is all.

> 
> In case the previous asumption is false, is there any other potential
> leads ? (Something wrong in my local_irq_* ?)

Well, when debugging, every ugly hack is permitted, so you can put as
much printks as you want in the interrupt handler or the calibrate delay
loop.

> 
> I didn't post my code so far since nothing is working yet... If you
> think it could worth it, I'll be glad to send you a git-diff from my
> 2.6.24 working directory.
> 


-- 
                                                 Gilles Chanteperdrix

