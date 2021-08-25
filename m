Subject: Re: CPU core reservation and Latency setting via config
References: <VI1PR0402MB355162B4233519B0D3D0D451FEC69@VI1PR0402MB3551.eurprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3ae53eb5-2fe1-0908-1c3a-741c1afc195c@siemens.com>
Date: Wed, 25 Aug 2021 11:38:17 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB355162B4233519B0D3D0D451FEC69@VI1PR0402MB3551.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Neeraj Agrawal <Neeraj.Agrawal@Renishaw.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 25.08.21 10:16, Neeraj Agrawal via Xenomai wrote:
> Hello,
> Seeking advice on two separate issues. One of them may be just the documentation.
> 
> Setup is:
>                 Building via buildroot
>                 [Xenomai] Cobalt v3.0.10 is running over qemu with 2 CPUs.
>                 Linux version 4.14.111.
>                 bootargs: isolcpus=1 processor.max_cstate=0 intel_idle.max_cstate=0 nosoftlockup=0 rcu_nocbs=1 irqaffinity=0 tsc=reliable .....

Architecture?

> 
> Issue 1\ Latency setting:
> Referring to https://xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html
> -enabling CONFIG_XENO_OPT_AUTOTUNE does create entry as '/dev/rtdm/autotune' in target.
> -setting XENO_OPT_TIMING_SCHEDLAT does NOT reflect in '/proc/xenomai/clock/coreclk'

There is apparently a translation issue. While the config help says you
should specify in nanoseconds, the value is actually accepted in clock
cycles (TSC in case of x86).

Philippe, all those hard-coded values in
kernel/cobalt/arch/*/*/include/asm/xenomai/calibration.h are actually in
ticks? Or are they also in ns, and we need to convert them to ticks as well?

> -enabling BR2_PACKAGE_XENOMAI_ANALOGY does build autotune application, but running it on target also does NOT reflect XENO_OPT_TIMING_SCHEDLAT setting in '/proc/xenomai/clock/coreclk'

That is likely a buildroot topic. Please address via that community
first (provided you meant BR2_PACKAGE_XENOMAI_AUTOTUNE, not ANALOGY).

> 
> Is my expectation correct that statically defined gravity values should reflect in coreclk?
> -If so, how could it be achieved?
> -If not, then how to verify if the values are set/used correctly?
> 
> 
> Issue 2\ CPU cores distribution:
> If bootargs have both ("isolcpus=1 maxcpus=1"), ie:
>                 isolcpus=1 maxcpus=1 processor.max_cstate=0 intel_idle.max_cstate=0 nosoftlockup=0 rcu_nocbs=1 irqaffinity=0 tsc=reliable .....
> Then i get a boot time crash. [Could not collect the log, but crash indicate somewhere in i-pipe]

Indeed, maxcpus=1 crashes on x86 with I-pipe. Not with dovetail (5.10),
though. With maxcpus=1, we start with any core > 0 being offline, and
that is likely not supported by I-pipe. Taking cores offline later on is
supposed to work, though.

> Idea behind this is to force Linux to use 1st CPU, there by leaving 2nd CPU dedicated for Xenomai. Either of the entry alone works (but not together).
> [Also tried xenomai.supported_cpus=0x02 without success].

Try only isolcpus and possibly xenomai.supported_cpus (if you like to
reduce the impact of Xenomai on non-RT CPUs).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

