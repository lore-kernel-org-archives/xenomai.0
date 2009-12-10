From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <500245.60842.qm@domain.hid>
References: <500245.60842.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Dec 2009 19:11:22 +0100
Message-ID: <1260468682.2370.100.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Porting Adeos-Ipipe on AVR32 (NGW 100).
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: A C <adrien_chiron@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2009-12-10 at 16:48 +0000, A C wrote:
> Hello,
> 
> We started to port Adeos for the IRQs part. 
> 
> Simple question: Why the function raw_irqs_disabled_flags(flags) is
> the same with or without ipipe ? (as we saw in some arch).
> 

Because the pipeline code must guarantee that, for all standard linux
IRQ state accessors/modifiers (e.g. local_irq_save/restore(),
raw_irqs_disabled_flags()) the same values are used to assert/test the
interrupt on/off states (e.g. MSR_EE, X86_EFLAGS_IF and so on), in the
virtualized IRQ flags, than the real IRQ flags linux uses when the
pipeline is disabled, for any given arch.

e.g. on x86, albeit ugly, it must be allowed to open-code:

raw_local_save_flags(flags);
if (flags & X86_EFLAGS_IF)
	interrupts_are_enabled();

even if the pipeline is enabled.

> (in the case with ipipe) 
> Why not use __ipipe_test_root() -in the same way as the function
> __raw_local_save_flags()- to write the new function
> raw_irqs_disabled_flags(flags)?

Because this would break the above rule, since __ipipe_test_root()
returns 0/1.

> 
> Regards
> 
> Adrien Chiron & Vincent Vanbesien
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



