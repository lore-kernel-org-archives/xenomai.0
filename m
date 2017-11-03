References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
 <20171023145944.11262-4-christoph.muellner@theobroma-systems.com>
 <d8476ff1-e996-b233-7922-90830aa08657@xenomai.org>
 <8C3B5CAC-F9E4-4623-8710-F3D45B450288@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <640b4d32-fdb8-f61b-67a5-027f6e953584@xenomai.org>
Date: Fri, 3 Nov 2017 15:32:15 +0100
MIME-Version: 1.0
In-Reply-To: <8C3B5CAC-F9E4-4623-8710-F3D45B450288@theobroma-systems.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH 3/3] kernel: rtdm: gpio: Add support for
 GPIO_RTIOC_IRQAFF.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@theobroma-systems.com>
Cc: xenomai@xenomai.org

On 11/03/2017 01:06 PM, Christoph M=FCllner wrote:
>> On 29 Oct 2017, at 18:36, Philippe Gerum <rpm@xenomai.org> wrote:
>>
>> On 10/23/2017 04:59 PM, Christoph Muellner wrote:
>>> To set a GPIO interrupt's CPU affinity, we simply call
>>> rtdm_irq_affinity() with a proper bitmask.
>>>
>>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems=
.com>
>>> ---
>>> kernel/drivers/gpio/gpio-core.c | 25 +++++++++++++++++++++++++
>>> 1 file changed, 25 insertions(+)
>>>
>>> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio=
-core.c
>>> index 55594f6ae..84153a937 100644
>>> --- a/kernel/drivers/gpio/gpio-core.c
>>> +++ b/kernel/drivers/gpio/gpio-core.c
>>> @@ -118,6 +118,23 @@ static void release_gpio_irq(unsigned int gpio, st=
ruct rtdm_gpio_pin *pin,
>>> 	chan->requested =3D false;
>>> }
>>>
>>> +static int set_gpio_irq_affinity(struct rtdm_gpio_pin *pin, int val)
>>> +{
>>> +	cpumask_t tgt;
>>> +	unsigned int i =3D 0;
>>> +
>>> +	cpumask_clear(&tgt);
>>> +
>>> +	while (val) {
>>> +		if (val & (1 << i))
>>> +			cpumask_set_cpu(i, &tgt);
>>> +		val &=3D ~(1 << i);
>>> +		i++;
>>> +	}
>>> +
>>> +	return rtdm_irq_affinity(&pin->irqh, tgt);
>>> +}
>>> +
>>
>> Reflecting the change from int -> cpu_set_t in the ABI, we could have
>> something along these lines instead:
>>
>> static int set_gpio_irq_affinity(struct rtdm_gpio_pin *pin, unsigned
>> long __user *u_set, size_t setsize)
>> {
>> 	cpumask_var_t mask;
>> 	int ret;
>>
>> 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>> 		return -ENOMEM;
>>
>> 	ret =3D get_user_cpu_mask(u_set, setsize, mask);
>> 	if (ret =3D=3D 0)
>> 		ret =3D do_set_gpio_affinity(pin, mask);
>>
>> 	free_cpumask_var(mask);
>>
>> 	...
>=20
> Thanks for your review!
>=20
> I guess this is inspired from kernel/sched/core.c's sched_setaffinity() s=
yscall handler.
> However, I prefer not to use the use the alloc_cpumask_var() function.
> The reason is, that "alloc_cpumask_var allocates only nr_cpumask_bits bit=
s", whil> a "real cpumask_t always has NR_CPUS bits" (quoting from the warn=
ing
in linux/cpumask.h)
> As rtdm_irq_affinity() expects a cpumask_t as second argument, we would c=
opy
> a too small mask. Instead I'm going to use a (stack allocated) cpumask_t.

Unfortunately, this is somewhat papering over the real issue:
ipipe_set_irq_affinity(), xnintr_affinity() and rtdm_irq_affinity()
should all receive a struct cpumask pointer instead. Passing the mask by
value is wrong. This said, we have API backward compat requirements
which prevents from fixing ipipe_set_irq_affinity() without introducing
specific conditional cruft. So, ok. Let's go for propagating the
problem, until the interrupt pipeline is overhauled.

--=20
Philippe.

