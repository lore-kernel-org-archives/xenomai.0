Message-ID: <5163C4E7.8080007@xenomai.org>
Date: Tue, 09 Apr 2013 09:36:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51613CE2.6010900@wanadoo.fr>
	<51618B70.7070809@xenomai.org>	<5161CE7B.1040404@wanadoo.fr>
	<5162711E.7080505@xenomai.org> <51627A31.80801@xenomai.org>
	<516316C0.7000400@wanadoo.fr> <51632EC4.7000108@xenomai.org>
	<5163B4E6.6040507@wanadoo.fr>
In-Reply-To: <5163B4E6.6040507@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Kernel 3.5.7 not booting in qemu for vexpress-a9 with
 xenomai-2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 04/09/2013 08:27 AM, Thierry Bultel wrote:

> Le 08/04/2013 22:55, Gilles Chanteperdrix a =C3=A9crit :
>> On 04/08/2013 09:13 PM, Thierry Bultel wrote:
>>
>>> Le 08/04/2013 10:05, Gilles Chanteperdrix a =C3=A9crit :
>>>> On 04/08/2013 09:26 AM, Gilles Chanteperdrix wrote:
>>>>
>>>>> On 04/07/2013 09:52 PM, Thierry Bultel wrote:
>>>>>
>>>>>> Le 07/04/2013 17:06, Gilles Chanteperdrix a =C3=A9crit :
>>>>>>> On 04/07/2013 11:31 AM, Thierry Bultel wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I am using a vanilla 3.5.7 kernel in qemu-1.4.0
>>>>>>>> The base defconfig is the vexpress.
>>>>>>>>
>>>>>>>> I want to use xenomai-2.6.2.1 with it.
>>>>>>>>
>>>>>>>> The non-patched kernel boots fine, the patched one doesnot, ther=
e is
>>>>>>>> nothing on the console,
>>>>>>>> the boot logo does not comeand Qemu then takes 100% CPU.
>>>>>>>>
>>>>>>>> Here is my command line
>>>>>>>> ./qemu-1.4.0/arm-softmmu/qemu-system-arm -M vexpress-a9 -kernel
>>>>>>>> ./Buildroot/output.linaro.vexpress-a9/build/linux-3.5.7/arch/arm=
/boot/uImage
>>>>>>>> -append "console=3DttyAMA0" -m 1024M -serial stdio
>>>>>>>>
>>>>>>>> Any ideas ? May I have missed something ?
>>>>>>>
>>>>>>>
>>>>>>> Well, vexpress is not in the list of machines supported by Xenoma=
i. So,
>>>>>>> someone needs to port the I-pipe kernel to it.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hi Gilles,
>>>>>>
>>>>>> We already talked about the vexpress, it was at the beginning of t=
he
>>>>>> rtcan discussion.
>>>>>> It used to work (and pretty well), my configuration was:
>>>>>>
>>>>>> linux-3.2.21+ipipe-core-3.2.21-arm-1.patch
>>>>>>
>>>>>> and I have just successfully tested
>>>>>>
>>>>>> linux-3.2.21+ipipe-core-3.2.21-arm-4.patch
>>>>>> as well.
>>>>>>
>>>>>> There is likely not much missing for having it working on the 3.5.=
7
>>>>>> kernel. I am taking a look.
>>>>>
>>>>>
>>>>> Someone did the port of the I-pipe patch to vexpress (but did not
>>>>> contribute it), the difference between vexpress and other cortex A9=

>>>>> based SOCs is that it does not support global timers, the one used =
by
>>>>> the I-pipe patch as clocksource. The difference between 3.2 and lat=
er
>>>>> patches is probably that later patches unconditionally use the glob=
al
>>>>> timer. The fix around this is to add code do detect the cortex a9
>>>>> revision and do not register the global timers when the revision is=
 too old.
>>>>>
>>>>
>>>>
>>>> Found the mail: "I just got a reply from ARM support and obviously I=

>>>> missed the thing that my release of Cortex-A9 does NOT have a global=

>>>> timer (they added it from r1p0, mine is r0p1)."
>>>>
>>>> You know what version your processor is by reading the first few lin=
es
>>>> printed by the kernel:
>>>> CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=3D10c53c7d
>>>>
>>>> 41 is used by all cores from ARM
>>>> fc09 represents the cortex a9
>>>>
>>>> The remaining 1 and 2 mean that this cortex a9 is an r1p2
>>>>
>>>
>>>
>>> Many thanks,
>>> I confirm that this fix makes vexpress boot in qemu:
>>
>>
>> Merged thanks. I believe you should keep the calculation of
>> twd_timer_rate, otherwise the twd timers will not be calibratd
>> correctly. The following:
>>
>> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3D9a776ad3c=
41fa1aef1b60d0cce5de3ca9dece42d;hp=3D82b6948fed3581e65bcce64b91b161406862=
63a7
>>
>> Works for me.
>>
>>
>=20
> It works on what platform ? It does not in qemu. The boot hangs the sam=
e=20
> way.


It works on omap4, a platform with global timers... So, what you are
saying is that it is in fact the twd calibration which hangs?

--=20
                                                                Gilles.


