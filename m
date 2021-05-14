Subject: Re: [for-upstream/dovetail 1/2] drivers/gpio: core: introduce helper
 to find array of gpiochips
References: <20210513010238.32466-1-hongzhan.chen@intel.com>
 <20210513010238.32466-2-hongzhan.chen@intel.com>
 <ab2507ce-cc32-c85e-2e0a-80d95f2067ce@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <2e41efd7-519f-d9c4-feda-8f60fc4ceb1c@siemens.com>
Date: Fri, 14 May 2021 11:10:35 +0200
In-Reply-To: <ab2507ce-cc32-c85e-2e0a-80d95f2067ce@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 14.05.21 10:55, Florian Bezdeka via Xenomai wrote:
> On 13.05.21 03:02, hongzha1 via Xenomai wrote:
>> To find array of gpiochips for non-OF platform
>>
>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>> ---
>>  include/cobalt/kernel/rtdm/gpio.h |  4 ++++
>>  kernel/drivers/gpio/gpio-core.c   | 19 +++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
>> index c5fb20f25..99772f558 100644
>> --- a/include/cobalt/kernel/rtdm/gpio.h
>> +++ b/include/cobalt/kernel/rtdm/gpio.h
>> @@ -64,6 +64,10 @@ int rtdm_gpiochip_post_event(struct rtdm_gpio_chip *rgc,
>>  int rtdm_gpiochip_find(struct device_node *from,
>>  			  const char *label, int type);
>>  
>> +int rtdm_gpiochip_array_find(struct device_node *from,
>> +				const char *compat[],
>> +				int nentries, int type);
>> +
>>  #ifdef CONFIG_OF
>>  
>>  int rtdm_gpiochip_scan_of(struct device_node *from,
>> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
>> index b3d801fa1..20a6d7875 100644
>> --- a/kernel/drivers/gpio/gpio-core.c
>> +++ b/kernel/drivers/gpio/gpio-core.c
>> @@ -543,6 +543,25 @@ int rtdm_gpiochip_find(struct device_node *from, const char *label,
>>  }
>>  EXPORT_SYMBOL_GPL(rtdm_gpiochip_find);
>>  
>> +int rtdm_gpiochip_array_find(struct device_node *from,
>> +				const char *compat[],
>> +				int nentries, int type)
>> +{
>> +	int ret = -ENODEV, _ret, n;
>> +
>> +	for (n = 0; n < nentries; n++) {
>> +		_ret = rtdm_gpiochip_find(from, compat[n], type);
>> +		if (_ret) {
>> +			if (_ret != -ENODEV)
>> +				return _ret;
>> +		} else
>> +			ret = 0;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> I'm not sure if I completely understand the code, but maybe it could be
> simplified to:
> 
> {
> 	int ret, n;
> 
> 	for (n = 0; n < nentries; n++) {
> 		ret = rtdm_gpiochip_find(from, compat[n], type);
> 
> 		if (ret && ret != -ENODEV)
> 			break;
> 	}
> 
> 	return ret;
> }

v2:
{
	int ret, n;

	for (n = 0; n < nentries; n++) {
		ret = rtdm_gpiochip_find(from, compat[n], type);

		if (ret && ret != -ENODEV)
			break;

		// Should we stop on first -ENODEV?
		if (ret && ret == -ENODEV)
			ret = 0;
	}

	return ret;
}
> 
>> +EXPORT_SYMBOL_GPL(rtdm_gpiochip_array_find);
>> +
>>  #ifdef CONFIG_OF
>>  
>>  #include <linux/of_platform.h>
>>
> 
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

