Subject: Re: [PATCH 0/3] add support for cherryview gpio controller driver
References: <20210830064527.18206-1-hongzhan.chen@intel.com>
 <bdf39dd6-fc39-e4b7-3159-87bc86269014@siemens.com>
 <BN9PR11MB5227ED7950F164C1235697D1F2CC9@BN9PR11MB5227.namprd11.prod.outlook.com>
 <4ca7072b-b386-25b7-3a01-8a3baea1290c@siemens.com>
 <DM4PR11MB523278B30AD2E7F021AF7D1AF2CC9@DM4PR11MB5232.namprd11.prod.outlook.com>
 <6dbc0237-c348-f787-775c-aa83b64782cd@siemens.com>
 <DM4PR11MB52321F602C87ED02E60DA4CAF2CC9@DM4PR11MB5232.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c2282c2-dbd3-016b-21f0-678428ad0164@siemens.com>
Date: Wed, 1 Sep 2021 16:26:48 +0200
MIME-Version: 1.0
In-Reply-To: <DM4PR11MB52321F602C87ED02E60DA4CAF2CC9@DM4PR11MB5232.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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

On 31.08.21 08:36, Chen, Hongzhan wrote:
>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>> Sent: Tuesday, August 31, 2021 1:59 PM
>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>> Subject: Re: [PATCH 0/3] add support for cherryview gpio controller driver
>>>>
>>>> On 31.08.21 03:35, Chen, Hongzhan wrote:
>>>>>>
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>>>> Sent: Monday, August 30, 2021 3:37 PM
>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>>>> Subject: Re: [PATCH 0/3] add support for cherryview gpio controller driver
>>>>>>
>>>>>> On 30.08.21 08:45, Hongzhan Chen via Xenomai wrote:
>>>>>>> 1. move out of OF config conditional compilation so that non-OF platform
>>>>>>>   call same API to remove rtdm gpio chip device.
>>>>>>> 2. Introduce helper to find gpiochip as referring to pair of 
>>>>>>>    rtdm_gpiochip_scan_of and rtdm_gpiochip_scan_array_of. 
>>>>>>> 3. Add Intel Cherryview pinctrl driver based on on 1 and 2.
>>>>>>>
>>>>>>
>>>>>> Looks good, except for that naming issue.
>>>>>>
>>>>>>> I also did following tests with this patchset:
>>>>>>> 1. run /usr/lib/xenomai/testsuite/gpiobench -i 334 -i 335 -c INT33FF:02
>>>>>>>    to validate patch 9afea5ff2d7ba97db96b22a005a9a7fcf5f2d892 when
>>>>>>>    setting GPIO_RTIOC_TS
>>>>>>> 2. apply following patch, and rerun 1.
>>>>>>>
>>>>>>> index f83d7689f..50afbd418 100644
>>>>>>> --- a/testsuite/gpiobench/gpiobench.c
>>>>>>> +++ b/testsuite/gpiobench/gpiobench.c
>>>>>>> @@ -619,7 +619,7 @@ int main(int argc, char **argv)
>>>>>>>                         goto out;
>>>>>>>                 }
>>>>>>>
>>>>>>> -               ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS, &value);
>>>>>>> +               ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS_MONO, &value);
>>>>>>>                 if (ret) {
>>>>>>>                         printf("ioctl gpio port ts, failed\n");
>>>>>>>                         goto out;
>>>>>>>
>>>>>>> Hardware env:
>>>>>>> 1. Rock PI X V1.4.
>>>>>>> 2. GPIO loopback connection between GPIO 334 and 335.
>>>>>>>  
>>>>>>
>>>>>> Did you check if timestamps are as expected (different)?
>>>>>
>>>>> According to output of gpiobench, the inner Avg Latency would be vary large like ( 2814377.00000) after switch to MONO.
>>>>> But it is only about  16.879997 when we set REALTIME. 
>>>>>
>>>>
>>>> gpiobench takes timestamps from CLOCK_MONOTONIC (see clock_gettime
>>>> calls)). If you compare them to REALTIME, that will give an offset. But
>>>> you report just the opposite, this confuses me now...
>>>
>>> The test is running on dovetail based 5.10.
>>>
>>
>> I missed one case in gpio_pin_interrupt where I need to check
>> monotonic_timestamp - but, again, mono is what should remain fine,
>> GPIO_RTIOC_TS_REAL (or GPIO_RTIOC_TS, the default) should give a delta.
> 
> I found there is one obvious gap for my comparison test.
> 
> For REALTEIM , it totally run 999999 like [1] till test normally exit. But for MONO, I force to quit during running
> because it may take several hours to finish and I can not wait like [2]. Let me rerun test and wait till it normally exit and 
> get result to check.
> 
> [1]:
> # Total: 000999999
> # Min Latencies: 00013
> # Avg Latencies: 16.879997
> # Max Latencies: 00043
> [2]:
> # Total: 000083988
> # Min Latencies: 00012
> # Avg Latencies: 2814377.000000
> # Max Latencies: 00041
> 

Were you able to resolve this mystery over latest next?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

