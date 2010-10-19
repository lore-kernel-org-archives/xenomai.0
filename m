From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=-y4huBX54ahfs6B025Ttk4N4vFZtM3n6DQL24@domain.hid>
References: <30575170.2609951287430146052.JavaMail.defaultUser@domain.hid>
	<4CBCC40D.8040902@domain.hid>
	<AANLkTi=-y4huBX54ahfs6B025Ttk4N4vFZtM3n6DQL24@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Oct 2010 09:00:38 +0200
Message-ID: <1287471638.1564.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] R: Re: Error building xenomai 2.5.5.1 on kubuntu
 10.10 64 bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, "gprizzi@domain.hid" <gprizzi@domain.hid>

On Tue, 2010-10-19 at 00:55 +0200, Cyril Wallois wrote:
> Hi all,
> 
> I'm trying to compile linux 2.6.35.7 on an x86 non 64 with Xenomai,
> and it return the advice to disable CONFIG_CC_STACKPROTECTOR (with an
> error). I'm now compiling with CONFIG_CC_STACKPROTECTOR disable.
> 
> Is it the same "problem" (apparently not)?

Different issue. Xenomai does not support stack protection on x86_32.

> 
> 
> Regards,
> 
> Cyril
> 
> 2010/10/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>         gprizzi@domain.hid wrote:
>         >
>         > Here below you can find my .config file.
>         >
>         > What have I missed?
>         >
>         > Thank you for your support.
>         
>         The problem is that we do not enable CONFIG_CC_STACKPROTECTOR
>         in our
>         x86_84 build test and that we got caught. Could you try the
>         following patch?
>         
>         diff --git a/include/asm-x86/wrappers_64.h
>         b/include/asm-x86/wrappers_64.h
>         index a61f6ba..0d04b9c 100644
>         --- a/include/asm-x86/wrappers_64.h
>         +++ b/include/asm-x86/wrappers_64.h
>         @@ -78,4 +78,8 @@ typedef union thread_xstate x86_fpustate;
>          #define x86_fpustate_ptr(t) ((t)->fpu.state)
>          #endif
>         
>         +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)
>         +#define per_cpu_var(var) (var)
>         +#endif /* Linux >= 2.6.34 */
>         +
>          #endif /* _XENO_ASM_X86_WRAPPERS_64_H */
>         
>         Also note that the configuration you posted is not suitable
>         for running
>         Linux with Xenomai, please have a look at this page:
>         http://www.xenomai.org/index.php/Configuring_x86_kernels
>         
>         
>         --
>         
>          Gilles.
>         
>         
>         _______________________________________________
>         Xenomai-help mailing list
>         Xenomai-help@domain.hid
>         https://mail.gna.org/listinfo/xenomai-help
>         
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



