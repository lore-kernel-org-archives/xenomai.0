Message-ID: <b68fbbd4-011c-f4d9-57ab-5c7934b7dcc3@siemens.com>
Date: Tue, 25 Jan 2022 17:36:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] kernel-shark: Add plugin for handling Xenomai
 cobalt_context_switch
Content-Language: en-US
References: <20220118034514.25281-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220118034514.25281-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 18.01.22 04:45, Hongzhan Chen wrote:
> For Xenomai-cobalt enabled system, cobalt_switch_context means
> that there is schedule and context switch in companion core(realtime
> core), which we may need to do special treatment and take correct
> action as main kernel sched_switch to visualize out-of-band state
> of realtime tasks running in cobalt core. To achive our target,
> we implement following:
> 
>    1. store corresponding cobalt_switch_context events into
>       container data.
>    2. modify pid stored in entry to be equal to next_pid to
>       show correct color in cpu bar when cobalt_switch_context
>       event happen.
>    3. show cobalt blue hollow box to mark out-of-band state according
>       to cobalt_switch_context events.
>    4. clickable cobalt_switch_context plugin shapes.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/src/plugins/CMakeLists.txt b/src/plugins/CMakeLists.txt
> index 3e170fa..16f080b 100644
> --- a/src/plugins/CMakeLists.txt
> +++ b/src/plugins/CMakeLists.txt

This is targeting the kernel-shark repo, right? But isn't the plan 
rather to have this as an out-of-tree (/wrt kernel-shark) plugin, hosted 
inside the Xenomai repo? Then we need a different structure and a hook 
into the Xenomai build system - or at least a README how to build that 
manually.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

