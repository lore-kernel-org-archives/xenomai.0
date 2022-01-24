Message-ID: <7f414f9e-55b1-46ec-fb2f-2f30f0f51b4c@siemens.com>
Date: Mon, 24 Jan 2022 18:32:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Added verbosity to 16550A serial driver. dmesg shows
 the ports, irqs, baudbases.
Content-Language: en-US
References: <20220123081859.3266-1-ksmola51@gmail.com>
 <4d3e4269cc2358f3ef0864cd08ef3402cfe1b748.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4d3e4269cc2358f3ef0864cd08ef3402cfe1b748.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "ksmola51@gmail.com" <ksmola51@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.01.22 08:40, Bezdeka, Florian via Xenomai wrote:
> On Sun, 2022-01-23 at 00:18 -0800, Konstantin Smola via Xenomai wrote:
>> kernel/drivers/serial: Added verbosity to 16550A serial driver. dmesg shows the ports, irqs, baudbases.
>> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
>> ---
>>   kernel/drivers/serial/16550A.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
>> index c9274fb19..325737f65 100644
>> --- a/kernel/drivers/serial/16550A.c
>> +++ b/kernel/drivers/serial/16550A.c
>> @@ -31,6 +31,7 @@ MODULE_VERSION("1.5.2");
>>   MODULE_LICENSE("GPL");
>>   
>>   #define RT_16550_DRIVER_NAME	"xeno_16550A"
>> +static char mod_name[64]=RT_16550_DRIVER_NAME;
> 
> How about using RT_16550_DRIVER_NAME directly?
> 
>>   
>>   #define MAX_DEVICES		8
>>   
>> @@ -1128,6 +1129,8 @@ int __init rt_16550_init(void)
>>   		name = (char *)(dev + 1);
>>   		ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
>>   
>> +		rtdm_printk("%s: %s io=0x%x irq=%d baud_base=%d\n", mod_name, name, (unsigned)rt_16550_base_addr(i),irq[i],baud_base[i]);
>> +
> 
> I guess Jan will comment on that as well, not sure if we really need
> such verbose outputs.

Yeah, but more for style reasons (overlong line). The output itself is 
OK, comparable to what Linux reports about its TTYs on boot-up too.

> Technically I wonder if that is the right
> location. The initialization might still fail below. So maybe move it
> to the place where the device is up and running?

That is a valid point, specifically as there is no error output otherwise.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

