Subject: Re: [RFC PATCH 1/2] kernel-shark: add plugin for handling xenomai
 cobalt context switch event
References: <20211214031537.14914-1-hongzhan.chen@intel.com>
 <20211214031537.14914-2-hongzhan.chen@intel.com>
 <86f411ed-5725-74cd-a5ab-e1f0c3902120@siemens.com>
 <MN2PR11MB42851F06D18E71D4A540AA47F2759@MN2PR11MB4285.namprd11.prod.outlook.com>
 <7fea2c2d-648b-236a-e027-ca89bcc3b384@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a9090b11-5ec4-f443-dc77-8cff66db33c3@siemens.com>
Date: Tue, 14 Dec 2021 08:02:24 +0100
MIME-Version: 1.0
In-Reply-To: <7fea2c2d-648b-236a-e027-ca89bcc3b384@siemens.com>
Content-Type: text/plain; charset="utf-8"
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 14.12.21 07:49, Jan Kiszka via Xenomai wrote:
> On 14.12.21 07:44, Chen, Hongzhan wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>> Sent: Tuesday, December 14, 2021 2:38 PM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>> Subject: Re: [RFC PATCH 1/2] kernel-shark: add plugin for handling xenomai cobalt context switch event
>>>
>>> On 14.12.21 04:15, Hongzhan Chen wrote:
>>>> For Xenomai-cobalt enabled system, cobalt_switch_context means that there
>>>> is context switch in companion core(realtime core), which we may need
>>>> to do special treatment and take correct action as main kernel sched_switch.
>>>> We need to update cpu bar regarding cobalt_switch_context event to correct
>>>> color as switching-in task.
>>>
>>> It's tricker... I have trace with the following sequence here:
>>>
>>>             gdb-898   [000]   753.944137: cobalt_switch_context: prev_name=ROOT/0 prev_pid=0 prev_prio=-1 prev_state=0x218008 ==> next_name=pthelper next_pid=912 next_prio=3
>>>             gdb-898   [000]   753.944142: cobalt_timer_start:   timer=0xef7e8200([watchdog]) value=4000000000 interval=0 mode=0x0
>>>        pthelper-912   [000]   753.944172: cobalt_shadow_hardened: state=0x240840 info=0x0
>>>
>>> Your plugin correctly switches colors on cobalt_switch_context, but that
>>> cobalt_timer_start is still running under the previous pid, causing a
>>> color switch-back and than forth on cobalt_shadow_hardened. We need to
>>> understand why and possibly fix that or rethink the visualization.
>>
>> You need to click menu Plots->tasks and then select RT tasks and then apply. It would tigger plugin shape to redraw
>> and then the issue you observed would be fixed by plugin. 
> 
> OK, now I also see that blue "OOB" box under the RT task.
> 
> But the that does not affect the CPU graph, it continues to jump back
> and forth. And it has no RT mode visualization.

Correction: The CPU graph is fine now as well. Still confusing that you
have to enable task plots first, but that might be a generic KernelShark
issue.

> 
> BTW, is that blue hollow box exclusive for our plugin? Or can this be
> customized? Is it explained somewhere in Kernelshark what hollow boxes mean?
> 

Some visualization issue:

        pthelper-912   [000]   753.948271: cobalt_schedule:      status=0x10000000
        pthelper-912   [000]   753.948275: cobalt_switch_context: prev_name=pthelper prev_pid=912 prev_prio=3 prev_state=0xa40042 ==> next_name=hi-thread next_pid=913 next_prio=2
       hi-thread-913   [000]   753.948285: cobalt_shadow_hardened: state=0x240040 info=0x0
       hi-thread-913   [000]   753.948423: cobalt_thread_fault:  ip=0xb6e34e20 type=0x8
       hi-thread-913   [000]   753.948737: cobalt_shadow_gorelax: reason=syscall

In this case, the task plot of hi-thread-919 does no show the blue box 
between hardened and fault.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

