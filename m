Message-ID: <fa39e3219e7ff641ec8196cc3ab135fd.squirrel@sourcetrek.com>
In-Reply-To: <55E7E7ED.5060405@sigmatek.at>
References: <55E7E7ED.5060405@sigmatek.at>
Date: Thu, 3 Sep 2015 08:54:19 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Activating PCI express on imx6 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wolfgang.netbal@sigmatek.at
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Wolfgang Netbal wrote:
> Hi,
>
> I activated PCI express for my imx6 board.
> To get PCI express up and running I have to activate the kernel option
> CONFIG_CPU_FREQ
> here my configuration
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_STAT_DETAILS is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_GOV_INTERACTIVE is not set
> # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
> # CONFIG_GENERIC_CPUFREQ_CPU0 is not set
>
> I think the frequency scaling can change the timing for xenomai and
> checked the .config file
> where I found the following message.
>
>
> #
> # WARNING! You enabled APM, CPU Frequency scaling, ACPI 'processor'
> #
>
> #
> # or Intel cpuidle option. These options are known to cause troubles
> #
>
> #
> # with Xenomai, disable them.
> #
>
>
> Do you have any idea how to activate PCI express support when using
> xenomai.

With the performance governor there is no risk of frequency changes
breaking xenomai timings after initialization. So, run the latency test,
and if it runs correctly (no drift, no large latencies), you can ignore
these messages. Otherwise, the problem is that the cpu frequency which was
used as boot is not the same as the one used by the performance governor,
and in that case, the best I can advise is to use the userspace governor
and manually set the frequency to the boot value.


-- 
                                            Gilles.
https://click-hack.org


