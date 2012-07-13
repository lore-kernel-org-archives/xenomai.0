Message-ID: <4FFFCEF6.3010300@xenomai.org>
Date: Fri, 13 Jul 2012 09:32:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B8BB1834-3B77-49F2-8F40-C4801E858698@kabelmail.de>	<4FFF33F9.9020000@xenomai.org>
	<4FFF37FF.9080406@xenomai.org>
	<8A91EB22-F549-4065-A21E-043AA6DD9BC1@kabelmail.de>
In-Reply-To: <8A91EB22-F549-4065-A21E-043AA6DD9BC1@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 on beaglebone (TI AM3359 SoC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

On 07/13/2012 09:09 AM, Stephan Kappertz wrote:
> Hi Gilles,
> 
> the problem was not the .config file but the fact that CONFIG_OMAP_32K_TIMER was ignored for the AM3359 implementation.
> 
> So in arch/arm/mach_omap2/timer.c I changed 
> 
> --------------------------------------------
> #ifdef CONFIG_ARCH_OMAP3
> #ifndef CONFIG_IPIPE
> OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
> #else
> OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
> #endif
> OMAP_SYS_TIMER(3)
> OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
> 			2, OMAP3_MPU_SOURCE)
> OMAP_SYS_TIMER(3_secure)
> OMAP_SYS_TIMER_INIT(3_am33xx, 2, OMAP4_MPU_SOURCE, 1, AM33XX_RTC32K_SOURCE) <--- ignoring CONFIG_OMAP_32K_TIMER here
> OMAP_SYS_TIMER(3_am33xx)
> 
> #endif
> --------------------------------------------
> 
> to
> 
> --------------------------------------------
> #ifdef CONFIG_ARCH_OMAP3
> 
> #ifndef CONFIG_SOC_OMAPAM33XX
> 
> #ifndef CONFIG_IPIPE
> OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
> #else
> OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
> #endif
> OMAP_SYS_TIMER(3)
> OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
> 			2, OMAP3_MPU_SOURCE)
> OMAP_SYS_TIMER(3_secure)
> 
> #else // #ifdef CONFIG_SOC_OMAPAM33XX
> 
> #ifndef CONFIG_IPIPE
> OMAP_SYS_TIMER_INIT(3_am33xx, 2, AM33XX_CLKEV_SOURCE, 1, AM33XX_MPU_SOURCE)
> #else
> OMAP_SYS_TIMER_INIT(3_am33xx, 2, AM33XX_CLKEV_SOURCE, 3, AM33XX_MPU_SOURCE)
> #endif
> OMAP_SYS_TIMER(3_am33xx)
> 
> #endif
> 
> #endif
> --------------------------------------------
> 
> With the AM33XX_CLKEV_SOURCE and AM33XX_MPU_SOURCE defined as 
> 
> --------------------------------------------
> #define OMAP4_MPU_SOURCE	"sys_clkin_ck"
> #define AM33XX_MPU_SOURCE	OMAP4_MPU_SOURCE
> #define AM33XX_RTC32K_SOURCE	"clk_32768_ck"
> 
> #ifdef CONFIG_OMAP_32K_TIMER
> #define AM33XX_CLKEV_SOURCE	AM33XX_RTC32K_SOURCE
> #define OMAP3_SECURE_TIMER	12
> #else
> #define AM33XX_CLKEV_SOURCE	OMAP4_MPU_SOURCE
> #define OMAP3_SECURE_TIMER	1
> #endif
> --------------------------------------------
> 
> That fixes the clock rate but otherwise does not change the fact that I'm stuck in a non ack'd interrupt at boot: 

The problem comes from the flow handler change. The simplest fix is to
use the default flow handler. Is there any place I can download the
patch to have a look at it?

-- 
                                                                Gilles.

