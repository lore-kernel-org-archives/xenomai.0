Message-ID: <365a207c-715a-13d6-db37-a8112ea480c6@siemens.com>
Date: Wed, 8 Jun 2022 17:20:50 +0200
MIME-Version: 1.0
Subject: Re: [Cobalt Xenoami3.1 PATCH 0/2] notify Xenomai udpated clockfreq.
Content-Language: en-US
References: <20220527062203.9498-1-hongzhan.chen@intel.com>
 <64079ce9-c264-055f-7911-7a24144f4a15@siemens.com>
 <MN2PR11MB42854A46A29C0E45D1B39944F2DE9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42854A46A29C0E45D1B39944F2DE9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.06.22 14:56, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Thursday, June 2, 2022 5:54 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [Cobalt Xenoami3.1 PATCH 0/2] notify Xenomai udpated clockfreq.
>>
>> On 27.05.22 08:22, Hongzhan Chen via Xenomai wrote:
>>> When there is refined tsc clock, notify Xenomai to apply it.
>>> Linux may schedule a delayed work to refine tsc clock and update
>>> tsc_khz which happen after Xenomai finsih init but tsc_scale and
>>> tsc_shift still keep the value depending on origianl tsc clock
>>> which is outdated. The difference between two clocks may cause
>>> timing issue.
>>>
>>> For example:
>>>   [ 0.001731] tsc: Detected 2899.886 MHz TSC
>>>   [ 5.588387] tsc: Refined TSC clocksource calibration: 2903.999 MHz
>>>   cat /sys/module/xenomai/parameters/clockfreq
>>>   2899886000
>>>   After patching, we like to use 2903.999 MHz.
>>>
>>> The patchset includes IPIPE patch and cobalt-patch.
>>>
>>
>> Sounds reasonable, but you could help me with reviewing this by already
>> answering:
>>
>> - How does dovetail (and xenomai 3.2 or evl) address this?
> 
> So far , I have not found similar issue on dovetail-based. Dovetail-based would go vdso uniformly so there is
> no such issue but IPIPE would have to depend  on tsc_khz value it got at first to do translation even after tsc clockfreq is refined and changed.

Right, that is reason...

> 
>> - Why is this tagged "3.1" only?
>> - Which I-pipe series is this targeting (5.4, or also 4.19)?
> 
> Currently , I just reproduced this issue and verified the patch on 5.4.133 + xenomai 3.1. But according to [1] reported,
> the issue can be found on 4.19 and I think my patch may work but I have not verified on 4.19. 
> 

Please check stable/v3.2.x first (or as well) as that is the latest
stable with I-pipe still included. Once the fix is merged there, we can
pick it for 3.1 and possibly even 3.0 as well.

Jan

> Regards
> 
> Hongzhan Chen
> 
> 
> [1]: https://xenomai.org/pipermail/xenomai/2022-May/047770.html
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

