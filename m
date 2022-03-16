Message-ID: <019a857d-1af7-d18b-7ce1-e6e24915af6c@siemens.com>
Date: Wed, 16 Mar 2022 09:10:49 +0100
MIME-Version: 1.0
Subject: Re: CONFIG_NO_HZ_FULL = y but still have arch-timer on isolation CPUs
Content-Language: en-US
References: <16D8A720-E151-430B-AA1E-573A0F850121@aliyun.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <16D8A720-E151-430B-AA1E-573A0F850121@aliyun.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ivan Jiang <jcgeforce@aliyun.com>, xenomai@xenomai.org

On 15.03.22 05:01, Ivan Jiang via Xenomai wrote:
> Dear Guys:
> 
>  
> 
>        I’ve set the configs like this
> 
>        CONFIG_NO_HZ_FULL = y
> 
> CONFIG_RCU_NOCB_CPU=y
> 
> CONFIG_PREEMPT=y
> 
> CONFIG_CPU_IDLE=n
> 
> CONFIG_ARM_CPUIDLE=n
> 
> CONFIG_CPU_FREQ=n 
> 
> And setenv isolcpus=1 xenomai.supported_cpus=0x02 nohz_full=1  irqaffinity=0   rcu_nocbs=1
> 
> The CPU is Cortex-A55 Dual core and I use CPU 0 as Linux CPU and CPU1 for isolation core.
> 
> But cat /proc/interrupts still the arch_timers are increasing the same time on both CPUs.
> 
> Seems NO_HZ_FULL = y has no effect.
> 

The boundary conditions for nohz-full are challenging, already for
"normal" Linux apps. So far, Xenomai does not take any steps to support
this, and so it would be no surprise if the condition for turning off
the scheduler and, thus, also the timer tick are not met.

But as you already found out: Even plain Linux does not succeed in your
case. Maybe explore this first with a more recent vanilla kernel, a
single syscall-free CPU-bound task and official documentation on
nohz-full. After that starts to work, it could indeed become a Xenomai
topic (though likely no longer for I-pipe, ie. anything before 5.10).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

