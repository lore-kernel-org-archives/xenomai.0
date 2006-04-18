Message-ID: <4444DEC7.8040806@domain.hid>
Date: Tue, 18 Apr 2006 14:42:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] clean up latest ipipe-tracing changes
References: <4443BF6E.907@domain.hid>
In-Reply-To: <4443BF6E.907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> here is a suggestion to do a tiny cleanup of Gilles' cpuid-fix for the
> tracer. Sorry that I didn't comment on this earlier. Nothing critical
> though.
> 
> I think it's better to drag the include/linux/compiler.h changes into
> the main patch instead of starting to use
> __attribute__((no_instrument_function)) all over the place just to avoid
> notrace (especially as I expect that Ingo's tracer will get merged
> anyway in the future). Moreover, local_irq_restore_hw_notrace & frieds
> are available even for !CONFIG_IPIPE_TRACE, so no need to differentiate
> here. Finally, I do not see a need for marking a static inline function
> non-traced.
> 
> The patch does not seem to produce different binary code (I checked
> kernel/ipipe/tracer.o) - as expected.
> 

Applied, leaving the ipipe_processor_id() unchanged though. Thanks.

-- 

Philippe.

