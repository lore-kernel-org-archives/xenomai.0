From: =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@theobroma-systems.com>
Message-Id: <1FAF00CD-2C74-4405-A20F-B0D47A3B803D@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 9 Nov 2017 11:43:30 +0100
In-Reply-To: <813c4cb9-86e3-d13d-a52e-c13a9cd0380c@xenomai.org>
References: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
 <20171106094646.28769-3-christoph.muellner@theobroma-systems.com>
 <813c4cb9-86e3-d13d-a52e-c13a9cd0380c@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2 2/3] RTDM: uapi: Define ioctl code to set
 an IRQ affinity.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


> On 9 Nov 2017, at 11:04, Philippe Gerum <rpm@xenomai.org> wrote:
> 
> On 11/06/2017 10:46 AM, Christoph Muellner wrote:
>> This patch adds an ioctl code to set a GPIO IRQ's CPU affinity
>> to the RTDM user space API.
>> 
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> ---
>> include/rtdm/uapi/gpio.h | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
>> index f846f48b2..e70da2621 100644
>> --- a/include/rtdm/uapi/gpio.h
>> +++ b/include/rtdm/uapi/gpio.h
>> @@ -18,10 +18,16 @@
>> #ifndef _RTDM_UAPI_GPIO_H
>> #define _RTDM_UAPI_GPIO_H
>> 
>> +typedef struct {
>> +	void* mask;
> 
> Asking explicitly for unsigned long * may give a better hint about what
> is expected.

I agree, but then we need a cast when using cpu_set_t in user space, which is even more ugly.

This is user code, which works atm:

        cpu_set_t mask;
        CPU_ZERO(&mask);
        CPU_SET(4, &mask); //CPU 4 only
        rtdm_cpumask_t rtdm_mask;
        rtdm_mask.mask = &mask; //assignment of mask
        rtdm_mask.size = sizeof(mask);

When making mask a unsigned long*, then the assignment of mask does not work anymore
without having the compiler complaining about incompatible types.
The reason is, that libc uses the following type hierarchy for cpu_set_t (bits/sched.h):

	typedef unsigned long int __cpu_mask;
	typedef struct
	{
	  __cpu_mask __bits[__CPU_SETSIZE / __NCPUBITS];
	} cpu_set_t;

So besides casting, only something like this would work:

	...
	rtdm_mask.mask = &mask.__bits;
	...

Making mask a cpu_set_t* is problematic, because this type is only available in
user space and not in kernel.

So I saw two choices: making a wrapper function rtdm_gpio_setirqaff(int fd, cpu_set_t &mask),
which hides the cast or use void* for the mask. The wrapper function would hide the cpu_set_t
from the kernel by using #ifndef __KERNEL__ around it.

Do you prefer the wrapper function?

Thanks,
Christoph


> 
>> +	size_t size;
>> +} rtdm_cpumask_t;
>> +
>> #define GPIO_RTIOC_DIR_OUT		_IOW(RTDM_CLASS_GPIO, 0, int)
>> #define GPIO_RTIOC_DIR_IN		_IO(RTDM_CLASS_GPIO, 1)
>> #define GPIO_RTIOC_IRQEN		_IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO trigger */
>> #define GPIO_RTIOC_IRQDIS		_IO(RTDM_CLASS_GPIO, 3)
>> +#define GPIO_RTIOC_IRQAFF		_IOW(RTDM_CLASS_GPIO, 4, rtdm_cpumask_t*)
>> 
>> #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
>> #define GPIO_TRIGGER_EDGE_RISING	0x1
>> 
> 
> 
> --
> Philippe.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 874 bytes
Desc: Message signed with OpenPGP
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171109/3674f3e9/attachment.sig>
