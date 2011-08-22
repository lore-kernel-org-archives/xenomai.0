Message-ID: <4E524D35.2090002@domain.hid>
Date: Mon, 22 Aug 2011 14:36:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>	<4E4E29DB.3070904@domain.hid>	<CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>	<CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>	<4E4FFD02.2060002@domain.hid>	<CAHoMn5qut=4yTNxnEYXK4MR3R=dArayBP3QXVOsMkDVPX83vpQ@mail.gmail.com>	<4E523330.6070205@domain.hid>
	<CAHoMn5q4gk+FMjWDx75c8rsRa7dxUvLM5OxqkBJVgSFr3pQRHA@mail.gmail.com>
In-Reply-To: <CAHoMn5q4gk+FMjWDx75c8rsRa7dxUvLM5OxqkBJVgSFr3pQRHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Fwd: building xenomai for AT91SAM9263
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yi zheng <yizheng23@domain.hid>
Cc: xenomai@xenomai.org

On 08/22/2011 02:09 PM, yi zheng wrote:
>>
>>
>>>>>
>>>>>
>>>>>>>>>> Hi,all
>>>>>>>>>>       i am a newer to xenomai.Now i want to build xenomai for =
my
>>>>> target
>>>>>>>>>> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I=
 use
>>>>>>>>>> arm-linux-gcc 3.4.1 for compiler,
>>>>>>>>>> is it suitable for build
>>>>>>>>>> xenomai=EF=BC=9Fwhich xenomai vision is better for me?
>>>>>>>>>
>>>>>>>>>> Xenomai 2.5.6 is the latest stable release, it should work. Bu=
t
>> I-pipe
>>>>>>>>>> patches for later linux kernel releases have support for FCSE,=

>> which
>>>>>>>>>> greatly improves latencies. As for the version of gcc, I have =
only
>>>>> been
>>>>>>>>> using gcc 4 for a long time.
>>>>>>>>
>>>>>>>> --
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>                                             Gilles.
>>>>>>>>
>>>>>>>      Hi Gilles
>>>>>>>            thank you for your kindly replying.I have used
>> linux-2.6.25
>>>>>>> and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai
>>>>>
>>>>>> If you have no special reason for using such old versions, you sho=
uld
>>>>>> probably use the latest releases.
>>>>
>>>>      Actually,I want to use RTnet-0.9.12 for my target platform.The
>> network
>>>> card driver contained in RTnet-0.9.12 comes from linux kernel
>> vision2.6.25.I
>>>> prepare to use the same kernel vision as the author who ported stand=
ard
>>>> linux network card driver to RTnet.
>>
>>> As I already told you, you can use Xenomai 2.5.6 with linux 2.6.25, s=
o,
>>> that is not a good reason.
>>
>    I have used  Xenomai 2.5.6 with linux 2.6.25,but i got errors when
> compiled linux kernel. compilation process is described  as follows.
>    1)patch linux kernel with 2.6.25-at91.patch.
>    2)[root@domain.hid xenomai-2.5.6]# pwd
> /usr/src/xenomai/xenomai-2.5.6
> [root@domain.hid xenomai-2.5.6]# scripts/prepare-kernel.sh --arch=3Darm=

> --adeos=3Dksrc/arch/arm/patches/adeos-ipipe-2.6.25-arm-1.9-02.patch
> --linux=3D/usr/src/xenomai/linux-2.6.25
>    3)configure linux kernel.
>    4)[root@domain.hid linux-2.6.25]# make uImage
>  and  I got=EF=BC=9A
>  In file included from include/asm/xenomai/system.h:29,
>                  from include/xenomai/nucleus/types.h:41,
>                  from include/xenomai/nucleus/queue.h:24,
>                  from include/xenomai/nucleus/heap.h:25,
>                  from kernel/xenomai/nucleus/bufd.c:144:
> include/asm-generic/xenomai/system.h:452: error: parse error before
> "phys_addr_t"

Ok. That is because phys_addr_t is only defined by linux 2.6.27 and
later. You just have to add a typedef for phys_addr_t, but you are
right, we have not tested with old linux releases for some time, and it
finally broke.

>>> Now, the natural question is: do you get the same problems with xenom=
ai
>>> 2.5.6? Because if you do not get them with xenomai 2.5.6, it means th=
at
>>> you hit a bug that was already solved. As long as you persist in usin=
g
>>> outdated versions, nobody will lift a finger to try and debug issues
>>> that may have already been fixed in later releases.
>>
>    As previously mentioned I have tried Xenomai 2.5.6 with failure=EF=BC=
=8Cso I
> thought linux kernel vision and Xenomai vision must match wrong.I
> have neither used Xenomai and RTnet before.Now i only want to insure Xe=
nomai
> and RTnet can  run smoothly with the minimum effort.

If you want to run xenomai and rtnet with the minimum effort, you should
use the latest releases. xenomai 2.5.6, with the latest patch for ARM it
contains, with rtnet 0.9.12. If that does not work, you can ask
questions here, you will get support.

There should not be any reason why an rtnet driver would be written for
a specific linux kernel version.

--=20
					    Gilles.


