From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Message-Id: <4C9E87FD-F2E3-4AFC-A843-E843EDB82753@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: RTnet on Raspberry Pi 3B+
Date: Mon, 12 Oct 2020 13:56:33 +0300
In-Reply-To: <8b1fea38-7c34-2f9f-991e-7a889e086c46@siemens.com>
References: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
 <CAFc1U0uqCWknFJj1FFMk2Ge7XEH1nRUwXek2Ay7nvmBXh03nqg@mail.gmail.com>
 <DD8FF5D6-AF88-4EAB-9E9D-3BA4B9B57CEA@gmail.com>
 <c137965c-cb45-2b9a-2795-3b1343f0e55a@qmul.ac.uk>
 <01d38a9b-da56-6877-5508-9444bff5829d@qmul.ac.uk>
 <B6F97522-9F76-4D2F-83B5-F992853C6236@gmail.com>
 <751ccaf8-b483-0e31-1620-e77447d35380@siemens.com>
 <CAMCM02vu1-WU+yZ+j-y1EqAykOPNOp6=DZRoHewbzMOka4k3oQ@mail.gmail.com>
 <8b1fea38-7c34-2f9f-991e-7a889e086c46@siemens.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Giulio Moro <g.moro@qmul.ac.uk>, xenomai <xenomai@xenomai.org>

Yes that=E2=80=99s correct. I might be not clear enough, I meant how =
could I modify the config options similar to =E2=80=9Cmake menuconfig=E2=80=
=9D

Thanks.
Deniz.

