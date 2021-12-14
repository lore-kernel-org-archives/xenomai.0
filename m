Subject: Re: [RFC PATCH 1/2] kernel-shark: add plugin for handling xenomai
 cobalt context switch event
References: <20211214031537.14914-1-hongzhan.chen@intel.com>
 <20211214031537.14914-2-hongzhan.chen@intel.com>
 <86f411ed-5725-74cd-a5ab-e1f0c3902120@siemens.com>
 <MN2PR11MB42851F06D18E71D4A540AA47F2759@MN2PR11MB4285.namprd11.prod.outlook.com>
 <7fea2c2d-648b-236a-e027-ca89bcc3b384@siemens.com>
 <a9090b11-5ec4-f443-dc77-8cff66db33c3@siemens.com>
 <MN2PR11MB4285CF265BD595000EF87617F2759@MN2PR11MB4285.namprd11.prod.outlook.com>
 <47ea721c-ec86-b979-51c6-3221eb95ef27@siemens.com>
 <MN2PR11MB42858DB94A373346DFEE65ADF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4c75fe1d-cfeb-65e1-46d2-9d4324f90aaf@siemens.com>
Date: Tue, 14 Dec 2021 08:50:54 +0100
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB42858DB94A373346DFEE65ADF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
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

On 14.12.21 08:46, Chen, Hongzhan wrote:
> 
>>>>>
>>>>> BTW, is that blue hollow box exclusive for our plugin? Or can this be
>>>>> customized? Is it explained somewhere in Kernelshark what hollow boxes mean?
>>>>>
>>>>
>>>> Some visualization issue:
>>>>
>>>>        pthelper-912   [000]   753.948271: cobalt_schedule:      status=0x10000000
>>>>        pthelper-912   [000]   753.948275: cobalt_switch_context: prev_name=pthelper prev_pid=912 prev_prio=3 prev_state=0xa40042 ==> next_name=hi-thread next_pid=913 next_prio=2
>>>>       hi-thread-913   [000]   753.948285: cobalt_shadow_hardened: state=0x240040 info=0x0
>>>>       hi-thread-913   [000]   753.948423: cobalt_thread_fault:  ip=0xb6e34e20 type=0x8
>>>>       hi-thread-913   [000]   753.948737: cobalt_shadow_gorelax: reason=syscall
>>>>
>>>> In this case, the task plot of hi-thread-919 does no show the blue box 
>>>> between hardened and fault.
>>>
>>> Could you zoom out (click "-" in the top left button) to check if blue box would be reshowing?
>>> Could you paste more trailing log in your log to check if there another cobalt_switch_context. Current logic is create hollow box between two cobalt_switch_context. If there is only cobalt switch_context event matching, it would not create hollow box correctly.
>>>
>>
>> Yeah, the problem is indeed that the bar is only drawn if beg AND end
>> points are visible - that is sure not useful. Does the drawing concept
>> of kernelshark imposes this limitation?
> 
> This should be common issue in kernelshark. I also observed same 
> issue on hollow red box for preempt latency implementation.
> 

Ok, another topic to discuss with their community :)

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

