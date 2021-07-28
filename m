Subject: Re: [xenomai-image 1/3] recipes-kernel/linux: control appyling of no
 debug config fragment
References: <20210728022124.23466-1-hongzhan.chen@intel.com>
 <20210728022124.23466-2-hongzhan.chen@intel.com>
 <8792dbe1-a638-a1a7-f1d4-2344daae5440@siemens.com>
 <BN9PR11MB522761A4169EEF751D100A8BF2EA9@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <75fcd4f6-7f34-3742-be46-e465f9d0a8b7@siemens.com>
Date: Wed, 28 Jul 2021 08:20:31 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB522761A4169EEF751D100A8BF2EA9@BN9PR11MB5227.namprd11.prod.outlook.com>
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

On 28.07.21 08:14, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Wednesday, July 28, 2021 1:52 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [xenomai-image 1/3] recipes-kernel/linux: control appyling of no debug config fragment
>>
>> On 28.07.21 04:21, Hongzhan Chen via Xenomai wrote:
>>> By default, nodbg config fragment would not be applied.
>>>
>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>> ---
>>>  recipes-kernel/linux/linux-xenomai.inc | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
>>> index 185b60b..5f639df 100644
>>> --- a/recipes-kernel/linux/linux-xenomai.inc
>>> +++ b/recipes-kernel/linux/linux-xenomai.inc
>>> @@ -12,8 +12,10 @@
>>>  require recipes-kernel/linux/linux-custom.inc
>>>  
>>>  KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
>>> +DISTRO_NODBG ?= "0"
>>  
>>  SRC_URI += "file://${KERNEL_DEFCONFIG}"
>> +SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('DISTRO_NODBG') == '1' else ''}"
>>  
>>  DEPENDS += "xenomai-kernel-source"
>>  KBUILD_DEPENDS += "xenomai-kernel-source"
>>
>>
>> As discussed, let's flip the default to no-debug and enable debugging
>> via XENOMAI_DEBUG = "1", I would say.
> 
> If CI is using no-debug by default, some smokey tests would fail because they depends
> on CONFIG_XENO_OPT_DEBUG*. That is what we expect?
> 

As discussed, the CI setups would need :opt-debug.yml in addition. They
already have some special option to support LAVA needs.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

