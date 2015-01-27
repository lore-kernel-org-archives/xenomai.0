Date: Tue, 27 Jan 2015 18:47:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150127174752.GB20726@hermes.click-hack.org>
References: <20150126195409.GA1491@hermes.click-hack.org>
 <20150127130925.GA22089@dmia-degroote.isae.fr>
 <20150127132647.GA16502@hermes.click-hack.org>
 <20150127135506.GB22089@dmia-degroote.isae.fr>
 <20150127140003.GB16502@hermes.click-hack.org>
 <20150127145812.GC22089@dmia-degroote.isae.fr>
 <20150127150307.GC16502@hermes.click-hack.org>
 <20150127164934.GD22089@dmia-degroote.isae.fr>
 <20150127171850.GA20726@hermes.click-hack.org>
 <20150127172741.GE22089@dmia-degroote.isae.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150127172741.GE22089@dmia-degroote.isae.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Xenomai on Odroid-U3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnaud Degroote <arnaud.degroote@isae-supaero.fr>
Cc: xenomai@xenomai.org

On Tue, Jan 27, 2015 at 06:27:42PM +0100, Arnaud Degroote wrote:
> See the config in attachment, thanks.
> 

> #
> # CPU Core family selection
> #
> # CONFIG_ARCH_MULTI_V6 is not set
> CONFIG_ARCH_MULTI_V7=y
> CONFIG_ARCH_MULTI_V6_V7=y
> # CONFIG_ARCH_MULTI_CPU_AUTO is not set
> # CONFIG_ARCH_VIRT is not set
> # CONFIG_ARCH_MVEBU is not set
> # CONFIG_ARCH_BCM is not set
> # CONFIG_ARCH_BERLIN is not set
> # CONFIG_ARCH_HIGHBANK is not set
> # CONFIG_ARCH_HISI is not set
> # CONFIG_ARCH_KEYSTONE is not set
> # CONFIG_ARCH_MXC is not set
> # CONFIG_ARCH_MEDIATEK is not set
> 
> #
> # TI OMAP/AM/DM/DRA Family
> #
> # CONFIG_ARCH_OMAP3 is not set
> # CONFIG_ARCH_OMAP4 is not set
> # CONFIG_SOC_OMAP5 is not set
> # CONFIG_SOC_AM33XX is not set
> # CONFIG_SOC_AM43XX is not set
> # CONFIG_SOC_DRA7XX is not set
> # CONFIG_ARCH_QCOM is not set
> # CONFIG_ARCH_ROCKCHIP is not set
> # CONFIG_ARCH_SOCFPGA is not set
> # CONFIG_PLAT_SPEAR is not set
> # CONFIG_ARCH_STI is not set
> # CONFIG_ARCH_S5PV210 is not set
> CONFIG_ARCH_EXYNOS=y
> CONFIG_ARCH_EXYNOS3=y
> CONFIG_ARCH_EXYNOS4=y
> CONFIG_ARCH_EXYNOS5=y

In a first step, please disable CONFIG_ARCH_MULTI_V6_V7 and only
select the exynos for which you build.

> CONFIG_HIGHMEM=y

Please try turning HIGHMEM off.

> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y

This two should be disabled.


> CONFIG_PM_OPP=y
> CONFIG_PM_CLK=y

Changing OPP has chances to be problematic with Xenomai clock
handling.


> CONFIG_FTRACE=y

In a first step, turn that one off (note that the impact of FTRACE
on ARM is really big, so keeping it turned on probably does not make
sense).

I do not see anything in this configuration which could be the cause
of the behaviour you observe. You could try and enable the I-pipe
tracer, and trigger a trace freeze when the bug happens (before
printing anything). You will have to modify tracer.c to increase the
number of back trace points.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150127/91cb9d92/attachment.sig>
