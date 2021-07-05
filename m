Subject: Re: [xenomai-images PATCH] recipes-kernel: arm64_config: enable Rtnet
 Rtdmtest and RTIPC
References: <20210624064505.25467-1-hongzhan.chen@intel.com>
 <5e09fce4-2455-3cb4-791b-32a3fed46e75@siemens.com>
 <BN9PR11MB5227C06C8E6373E8DD9C0FECF21C9@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c39cfe3-8a92-cee4-9a84-a4800be3ddf2@siemens.com>
Date: Mon, 5 Jul 2021 09:22:35 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227C06C8E6373E8DD9C0FECF21C9@BN9PR11MB5227.namprd11.prod.outlook.com>
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

On 05.07.21 08:26, Chen, Hongzhan wrote:
> 
> 
>>
>>>  # UDD support
>>> @@ -469,10 +580,9 @@ CONFIG_XENO_ARCH_OUTOFLINE_XNLOCK=y
>>>  # cause troubles with Xenomai. You should disable them.
>>>  #
>>>  CONFIG_XENO_VERSION_MAJOR=3
>>> -CONFIG_XENO_VERSION_MINOR=0
>>> -CONFIG_XENO_REVISION_LEVEL=90
>>> -CONFIG_XENO_VERSION_STRING="3.1-devel"
>>> -CONFIG_XENO_VERSION_NAME="Xenomai -next"
>>> +CONFIG_XENO_VERSION_MINOR=1
>>> +CONFIG_XENO_REVISION_LEVEL=0
>>> +CONFIG_XENO_VERSION_STRING="3.1"
>>>  CONFIG_FREEZER=y
>>>  
>>>  #
>>>
>>
>> This revealed a bug in bufp [1] - good that we enabled it...
>>
>> I think we still need something similar for armhf as well.
> 
> I can help enable them for armhf but the problem is that I do not have arm platform
> so that I cannot validate the patch for armhf.
> 

QEMU is sufficient for a first test, the rest will be revealed by the lab.

Thanks in advance!
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

