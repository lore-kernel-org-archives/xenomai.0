Subject: Re: [PATCH 2/3] drivers/gpio: core: Introduce helper to find gpiochip
References: <20210831050736.5371-1-hongzhan.chen@intel.com>
 <20210831050736.5371-3-hongzhan.chen@intel.com>
 <aa94a2a6-9660-3e56-5e4c-b74b9a35ed95@siemens.com>
 <BN9PR11MB5227700E4BDB4B840D9AB353F2CC9@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3005778f-3d0b-bd98-6b46-fd020fd9868c@siemens.com>
Date: Tue, 31 Aug 2021 09:14:19 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227700E4BDB4B840D9AB353F2CC9@BN9PR11MB5227.namprd11.prod.outlook.com>
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

On 31.08.21 09:07, Chen, Hongzhan wrote:
> 
> 
>  -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Tuesday, August 31, 2021 2:48 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH 2/3] drivers/gpio: core: Introduce helper to find gpiochip
>>
>> On 31.08.21 07:07, Hongzhan Chen via Xenomai wrote:
>>> To find gpiochip for non-OF platforms like x86
>>>
>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>> ---
>>>  include/cobalt/kernel/rtdm/gpio.h |  7 ++++++
>>>  kernel/drivers/gpio/gpio-core.c   | 42 +++++++++++++++++++++++++++++++
>>>  2 files changed, 49 insertions(+)
>>>
>>> diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
>>> index 29f26d6c6..98279e242 100644
>>> --- a/include/cobalt/kernel/rtdm/gpio.h
>>> +++ b/include/cobalt/kernel/rtdm/gpio.h
>>> @@ -62,6 +62,13 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
>>>  int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
>>>  			     unsigned int offset);
>>>  
>>> +int rtdm_gpiochip_find(struct device_node *from,
>>> +			  const char *label, int type);
>>> +
>>> +int rtdm_gpiochip_array_find(struct device_node *from,
>>> +				const char *compat[],
>>> +				int nentries, int type);
>>> +
>>>  #ifdef CONFIG_OF
>>>  
>>>  int rtdm_gpiochip_scan_of(struct device_node *from,
>>> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
>>> index ccda67bd1..ce80e8d73 100644
>>> --- a/kernel/drivers/gpio/gpio-core.c
>>> +++ b/kernel/drivers/gpio/gpio-core.c
>>> @@ -528,6 +528,48 @@ int rtdm_gpiochip_add_by_name(struct rtdm_gpio_chip *rgc,
>>>  }
>>>  EXPORT_SYMBOL_GPL(rtdm_gpiochip_add_by_name);
>>>  
>>> +int rtdm_gpiochip_find(struct device_node *from, const char *label,
>>> +			  int type)
>>> +{
>>> +	struct rtdm_gpio_chip *rgc;
>>> +	struct gpio_chip *chip;
>>> +	int ret = -ENODEV;
>>> +
>>> +	if (!rtdm_available())
>>> +		return -ENOSYS;
>>> +
>>> +	chip = find_chip_by_name(label);
>>> +	if (chip == NULL)
>>> +		return ret;
>>> +
>>> +	ret = 0;
>>> +	rgc = rtdm_gpiochip_alloc(chip, type);
>>> +	if (IS_ERR(rgc))
>>> +		ret = PTR_ERR(rgc);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(rtdm_gpiochip_find);
>>> +
>>> +int rtdm_gpiochip_array_find(struct device_node *from,
>>> +				const char *compat[],
>>
>> Is "compat" the right argument name here? We are searching by name
>> (label), no?
> 
> Yes , it is label. Let me modify it. So patch 1/3 is accepted ?
> 

Already done that locally while merging. Also just renamed compat_array
to label_array in patch 3. Let me push this then.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

