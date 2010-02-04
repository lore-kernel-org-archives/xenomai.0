From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
References: <004b01caa59f$f82b2280$e8816780$@kalatchev@domain.hid>
	<4B6AD557.3060904@domain.hid> <4B6AD743.2090002@domain.hid>
In-Reply-To: <4B6AD743.2090002@domain.hid>
Date: Thu, 4 Feb 2010 09:49:46 -0500
Message-ID: <005601caa5a9$4c3861e0$e4a925a0$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-ca
Subject: Re: [Xenomai-help] Problem compiling 2.5.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Thanks Gilles,

This modification worked. I have xenomai compiled fine now

Regards,

Ivan

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: February-04-10 9:19 AM
> To: Ivan Kalatchev
> Cc: Xenomai-help@domain.hid
> Subject: Re: [Xenomai-help] Problem compiling 2.5.1
> 
> Gilles Chanteperdrix wrote:
> > Ivan Kalatchev wrote:
> >> I have compiler error when compiling xenomai-2.5.1. Again probably
> because
> >> my tool chain is outdated - gcc 3.4.4.
> >> (...)
> >> {standard input}:102: Error: bad instruction `lsrs sl,r7,#30'
> >> (...)
> >>
> >> Is there way to modify assembler code so that code would compile ?
> >
> > Ok. lsrs looks like a valid instruction, but s1 looks strange as a
> 
> It is "sl", not "s1", and sl is a valid name for r10. The problem is
> indeed lsrs, it is in fact a synonym for the equivalent mov with
> shifted
> second operand in older assembly sources. So, please try the following
> patch:
> 
> diff --git a/include/asm-arm/arith.h b/include/asm-arm/arith.h
> index 9af5c5c..e86975c 100644
> --- a/include/asm-arm/arith.h
> +++ b/include/asm-arm/arith.h
> @@ -32,6 +32,7 @@ rthal_arm_nodiv_llimd(const long long op,
> 
>  #include <asm-generic/xenomai/arith.h>
> 
> +#if __LINUX_ARM_ARCH__ >= 4
>  #define rthal_arm_nodiv_ullimd_str			\
>  	"umull %[tl], %[rl], %[opl], %[fracl]\n\t"	\
>  	"umull %[rm], %[rh], %[oph], %[frach]\n\t"	\
> @@ -49,8 +50,6 @@ rthal_arm_nodiv_llimd(const long long op,
>  	"umlal %[rm], %[rh], %[opl], %[integ]\n\t"	\
>  	"mla %[rh], %[oph], %[integ], %[rh]\n\t"
> 
> -
> -#if __LINUX_ARM_ARCH__ >= 4
>  static inline __attribute__((__const__)) unsigned long long
>  rthal_arm_nodiv_ullimd(const unsigned long long op,
>  		       const unsigned long long frac,
> @@ -101,7 +100,7 @@ rthal_arm_nodiv_llimd(const long long op,
>  	__rthal_u64tou32(op, oph, opl);
>  	__rthal_u64tou32(frac, frach, fracl);
> 
> -	__asm__ ("lsrs %[s], %[oph], #30\n\t"
> +	__asm__ ("movs %[s], %[oph], lsr #30\n\t"
>  		 "beq 1f\n\t"
>  		 "rsbs  %[opl], %[opl], #0\n\t"
>  		 "rsc  %[oph], %[oph], #0\n"
> 
> 
> --
> 					    Gilles.



