Subject: Re: questions about comments on
 https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33
References: <BY5PR11MB4276970F873C8A411A7D555EF26E9@BY5PR11MB4276.namprd11.prod.outlook.com>
 <24acf7bd-1e34-a094-7853-9ad1602d8ddf@siemens.com>
 <MN2PR11MB4285BDFDBBA5193F5586B42AF2749@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB4285148014996C770370B416F2749@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5960f5c9-256a-44c8-f13b-87c0cd24f7b3@siemens.com>
Date: Mon, 13 Dec 2021 08:48:26 +0100
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB4285148014996C770370B416F2749@MN2PR11MB4285.namprd11.prod.outlook.com>
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

On 13.12.21 03:37, Chen, Hongzhan wrote:
> 
> 
>  
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>> Sent: Thursday, December 9, 2021 5:35 PM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>> Subject: Re: questions about comments on https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33
>>>
>>> On 07.12.21 04:11, Chen, Hongzhan wrote:
>>>> Hi Jan
>>>>
>>>> I have some questions about comments on  https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33 and need your help to comment more.
>>>>
>>>> 1. I do not quite understand the requirement "visualize task switches correctly in Kernelshark (color in CPU bar is not updating on cobalt_switch_context)".
>>>>
>>>> When I click the cobalt_switch_context event listed in the event table on the second half in the kernelshark, actually color in cpu bar is updating to 
>>>> green because there is long green vertical  line to mark focused event like attached picture.  In addition , In spite of focused thing,  colors mainly 
>>>> change depending on what task is running for cpu plots in kernelshark. when cobalt_switch_context is traced, it still be in the prev context and its 
>>>> color is same with task prev in kernelshark. Do we want to update color of  cobalt_switch_context  to specific color different from all tasks even if there is no 
>>>> focused thing?  What result do we need to achieve when there is cobalt_switch_context, Could you be more specific?
>>>>
>>>
>>> I assume this one is resolved now, at least regarding what the goal
>>> would be.
>>>
>>>> 2. Regarding  the requirement " visualize RT/Non-RT (out-of-band/in-band) state in CPU bar)",
>>>>     2.1. Do we need to differentiate state  running a Linux task out-of-band and running whatever code from the out-of-band execution stage as described in 
>>>>              " What you really need to know at this point" of  https://evlproject.org/dovetail/altsched/?
>>>>     2.2 What state do we want to show  in CPU bar? Different color covering the size of  RT/Non-RT state other than all tasks and CPUs?  If so, we may ask for a plugin
>>>>           in kernelshark , which would raise similar question as you mentioned in comments.
>>>
>>> I suspect it would be best to decouple to stage state (in-band, oob)
>> >from the current task, maybe by adding another bar underneath the task
>  >bar for each CPU that shows this state.
>>
>> What about painting a hollow blue box under the baseline of corresponding task 
>> to mark running in OOB state, starting from first cobalt_switch_context switching
>> task in  to next cobalt_switch_context switching it out like attached pic?
> 
> The hollow box is commonly used in task plot such as hollow green box for wake up latency
> as described in page 15 of [1].
> 

Then we only need to find a pattern that cannot be confused with
existing plots.

Can that plotting be provided by a custom plugin?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