> On 12 Oct 2020, at 13:51, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
> On 12.10.20 12:46, Deniz Ugur wrote:
>> Thanks Jan. Without going more off-topic, may I ask you how would one
>> configure the config using xenomai-images?
>>=20
>=20
> If you look at the readme, it suggest to build like this e.g.:
>=20
> kas-docker --isar build kas.yml:board-qemu-amd64.yml
>=20
> To build for latest xenomai-next, you would do
>=20
> kas-docker --isar build =
kas.yml:board-qemu-amd64.yml:opt-xenomai-next.yml
>=20
> Jan
>=20
>> Thanks.
>>=20
>>=20
>> On Mon, Oct 12, 2020, 13:36 Jan Kiszka <jan.kiszka@siemens.com =
<mailto:jan.kiszka@siemens.com>
>> <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>> =
wrote:
>>=20
>>    On 12.10.20 01:18, Deniz U=C4=9Fur via Xenomai wrote:
>>> Hi Giulio,
>>>=20
>>> Thanks for your detailed response. I=E2=80=99ve checked all of the =
links
>>    you sent. They helped me a lot.
>>>=20
>>> Do you know if xenomai-images pulls master head?
>>> I believe CONFIG_XENO_DRIVERS_SPI_OMAP2_MCSPI_RT is just added on
>>    January. So I couldn=E2=80=99t be sure if it builds the kernel =
containing
>>    this commit.
>>>=20
>>=20
>>    If you append ":opt-xenomai-next.yml", Xenomai will be built from =
the
>>    next branch. By default, the last release is used.
>>=20
>>    Jan
>>=20
>>> Thank you.
>>> Deniz.
>>>=20
>>>> On 12 Oct 2020, at 01:03, Giulio Moro <g.moro@qmul.ac.uk =
<mailto:g.moro@qmul.ac.uk>
>>    <mailto:g.moro@qmul.ac.uk <mailto:g.moro@qmul.ac.uk>>> wrote:
>>>>=20
>>>> I should have mentioned that you can also build an Isar image for
>>    the BBB with Xenomai from here
>>    https://gitlab.denx.de/Xenomai/xenomai-images =
<https://gitlab.denx.de/Xenomai/xenomai-images>
>>>>=20
>>>> Giulio Moro wrote:
>>>>> You can download a working Debian image with Xenomai that runs
>>    on BB here =
https://github.com/BelaPlatform/bela-image-builder/releases =
<https://github.com/BelaPlatform/bela-image-builder/releases>
>>>>> This contains Linux 4.14.108-ti-xenomai-r135 with Xenomai 3.0.10
>>>>> The kernel is built from this branch
>>    =
https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenomai=
-4.14.y =
<https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenoma=
i-4.14.y>
>>>>> I haven't tried RTDM SPI, but there seems to be a driver for it:
>>    =
https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/spi/sp=
i-omap2-mcspi-rt.c =
<https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/spi/s=
pi-omap2-mcspi-rt.c>
>>>>> Deniz U=C4=9Fur via Xenomai wrote:
>>>>>> Hi Pierre,
>>>>>>=20
>>>>>> I=E2=80=99ve just checked out BeagleBone Black and it seems =
applicable
>>    for me. If you don=E2=80=99t mind I have some follow-up questions.
>>>>>>=20
>>>>>> Do you know if RTDM SPI works on BB?
>>>>>> Which ipipe, xenomai, and linux version combination is working
>>    on the BB right now?
>>>>>> Are there any recent guides for Xenomai 3 on BB?
>>>>>>=20
>>>>>> Thanks.
>>>>>> Deniz.
>>>>>>=20
>>>>>>> On 11 Oct 2020, at 20:39, Pierre FICHEUX
>>    <pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr> =
<mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>>> =
wrote:
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> Pi Ethernet controller is based on USB, not that good for
>>    realtime (AMHA)...
>>>>>>>=20
>>>>>>> May you could switch to BeagleBone Black ?
>>>>>>>=20
>>>>>>> regards
>>>>>>>=20
>>>>>>> Le sam. 10 oct. 2020 =C3=A0 10:21, Deniz U=C4=9Fur via Xenomai
>>    <xenomai@xenomai.org <mailto:xenomai@xenomai.org> =
<mailto:xenomai@xenomai.org <mailto:xenomai@xenomai.org>>
>>    <mailto:xenomai@xenomai.org <mailto:xenomai@xenomai.org> =
<mailto:xenomai@xenomai.org <mailto:xenomai@xenomai.org>>>> a =C3=A9crit =
:
>>>>>>> Hello all,
>>>>>>>=20
>>>>>>> I=E2=80=99m currently researching for a real-time sensor data
>>    acquisition system and I was thinking about using Raspberry Pi =
3B+.
>>    Along with my move to making everything real-time, I also want to
>>    experiment with RTnet. Although from what I can understand, =
RPi=E2=80=99s
>>    ethernet module is not supported in RTnet.
>>>>>>>=20
>>>>>>> Is RPi not supported in RTnet? If not, is there anything I can
>>    do to bring this feature?
>>>>>>> Do I have any alternative for making TCP socket connection
>>    real-time using Xenomai on RPi?
>>>>>>> Lastly, If RPi is an impossible target for RTnet, do we have
>>    any alternative embedded system that works with RTnet?
>>>>>>>=20
>>>>>>> Thanks in advance.
>>>>>>> Deniz.
>>>>>>>=20
>>>>>>> Some important details:
>>>>>>> ARCH: ARM
>>>>>>> SoC: BCM2835
>>>>>>> Linux: 4.14.36
>>>>>>> Xenomai: 3.0.7
>>>>>>> I-Pipe: 4.14.36-arm-1
>>>>>>>=20
>>>>>>>=20
>>>>>>> --
>>>>>>> Pierre FICHEUX -/- CTO Smile ECS, France -\-
>>    pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr> =
<mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>>
>>    <mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr> =
<mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>>>
>>>>>>>                                http://www.smile.fr/ =
<http://www.smile.fr/>
>>    <http://www.smile.fr/ <http://www.smile.fr/>>
>>>>>>>                             =20
>>     https://smile.eu/fr/offres/embarque-iot =
<https://smile.eu/fr/offres/embarque-iot>
>>    <https://smile.eu/fr/offres/embarque-iot =
<https://smile.eu/fr/offres/embarque-iot>>
>>>>>>> I would love to change the world, but they won't give me the
>>    source code
>>>>>>=20
>>>=20
>>=20
>>    --=20
>>    Siemens AG, T RDA IOT
>>    Corporate Competence Center Embedded Linux
>>=20
>=20
>=20
> --=20
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

