Message-ID: <8d88452b-a6cc-e1d0-1091-d37690e4fe5b@siemens.com>
Date: Tue, 1 Mar 2022 08:39:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] Kernel-shark: Add xenomai_cobalt_switch_events plugin
 for kernel-shark
Content-Language: en-US
References: <20220228054055.16112-1-hongzhan.chen@intel.com>
 <20220228054055.16112-3-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220228054055.16112-3-hongzhan.chen@intel.com>
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

On 28.02.22 06:40, Hongzhan Chen wrote:
> For Xenomai-cobalt enabled system, cobalt_switch_context means
> that there is schedule and context switch in companion core(realtime
> core), which we may need to do special treatment and take correct
> action as main kernel sched_switch to visualize out-of-band state
> of realtime tasks running in cobalt core. To achive our target,
> we implement following:
> 
>   1. store corresponding cobalt_switch_context events into
>      container data.
>   2. modify pid stored in entry to be equal to next_pid to
>      show correct color in cpu bar when cobalt_switch_context
>      event happen.
>   3. show blue hollow box to mark out-of-band state according to
>      cobalt_switch_context events.
>   4. clickable cobalt_switch_context plugin shapes.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  kernel-shark/Makefile.am                      |   6 +
>  .../kernelshark/CobaltSwitchEvents.cpp        | 156 ++++++++++++++++
>  kernel-shark/kernelshark/Makefile.am          |  18 ++
>  kernel-shark/kernelshark/README               |  75 ++++++++
>  .../xenomai_cobalt_switch_events.c            | 174 ++++++++++++++++++
>  .../xenomai_cobalt_switch_events.h            |  58 ++++++
>  6 files changed, 487 insertions(+)
>  create mode 100644 kernel-shark/Makefile.am
>  create mode 100644 kernel-shark/kernelshark/CobaltSwitchEvents.cpp
>  create mode 100644 kernel-shark/kernelshark/Makefile.am
>  create mode 100644 kernel-shark/kernelshark/README
>  create mode 100644 kernel-shark/kernelshark/xenomai_cobalt_switch_events.c
>  create mode 100644 kernel-shark/kernelshark/xenomai_cobalt_switch_events.h
> 

...

> diff --git a/kernel-shark/kernelshark/README b/kernel-shark/kernelshark/README
> new file mode 100644
> index 000000000..41a26a39a
> --- /dev/null
> +++ b/kernel-shark/kernelshark/README
> @@ -0,0 +1,75 @@
> +
> +What is it?
> +=============
> +
> +  It is Xenomai plugin for kernel-shark to visualize out-of-band state
> +  of realtime thread running in companion core with making use of
> +  cobalt_switch_context events in trace log.
> +
> +  For more introductions about kernel-shark , please refer to [1].
> +

I think it's "KernelShark". Please check and then use that spelling
consistently if I'm right.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

