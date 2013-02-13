Message-ID: <511BD801.7060304@gmail.com>
Date: Wed, 13 Feb 2013 19:14:25 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com> <5117AD5A.1080504@xenomai.org>
	<OF7193B3EB.20F44A56-ON85257B11.006195D9-85257B11.0062A0F5@aanddtech.com>
In-Reply-To: <OF7193B3EB.20F44A56-ON85257B11.006195D9-85257B11.0062A0F5@aanddtech.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: Xenomai@xenomai.org

Hi Matthew,

On 13.02.2013 18:57, mfornero@aanddtech.com wrote:
> It seems that the issues I was having with using the twd as a clockevent
> were related to my defconfig.
> Comparing mine with Stefan's revealed a few key differences, some of
> which were likely fatal. After making the following changes,
> I am able to run using the twd for the clockevent instead of the xttcps:
> 
> CONFIG_NO_HZ=n
> CONFIG_HOTPLUG_CPU=n
> CONFIG_CPU_FREQ=n
> CONFIG_MPCORE_WATCHDOG=n
> 
> CPU_FREQ should definitely not have been set, and HOTPLUG_CPU is not
> really useful. Not sure if the other two would have had an impact.
> 
> My changes, which include reducing the rating of the xttcps clockevent
> to below twd, adding support for xttcps as the tsc in non-SMP mode
> (based on Stefan's code),
> Gilles's printk patch (above), and an updated defconfig with sane values
> can be found on github:
> 
> https://github.com/mfornero/ipipe
> 
> I'm building against the xilinx_zynq_adt_defconfig file included in the
> tree. Note that I'm using an older version of uboot, so I need to use
> the fixed device tree address which is why it's set like this in the
> defconfig.

Thanks for this update. This solves the twd issue (boot hangup) which
seems to be related to a defconfig misconfiguration.

BTW: Did you also add the Xilinx GPIO driver changes to your git
repository I made to support GPIO interrupts? If not I'll send the
patches again to the list tomorrow.

Thanks,
Stefan




