Subject: Re: [PATCH 20/32] x86: fix include for drivers
References: <20180925103809.4932-1-rpm@xenomai.org>
 <20180925103809.4932-21-rpm@xenomai.org>
 <42a8d3eb-b06e-5514-949a-7fe7dd16b3e9@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9f7a78c5-ca53-a8fd-34a2-a12421dc9635@xenomai.org>
Date: Tue, 2 Jul 2019 19:02:50 +0200
MIME-Version: 1.0
In-Reply-To: <42a8d3eb-b06e-5514-949a-7fe7dd16b3e9@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, Henning Schild <henning.schild@siemens.com>

On 7/2/19 5:57 PM, Jan Kiszka wrote:
> On 25.09.18 12:37, Philippe Gerum wrote:
>> From: Henning Schild <henning.schild@siemens.com>
>>
>> ---
>>   include/linux/gpio.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
>> index 8ef7fc0ce0f0..41554f9e098d 100644
>> --- a/include/linux/gpio.h
>> +++ b/include/linux/gpio.h
>> @@ -3,6 +3,7 @@
>>   #define __LINUX_GPIO_H
>>     #include <linux/errno.h>
>> +#include <linux/ipipe.h>
>>     /* see Documentation/gpio/gpio-legacy.txt */
>>  
> 
> Where did this come from? It's also incorrectly tagged as "x86", though
> it's touching generic code.
> 

Cherry-picked from the x86 tree a year ago as far as I can remember
since this stuff happened a year ago, as I was working on the split work:

https://gitlab.denx.de/Xenomai/ipipe-x86/commit/ac02dfb4d71462b8ac5cd0ae5cf14d89b125124e

This change can be dropped unless you have a specific issue to solve for
x86 that you could not address in a better way, I did not pick it for
-noarch AFAICT.

-- 
Philippe.

