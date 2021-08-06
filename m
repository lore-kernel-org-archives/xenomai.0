Subject: Re: [xenomai-images][PATCH v2] linux-xenomai_4.4: Add machine
 specific config for beagle bone black
References: <20210805122922.31963-1-Quirin.Gylstorff@siemens.com>
 <d6887aad-c990-6cde-16cd-5f24919203f7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3af746fe-7fbd-c327-5974-953986d44130@siemens.com>
Date: Fri, 6 Aug 2021 11:21:13 +0200
MIME-Version: 1.0
In-Reply-To: <d6887aad-c990-6cde-16cd-5f24919203f7@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 05.08.21 16:41, Jan Kiszka via Xenomai wrote:
> On 05.08.21 14:29, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The beagle bone black does most[1] of the time not boot ipipe 4.4 + xenomai 3.0.x if
>> the following kernel configuration elements are active:
>>  - CONFIG_RAW_PRINTK
>>  - CONFIG_DEBUG_LL
>>  - CONFIG_IPIPE_DEBUG
>>  - CONFIG_XENO_OPT_DEBUG
>>
>> Last message in U-boot is:
>> ```
>> Starting kernel ...
>> ```
>>
>> 4.19 and newer are not impacted.
>>
>> [1]: The CI build boots around 1 out 4. See https://source.denx.de/Xenomai/xenomai-images/-/jobs/303430
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes V2:
>>  - replace defconfig with partial config
>>  - adapt commit message for sporatic CI boots
>>
>>  recipes-kernel/linux/files/bbb_4.4.cfg    | 4 ++++
>>  recipes-kernel/linux/linux-xenomai_4.4.bb | 1 +
>>  2 files changed, 5 insertions(+)
>>  create mode 100644 recipes-kernel/linux/files/bbb_4.4.cfg
>>
>> diff --git a/recipes-kernel/linux/files/bbb_4.4.cfg b/recipes-kernel/linux/files/bbb_4.4.cfg
>> new file mode 100644
>> index 0000000..4628f44
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/bbb_4.4.cfg
>> @@ -0,0 +1,4 @@
>> +# CONFIG_RAW_PRINTK is not set
>> +# CONFIG_DEBUG_LL is not set
>> +# CONFIG_IPIPE_DEBUG is not set
>> +# CONFIG_XENO_OPT_DEBUG is not set
>> diff --git a/recipes-kernel/linux/linux-xenomai_4.4.bb b/recipes-kernel/linux/linux-xenomai_4.4.bb
>> index 2a1137c..42c6d83 100644
>> --- a/recipes-kernel/linux/linux-xenomai_4.4.bb
>> +++ b/recipes-kernel/linux/linux-xenomai_4.4.bb
>> @@ -16,6 +16,7 @@ SRCREV_amd64 ?= "ipipe-core-4.4.268-cip57-x86-28"
>>  PV_amd64 = "4.4.268+"
>>  
>>  SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
>> +SRC_URI_append_armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
>>  SRCREV_armhf ?= "ipipe-core-4.4.268-cip57-arm-13"
>>  PV_armhf = "4.4.268+"
>>  
>>
> 
> Thanks, applied.
> 

Bad news: https://source.denx.de/Xenomai/xenomai-images/-/jobs/304747

Possibly, non-debug only lowers the probability of a regression on armhf
or bbb.

Where you able to grab any early boot messages in the failing cases?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

