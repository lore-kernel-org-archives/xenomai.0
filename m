Message-ID: <6b3ed8bf-9c55-83ee-b604-2b709d05475a@siemens.com>
Date: Fri, 17 Jun 2022 08:09:57 +0200
MIME-Version: 1.0
Subject: Re: [I-PIPE PATCH v2] x86/tsc: I-PIPE : notify I-PIPE about updated
 clockfreq
Content-Language: en-US
References: <20220616001850.9276-1-hongzhan.chen@intel.com>
 <20220616001850.9276-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220616001850.9276-2-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 16.06.22 02:18, Hongzhan Chen via Xenomai wrote:
> When there is refined tsc clock, notify Xenomai to apply it.
> Linux may schedule a delayed work to refine tsc clock and update
> tsc_khz which happen after Xenomai finsih init but tsc_scale and
> tsc_shift still keep the value depending on origianl tsc clock
> which is outdated. The difference between two clocks may cause
> unexpected timing drift.
> 
> For example:
>   [ 0.001731] tsc: Detected 2899.886 MHz TSC
>   [ 5.588387] tsc: Refined TSC clocksource calibration: 2903.999 MHz
>   cat /sys/module/xenomai/parameters/clockfreq
>   2899886000
>   After patching, we like to use 2903.999 MHz.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  arch/x86/kernel/tsc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 835856efd71f..37faaf9a9e6c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1294,6 +1294,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	u64 tsc_stop, ref_stop, delta;
>  	unsigned long freq;
>  	int cpu;
> +	unsigned int ipipe_freq;
>  
>  	/* Don't bother refining TSC on unstable systems */
>  	if (tsc_unstable)
> @@ -1345,6 +1346,9 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	/* Inform the TSC deadline clockevent devices about the recalibration */
>  	lapic_update_tsc_freq();
>  
> +	ipipe_freq = tsc_khz * 1000;

You are still using a separate variable.

> +	 __ipipe_report_clockfreq_update(ipipe_freq);
> +
>  	/* Update the sched_clock() rate to match the clocksource one */
>  	for_each_possible_cpu(cpu)
>  		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

