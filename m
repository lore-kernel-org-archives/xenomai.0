Date: Mon, 7 Mar 2016 12:37:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160307113708.GA24055@hermes.click-hack.org>
References: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
 <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
Subject: Re: [Xenomai] Fwd: Latency test fails. Problem during installation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michele Belotti <miki.belotti@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Mar 07, 2016 at 11:33:31AM +0100, Michele Belotti wrote:
> Hello everybody,
> We recently migrated my project on a new and more powerful workstation but
> I can obtain the previous performance.

You mean you can NOT.

> 
> We observed by running the standard Xenomai tools that there are very high
> latencies, hinting for an issue in the kernel configuration (or maybe
> unsupported HW features by Xenomai ?).

How high?

> 
> We are trying to install Xenomai version 2.6.3 on a HP Z840 workstation Red
> Hat system 7.2.
> The Workstation has  a double 12 cores CPU Intel Xeon E5-2690v3 on
> it.

Why installing Xenomai 2.6.3 ? It is not even the latest release in
the 2.6 branch.

> 
> We follow the installation guide and the troubleshooting but the latency is
> still very high with some high jumps.
> We tried to deal with the different options described in the guide
> 
> CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, CONFIG_CONTEXT_TRACKING_FORCE
> XENO_OPT_STATS  NO_HZ_FULL_ALL  BSD_PROCESS_ACCT  but none has impacted the
> system, only marginal improvements.

What about CONFIG_ACPI_CPUFREQ?

> 
> We also tried to modify the  SMI detection parameters adding the following
> string to kernel command line
> xeno_hal.smi = 1
> but without any effect.

I am not sure 2.6.3 already had the kernel parameters, you may have
to configure the kernel to enable the SMI workaround.
In any case, using the module parameter, if this works, should
trigger some messages in the boot logs, as explained in the
troubleshooting guide. If you do not see the messages, you are doing
it wrong.

Regards.

-- 
					    Gilles.
https://click-hack.org

