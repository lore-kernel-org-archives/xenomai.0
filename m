Subject: Re: [PATCH 02/12] drivers/gpio: provide optional timestamped readouts
References: <20190124153428.21006-1-rpm@xenomai.org>
 <20190124153428.21006-3-rpm@xenomai.org>
 <4d1c39af-7a6f-1637-7727-ab6ad6d533c1@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <40b168af-98d1-955d-ff01-ae5e70113744@xenomai.org>
Date: Fri, 25 Jan 2019 10:15:35 +0100
MIME-Version: 1.0
In-Reply-To: <4d1c39af-7a6f-1637-7727-ab6ad6d533c1@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 1/24/19 7:17 PM, Jan Kiszka wrote:
> On 24.01.19 16:34, Philippe Gerum wrote:
>> In timestamping mode, read() returns the timestamp of the latest event
>> receipt on the pin based on CLOCK_MONOTONIC, along with the pin
>> state. This is an optional pin readout mode controlled by the
>> GPIO_RTIOC_TS request, e.g.:
>>
>> struct rtdm_gpio_readout rdo;
>> int ret, on, val;
>>
>> on = 1;
>> ret = ioctl(pinfd, GPIO_RTIOC_TS, &on);
>> ret = read(pinfd, &rdo, sizeof(rdo));
>> /* pin state changed to rdo.value at time rdo.timestamp */
>>
>> on = 0;
>> ret = ioctl(pinfd, GPIO_RTIOC_TS, &on);
>> ret = read(pinfd, &val, sizeof(val));
>> /* pin state changed to value (time of change unspecified) */
>>
>> By default, timestamping mode is disabled, which corresponds to the
>> original behavior.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>   include/cobalt/kernel/rtdm/gpio.h |  1 +
>>   include/rtdm/uapi/gpio.h          | 18 +++++++----
>>   kernel/drivers/gpio/gpio-core.c   | 54 +++++++++++++++++++++++--------
>>   3 files changed, 54 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/cobalt/kernel/rtdm/gpio.h
>> b/include/cobalt/kernel/rtdm/gpio.h
>> index cdb472f8a..00055ec0a 100644
>> --- a/include/cobalt/kernel/rtdm/gpio.h
>> +++ b/include/cobalt/kernel/rtdm/gpio.h
>> @@ -33,6 +33,7 @@ struct rtdm_gpio_pin {
>>       rtdm_event_t event;
>>       char *name;
>>       struct gpio_desc *desc;
>> +    nanosecs_abs_t timestamp;
>>   };
>>     struct rtdm_gpio_chip {
>> diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
>> index b745f156c..ac14be66c 100644
>> --- a/include/rtdm/uapi/gpio.h
>> +++ b/include/rtdm/uapi/gpio.h
>> @@ -18,12 +18,18 @@
>>   #ifndef _RTDM_UAPI_GPIO_H
>>   #define _RTDM_UAPI_GPIO_H
>>   -#define GPIO_RTIOC_DIR_OUT        _IOW(RTDM_CLASS_GPIO, 0, int)
>> -#define GPIO_RTIOC_DIR_IN        _IO(RTDM_CLASS_GPIO, 1)
>> -#define GPIO_RTIOC_IRQEN        _IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO
>> trigger */
>> -#define GPIO_RTIOC_IRQDIS        _IO(RTDM_CLASS_GPIO, 3)
>> -#define GPIO_RTIOC_REQS                _IO(RTDM_CLASS_GPIO, 4)
>> -#define GPIO_RTIOC_RELS                _IO(RTDM_CLASS_GPIO, 5)
>> +struct rtdm_gpio_readout {
>> +    __u64 timestamp;
> 
> nanosecs_abs_t - we use this type also in to userspace interface.
> 

Nope. This is ABI stuff, nanosecs_abs_t is not guaranteed to have the
same size regardless of the ABI models, which is unsafe in mixed 32/64
model configurations. OTOH, __u64 is safe.

-- 
Philippe.

