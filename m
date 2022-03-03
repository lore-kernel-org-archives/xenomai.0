Message-ID: <bfe9c9a3-b0e0-d9da-1a13-bdc8030cd742@siemens.com>
Date: Thu, 3 Mar 2022 07:38:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] KernelShark: Add xenomai_cobalt_switch_events
 plugin for KernelShark
Content-Language: en-US
References: <20220302025721.9354-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220302025721.9354-1-hongzhan.chen@intel.com>
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

On 02.03.22 03:57, Hongzhan Chen wrote:
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
>  tracing/Makefile.am                           |   6 +
>  tracing/kernelshark/CobaltSwitchEvents.cpp    | 156 ++++++++++++++++
>  tracing/kernelshark/Makefile.am               |  18 ++
>  tracing/kernelshark/README                    |  75 ++++++++
>  .../xenomai_cobalt_switch_events.c            | 174 ++++++++++++++++++
>  .../xenomai_cobalt_switch_events.h            |  58 ++++++
>  6 files changed, 487 insertions(+)
>  create mode 100644 tracing/Makefile.am
>  create mode 100644 tracing/kernelshark/CobaltSwitchEvents.cpp
>  create mode 100644 tracing/kernelshark/Makefile.am
>  create mode 100644 tracing/kernelshark/README
>  create mode 100644 tracing/kernelshark/xenomai_cobalt_switch_events.c
>  create mode 100644 tracing/kernelshark/xenomai_cobalt_switch_events.h
> 

...

> diff --git a/tracing/kernelshark/Makefile.am b/tracing/kernelshark/Makefile.am
> new file mode 100644
> index 000000000..17c4ff217
> --- /dev/null
> +++ b/tracing/kernelshark/Makefile.am
> @@ -0,0 +1,18 @@
> +
> +lib_LTLIBRARIES = libplugin_xenomai_cobalt_switch_events.la
> +
> +KS_INCLUDS         ?= /usr/local/include/kernelshark
> +TRACECMD_INCLUDS   ?= /usr/local/include/trace-cmd
> +TRACEFS_INCLUDS    ?= /usr/local/include/tracefs
> +TRACEEVENR_INCLUDS ?= /usr/local/include/traceevent

configure.ac needs to gain a way to make this configurable (kernelshark
and libtraceevent folders). And then you can also drop these defaults.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

