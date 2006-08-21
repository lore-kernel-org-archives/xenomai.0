Subject: Re: [Xenomai-help] Oops on PPC405EP
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17641.49824.304831.889667@domain.hid>
References: <44E9B5A1.3010102@domain.hid> <44E9BA20.4000607@domain.hid>
	<17641.49824.304831.889667@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 16:38:28 +0200
Message-Id: <1156171108.3155.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 16:26 +0200, Gilles Chanteperdrix wrote:
> Heikki Lindholm wrote:
>  > Since your hardware AFAIK does not have an FPU, shouldn't you be 
>  > compiling Xenomai without hardware FPU support?
> 
> Maybe we could prevent this mistake in Kconfig ?

Yes, at least for 2.6. Applied, thanks.

> 
> plain text document attachment (xeno-hw-fpu-depends-on-ppc-fpu.patch)
> Index: ksrc/arch/powerpc/Kconfig
> ===================================================================
> --- ksrc/arch/powerpc/Kconfig	(revision 1484)
> +++ ksrc/arch/powerpc/Kconfig	(working copy)
> @@ -6,6 +6,7 @@
>  
>  config XENO_HW_FPU
>  	bool "Enable FPU support"
> +	depends on PPC_FPU
>  	default y
>  	help
>  	The FPU executes instructions from the processor's normal
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



