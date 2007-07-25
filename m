MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18087.53592.695989.892368@domain.hid>
Date: Thu, 26 Jul 2007 00:40:24 +0200
In-Reply-To: <E1IBASV-0003zW-Kv@domain.hid>
References: <E1IBASV-0003zW-Kv@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] [PATCH] [arm] Fixes
	for	adeos-ipipe-2.6.20-arm-1.7-03.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Sebastian Smolorz wrote:
 > Hi Gilles,
 > 
 > (...)
 >
 >     Negate condition in macros local_irq_save_hw(x) and 
 > local_irq_restore_hw(x)
 > (...)
 >  #define local_irq_save_hw(x) do { \
 >  	local_save_flags_hw(x); \
 > -	if (raw_irqs_disabled_flags(x)) { \
 > +	if (!raw_irqs_disabled_flags(x)) { \
 >  		local_irq_disable_hw_notrace(); \
 >  		ipipe_trace_begin(0x80000001); \
 >  	} \
 >  } while (0)
 >  #define local_irq_restore_hw(x) do { \
 > -	if (raw_irqs_disabled_flags(x)) \
 > +	if (!raw_irqs_disabled_flags(x)) \
 >  		ipipe_trace_end(0x80000001); \
 >  	local_irq_restore_hw_notrace(x); \
 >  } while (0)
 > @@ -209,8 +207,6 @@ void __ipipe_restore_root(unsigned long flags);
 >  #define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
 >  #define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
 >  
 > -#define irqs_disabled()		irqs_disabled_hw()
 > -
 >  #endif /* CONFIG_IPIPE */

Ah, this one was a nasty bug. It explains the odd behaviour of my I-pipe
patched kernel on AT91 when enabling the tracer. Thanks a lot.

-- 


					    Gilles Chanteperdrix.

