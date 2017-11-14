From: Philippe Gerum <rpm@xenomai.org>
References: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
 <20171106094646.28769-3-christoph.muellner@theobroma-systems.com>
 <813c4cb9-86e3-d13d-a52e-c13a9cd0380c@xenomai.org>
 <1FAF00CD-2C74-4405-A20F-B0D47A3B803D@theobroma-systems.com>
Message-ID: <f0f8499d-f11f-b76f-9be1-ece179ce4d72@xenomai.org>
Date: Tue, 14 Nov 2017 17:43:28 +0100
MIME-Version: 1.0
In-Reply-To: <1FAF00CD-2C74-4405-A20F-B0D47A3B803D@theobroma-systems.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@theobroma-systems.com>
Cc: xenomai@xenomai.org

On 11/09/2017 11:43 AM, Christoph M=FCllner wrote:
>=20
>> On 9 Nov 2017, at 11:04, Philippe Gerum <rpm@xenomai.org> wrote:
>>
>> On 11/06/2017 10:46 AM, Christoph Muellner wrote:
>>> This patch adds an ioctl code to set a GPIO IRQ's CPU affinity
>>> to the RTDM user space API.
>>>
>>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems=
.com>
>>> ---
>>> include/rtdm/uapi/gpio.h | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
>>> index f846f48b2..e70da2621 100644
>>> --- a/include/rtdm/uapi/gpio.h
>>> +++ b/include/rtdm/uapi/gpio.h
>>> @@ -18,10 +18,16 @@
>>> #ifndef _RTDM_UAPI_GPIO_H
>>> #define _RTDM_UAPI_GPIO_H
>>>
>>> +typedef struct {
>>> +	void* mask;
>>
>> Asking explicitly for unsigned long * may give a better hint about what
>> is expected.
>=20
> I agree, but then we need a cast when using cpu_set_t in user space, whic=
h is even more ugly.
>=20
> This is user code, which works atm:
>=20
>         cpu_set_t mask;
>         CPU_ZERO(&mask);
>         CPU_SET(4, &mask); //CPU 4 only
>         rtdm_cpumask_t rtdm_mask;
>         rtdm_mask.mask =3D &mask; //assignment of mask
>         rtdm_mask.size =3D sizeof(mask);
>=20
> When making mask a unsigned long*, then the assignment of mask does not w=
ork anymore
> without having the compiler complaining about incompatible types.
> The reason is, that libc uses the following type hierarchy for cpu_set_t =
(bits/sched.h):
>=20
> 	typedef unsigned long int __cpu_mask;
> 	typedef struct
> 	{
> 	  __cpu_mask __bits[__CPU_SETSIZE / __NCPUBITS];
> 	} cpu_set_t;
>=20
> So besides casting, only something like this would work:
>=20
> 	...
> 	rtdm_mask.mask =3D &mask.__bits;
> 	...
>=20
> Making mask a cpu_set_t* is problematic, because this type is only availa=
ble in
> user space and not in kernel.
>=20
> So I saw two choices: making a wrapper function rtdm_gpio_setirqaff(int f=
d, cpu_set_t &mask),
> which hides the cast or use void* for the mask. The wrapper function woul=
d hide the cpu_set_t
> from the kernel by using #ifndef __KERNEL__ around it.
>=20
> Do you prefer the wrapper function?
>=20

Not a userland wrapper, as there should not be any RTDM API in userland
- that one was removed during the 2.x -> 3.x transition, preferring a
POSIXish interface to real-time I/O devices.

I was rather thinking about a kernel-space wrapper for cpu_set_t, which
maps to struct cpumask, i.e.:

diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index e70da26..73fa382 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -19,7 +19,7 @@
 #define _RTDM_UAPI_GPIO_H
  typedef struct {
-	void* mask;
+	cpu_set_t *mask;
 	size_t size;
 } rtdm_cpumask_t;
 diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index e0f0cb9..3168dfc 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -150,4 +150,6 @@ devm_hwmon_device_register_with_groups(struct device
*dev, const char *name,
 #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
 #endif /* < 3.10 */
 +typedef struct cpumask cpu_set_t;
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */

This said, every driver dealing with interrupts may also want to
implement such request locally (e.g. CAN, rtnet, uarts, SPI etc), so the
request code and the argument type should probably be made generic,
e.g. RTIOC_SET_IRQAFFINITY or whatever, defined in uapi/rtdm.h along
with rtdm_cpumask_t.

--=20
Philippe.





