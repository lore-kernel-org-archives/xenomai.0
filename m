In-Reply-To: <5117AD5A.1080504@xenomai.org>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com> <5117AD5A.1080504@xenomai.org>
MIME-Version: 1.0
Message-ID: <OF7193B3EB.20F44A56-ON85257B11.006195D9-85257B11.0062A0F5@aanddtech.com>
From: mfornero@aanddtech.com
Date: Wed, 13 Feb 2013 12:57:17 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
02/10/2013 09:23:22 AM:
> Hi Stefan, Matthew,
> 
> I do not know if you managed to get the I-pipe working on Zynq. 
> You may have missed it, but it may be very important for debugging the 
> issues you encounter with the I-pipe port on Zynq, printk from primary 
> domain in I-pipe patches for Linux 3.4 and 3.5 does not work. So, if 
> you are debugging with printk, it may lead you to false conclusions. 
> You should apply the following patch (it has been pushed in the 
> for-core-3.5.7 branch of the ipipe-gch git):
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 3b86167..f77ef11 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -440,7 +440,7 @@ void __ipipe_ipis_alloc(void)
>        return;
> 
>     /* __ipipe_first_ipi is 0 here  */
> -   ipi_nr = IPI_IPIPE_FIRST + IPIPE_LAST_IPI;
> +   ipi_nr = IPI_IPIPE_FIRST + IPIPE_LAST_IPI + 1;
> 
>     for (virq = IPIPE_IPI_BASE; virq < IPIPE_IPI_BASE + ipi_nr; virq++) 
{
>        _virq = ipipe_alloc_virq();
> 

Hi All,

It seems that the issues I was having with using the twd as a clockevent 
were related to my defconfig.
Comparing mine with Stefan's revealed a few key differences, some of which 
were likely fatal. After making the following changes,
I am able to run using the twd for the clockevent instead of the xttcps:

CONFIG_NO_HZ=n
CONFIG_HOTPLUG_CPU=n
CONFIG_CPU_FREQ=n
CONFIG_MPCORE_WATCHDOG=n

CPU_FREQ should definitely not have been set, and HOTPLUG_CPU is not 
really useful. Not sure if the other two would have had an impact.

My changes, which include reducing the rating of the xttcps clockevent to 
below twd, adding support for xttcps as the tsc in non-SMP mode (based on 
Stefan's code),
Gilles's printk patch (above), and an updated defconfig with sane values 
can be found on github:

https://github.com/mfornero/ipipe

I'm building against the xilinx_zynq_adt_defconfig file included in the 
tree. Note that I'm using an older version of uboot, so I need to use the 
fixed device tree address which is why it's set like this in the 
defconfig.

