Message-ID: <4DCA8290.6060105@domain.hid>
Date: Wed, 11 May 2011 18:35:28 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid>
	<4DC299F2.40700@domain.hid>	<4DC2A315.8030707@domain.hid>
	<4DC2ADE1.9000301@domain.hid>	<4DC2B06B.9020303@domain.hid>
	<4DC2B75C.8030503@domain.hid>	<4DC2C10C.9080102@domain.hid>
	<4DC2C411.60109@domain.hid>	<4DC2D0C9.3020605@domain.hid>
	<4DC2DDC6.8090909@domain.hid>	<4DC3BF3C.2030405@domain.hid>
	<4DC3C076.7010203@domain.hid>	<4DCA6525.6010401@domain.hid>
	<4DCA69F0.9040104@domain.hid> <4DCA800A.80108@domain.hid>
In-Reply-To: <4DCA800A.80108@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] mini2440: ipipe kernel stuck in idle loop after
 xenomai init
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 05/11/2011 06:24 PM, Gilles Chanteperdrix wrote:
> Try this:
> diff --git a/ksrc/arch/arm/hal.c b/ksrc/arch/arm/hal.c
> index 2ca0d6c..534f97f 100644
> --- a/ksrc/arch/arm/hal.c
> +++ b/ksrc/arch/arm/hal.c
> @@ -322,7 +322,7 @@ int rthal_timer_request(void (*handler)(void), int cpu)
>  
>  	rthal_timer_set_oneshot(1);
>  
> -	return 0;
> +	return 1000000000UL / HZ;
>  }
Seems to be fixed, thanks!

I just compared generic and non-generic rthal_timer_request and already
tried "return 1" but did not realized that "1G/Hz" is correct return value.

--
Alex

