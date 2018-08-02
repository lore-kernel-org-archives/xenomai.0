References: <CADXNiGUNiEC9MaOWTc3UBCNaBMRp2SHbbJ4dsq379QpToBvGcw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f8c0c8df-59ae-996f-2ed3-3c3c5ccb6331@xenomai.org>
Date: Thu, 2 Aug 2018 17:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGUNiEC9MaOWTc3UBCNaBMRp2SHbbJ4dsq379QpToBvGcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] System Lockup while idle
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, xenomai@xenomai.org

On 07/30/2018 09:05 PM, Jackson Jones wrote:
> We have an app running Xenomai 3.0.7 on an i.MX6 quad-core processor.  We
> are using processor affinity to have different tasks bound to different
> cores.
> 
> When the app runs on the target and is idle it will freeze the entire
> system after about 8 hours. If we enable these options it no longer locks
> up and runs for days.
> 
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> 

Only guessing at this stage, but maybe the system timer stops ticking on
some CPU and never wakes up for some reason. Enabling the features above
would keep a periodic timer activity running, papering over the issue by
preventing the trigger condition to occur.

Cobalt on i.MX6q is timed by the per-CPU smp_twd timer, which may suffer
the C3STOP mis-feature (some NXP's i.MX6qp SDB do for sure). When CPU
idling is enabled, smp_twd timers may be shut down by the kernel for
entering an idle state, replaced by the global mxc timer acting as a
broadcast device. If/when that happens, Cobalt is not going to be happy,
as it is not smart enough to handle a change of tick device (or device
frequency for that matter).

You could first check whether your device mentions "always-on" as a TWD
property in the DTS. If not, then C3STOP is assumed. It may be worth
testing if disabling the CPU idle feature (NO_HZ_IDLE typically) in the
kernel configuration helps.

> If we run without using processor affinity (all RT tasks will be on the
> same core),  the system will not lock up either.
> 

As Greg mentioned earlier, not setting any affinity via
xenomai.supported_cpus actually means including all available cores in
the rt set by default. So your working case seems to be when all CPUs
are available for rt duty.

> 
> We are passing in xenomai.supported_cpus=0x0000000f on the command line. I
> noticed the irq-affinity test program assumes at least one non-real time
> cpu. Could having all 4 cores in the RT set be causing the lockups? Should
> we leave one core out of the RT group?
> 

No, this is not required.

-- 
Philippe.

