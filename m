Message-ID: <4A89DFD3.4080600@domain.hid>
Date: Tue, 18 Aug 2009 00:55:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907280509u685a18di730cc0b021ab06eb@domain.hid>		<4A6EECF1.9000103@domain.hid>	<b88603c30908170537u72f789c0y75564389c9bd6c8e@domain.hid>
	<4A895169.1030905@domain.hid>
In-Reply-To: <4A895169.1030905@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Pagefaults during mlocked Realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Henri Roosen wrote:
>> We have not much progress tracing the problem so far. But in parallel
>> to the tracing we also updated a kernel to the latest xenomai git
>> status of the 2.4.8 branch, just to see whether we are not facing
>> problems that are solved already.
>>
>> This version however crashes and dumps its call-stack directly when
>> starting the latency test application. Interesting is that it crashes
>> at a check that is added recently in xnshadow_harden:
>> XENO_BUGON(NUCLEUS, !irqs_disable_hw());
>>
>> Please find attached the .config
> 
> Ok. I will propose a better fix later, but could you check the following
> quick fix?
> 
> 
> diff --git a/ksrc/arch/arm/Kconfig b/ksrc/arch/arm/Kconfig
> index c79fe66..b62a14d 100644
> --- a/ksrc/arch/arm/Kconfig
> +++ b/ksrc/arch/arm/Kconfig
> @@ -10,7 +10,7 @@ depends on XENO_OPT_NUCLEUS
> 
>  config IPIPE_WANT_PREEMPTIBLE_SWITCH
>         bool
> -       default y
> +       default n
> 
>  config XENO_HW_FPU
>         bool "Enable FPU support"
> 

Ok. The bug should now be fixed in the repository. But it requires a new
I-pipe patch which should be available tomorrow.

-- 
					    Gilles.

