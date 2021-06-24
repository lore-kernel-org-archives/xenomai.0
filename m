Subject: Re: [xenomai-images PATCH] tests: restrict realtime cpu
References: <20210623053136.22521-1-hongzhan.chen@intel.com>
 <84895ed2-041a-b755-03a6-fe11c5038ff1@siemens.com>
 <DM4PR11MB523256D02BC0CC8132DFD67AF2089@DM4PR11MB5232.namprd11.prod.outlook.com>
 <e97550ea-d05b-924a-836e-e46df5f27f30@siemens.com>
 <BN9PR11MB5227A113F243ADB55AEFAF7BF2079@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <967a409a-9c9b-b212-63c7-26e36a3bc767@siemens.com>
Date: Thu, 24 Jun 2021 10:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227A113F243ADB55AEFAF7BF2079@BN9PR11MB5227.namprd11.prod.outlook.com>
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

On 24.06.21 03:21, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Wednesday, June 23, 2021 5:15 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [xenomai-images PATCH] tests: restrict realtime cpu
>>
>> On 23.06.21 09:58, Chen, Hongzhan wrote:
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>> Sent: Wednesday, June 23, 2021 2:18 PM
>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>> Subject: Re: [xenomai-images PATCH] tests: restrict realtime cpu
>>>>
>>>> On 23.06.21 07:31, Hongzhan Chen wrote:
>>>>> If there is no CPU restriction on the bootargs, smokey cpu_affinity
>>>>> test would be skipped reporting with "no kernel support".
>>>>>
>>>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>>>>
>>>>> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
>>>>> index 034ac99..8117f29 100644
>>>>> --- a/tests/jobs/xenomai-beagle-bone-black.yml
>>>>> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
>>>>> @@ -71,3 +71,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
>>>>> index f6eb4a4..5987c94 100644
>>>>> --- a/tests/jobs/xenomai-hikey.yml
>>>>> +++ b/tests/jobs/xenomai-hikey.yml
>>>>> @@ -70,3 +70,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
>>>>> index a5a181c..7f3600d 100644
>>>>> --- a/tests/jobs/xenomai-ipc227e.yml
>>>>> +++ b/tests/jobs/xenomai-ipc227e.yml
>>>>> @@ -72,3 +72,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
>>>>> index d5292ff..98c3eac 100644
>>>>> --- a/tests/jobs/xenomai-minnow.yml
>>>>> +++ b/tests/jobs/xenomai-minnow.yml
>>>>> @@ -71,3 +71,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
>>>>> index c335292..b35a1a5 100644
>>>>> --- a/tests/jobs/xenomai-qemu-amd64.yml
>>>>> +++ b/tests/jobs/xenomai-qemu-amd64.yml
>>>>> @@ -87,3 +87,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
>>>>> index 88fb880..27418ff 100644
>>>>> --- a/tests/jobs/xenomai-qemu-arm64.yml
>>>>> +++ b/tests/jobs/xenomai-qemu-arm64.yml
>>>>> @@ -93,3 +93,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
>>>>> index 3e3a8ab..14501b7 100644
>>>>> --- a/tests/jobs/xenomai-qemu-armhf.yml
>>>>> +++ b/tests/jobs/xenomai-qemu-armhf.yml
>>>>> @@ -87,3 +87,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
>>>>> index bc71b75..95b2288 100644
>>>>> --- a/tests/jobs/xenomai-x86-64-efi.yml
>>>>> +++ b/tests/jobs/xenomai-x86-64-efi.yml
>>>>> @@ -72,3 +72,5 @@ actions:
>>>>>        from: inline
>>>>>        path: inline/xenomai-test-suite.yaml
>>>>>        name: xenomai-test-suite
>>>>> +context:
>>>>> +  extra_kernel_args: xenomai.supported_cpus=1
>>>>>
>>>>
>>>> Let's not make all targets single-core regarding real-time. Rather,
>>>> exclude one single-core from the real-time domain.
>>>
>>> If we pass invalid supported_cpus value, cpu-affinity test would return EINVAL error.
>>> That means we cannot set uniform value for different boards because different
>>> boards have different cpu configuration if we want to exclude one signal-core
>>> from real-time domain via xenomai.supported_cpus. In addition , I do not know
>>> the exact  hardware cpu configuration for different target boards behind each lava test job. 
>>
>> You can extract the information from the test logs, see e.g.
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/281065, "SMP: Total
>> of 1 processors activated (996.14 BogoMIPS)."
> 
> What about xenomai-ipc227e.yml and xenomai-minnow.yml? I cannot find any log for them and seems
> these two  jobs never run. Do I need to touch them?

Yeah, confusing: The 227e is the x86 target, eg.
https://source.denx.de/Xenomai/xenomai-images/-/jobs/281072. We don't
have the minnow in the rack because it turned out to be too borken
firmware-wise. Maybe time to drop that file.

> In addition, our patch does not work for single cpu system.
> 

Right, single-core targets (but that should only be the BBB in the rack)
needs to be be skipped.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

