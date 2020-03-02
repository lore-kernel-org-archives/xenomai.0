Subject: Re: Xenomai RTnet - Kernel module not loading
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
 <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
 <cb174dde-7680-ba74-9aca-7da7adc870dc@b-tu.de>
 <984885226.450915.1582641841732.JavaMail.zimbra@wolfram.com>
 <1987057484.452222.1582642123490.JavaMail.zimbra@wolfram.com>
 <6a5fc541-8519-56d0-f4b4-c7e29f4b38f3@b-tu.de>
 <1253430772.456171.1582643215737.JavaMail.zimbra@wolfram.com>
 <d6b19aa8-c978-617c-bb85-335634e47ac1@b-tu.de>
 <1294487288.461675.1582644685411.JavaMail.zimbra@wolfram.com>
 <cbce49c7-0cca-73de-bc4f-bb4efd29b7d7@b-tu.de>
 <CALLqZ8R3rKRUyvqyVcG18ovxVTniU6SiCGRi0_nKQ0z4kp1QSA@mail.gmail.com>
 <64403b82-a520-35c7-f406-d3de98cb453d@b-tu.de>
 <c53a8199-fc7a-c899-ecaa-a9e64f5428dd@siemens.com>
From: Benji <miethben@b-tu.de>
Message-ID: <0da72ece-b789-291d-62e7-5eeae0cf8903@b-tu.de>
Date: Mon, 2 Mar 2020 15:49:42 +0100
MIME-Version: 1.0
In-Reply-To: <c53a8199-fc7a-c899-ecaa-a9e64f5428dd@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

non of troubleshooting in the wiki fixed the problem with error -19.
Today i get access to a system with Intel Xeon CPU and compiled the
kernel with same configuration.

It looks like the system is starting Xenomai without any error:

> $ dmesg | grep Xenomai
> [    5.114787] [Xenomai] scheduling class idle registered.
> [    5.114878] [Xenomai] scheduling class rt registered.
> [    5.114984] [Xenomai] disabling automatic C1E state promotion on Int=
el processor
> [    5.115112] [Xenomai] SMI-enabled chipset found, but SMI workaround =
disabled
> [    5.115336] I-pipe: head domain Xenomai registered.
> [    5.115968] [Xenomai] Cobalt v3.1 [DEBUG]
>                *** RTnet for Xenomai v3.1 ***


First system i try to get Xenomai working had a Intel Core i7-8550U
working in Thinkpad X1 Carbon.

Is Intel Xeon and Core-i CPUs that different that Xenomai is unable to lo=
ad?

On 2/27/20 7:55 PM, Jan Kiszka wrote:
> On 27.02.20 19:51, Benji via Xenomai wrote:
>> On 2/27/20 4:51 PM, Greg Gallagher wrote:
>>>>>> I thought system is running on cobalt kernel. But looks like there
>>>>>> is an
>>>>>> initialisation error. What is meaning of error code -19?
>>>>>
>>>>>>> $ dmesg | grep Xenomai
>>>>>>> [ 8.543295] [Xenomai] scheduling class idle registered.
>>>>>>> [ 8.543302] [Xenomai] scheduling class rt registered.
>>>>>>> [ 8.543333] [Xenomai] init failed, code -19
>>>>>
>>>>> I haven't seen that one myself. But check out:
>>>>>
>>>>> https://xenomai.org/pipermail/xenomai/2015-September/thread.html#35=
066
>>>>>
>>>>> and
>>>>>
>>>>> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#no-t=
imer
>>>>>
>>>>>
>>>>> (Although i see the in-page link is broken check the section about
>>>>> timers)
>>>>>
>>>>>
>>>>> Per =C3=96berg
>>>>>
>>>> Hi,
>>>>
>>>> the hint was in the right direction. There is something strange in m=
y
>>>> build process. In kernel configuration i disable options described i=
n
>>>> Xenomai Wiki (like CPU_FREQ, KGDB..). After running 'make bzImage
>>>> modules' and checking .config file, disabled option are enabled agai=
n.
>>>>
>>>> Are there dependencies to force enable these option without notice?
>>>>
>>>> Thanks
>>>> Benji
>>>>
>>> Did you use menuconfig? I use menuconfig to disable those options and
>>> it makes it very clear if there are other options that need to be
>>> disabled as well.
>>>
>>> -Greg
>>>
>>
>> I use menuconfig. But some options can't be disabled like CPU_FREQ or
>> page migration. You're right there are warning about enabled options b=
ut
>> as i said they can't be disable. So i edit .config file manually to me=
et
>> requirement from Xenomai wiki.
>>
>> Can somebody provide me a working configuration for x86_64 architectur=
e?
>>
>=20
> See https://gitlab.denx.de/Xenomai/xenomai-images for a working image
> and
> https://gitlab.denx.de/Xenomai/xenomai-images/blob/master/recipes-kerne=
l/linux/files/amd64_defconfig
> for a working config.
>=20
> Jan
>=20

Thanks
Benji

