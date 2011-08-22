Message-ID: <4E523330.6070205@domain.hid>
Date: Mon, 22 Aug 2011 12:45:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>	<4E4E29DB.3070904@domain.hid>	<CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>	<CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>	<4E4FFD02.2060002@domain.hid>
	<CAHoMn5qut=4yTNxnEYXK4MR3R=dArayBP3QXVOsMkDVPX83vpQ@mail.gmail.com>
In-Reply-To: <CAHoMn5qut=4yTNxnEYXK4MR3R=dArayBP3QXVOsMkDVPX83vpQ@mail.gmail.com>
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

On 08/22/2011 10:55 AM, yi zheng wrote:
>>
>>
>>>>>>> Hi,all
>>>>>>>       i am a newer to xenomai.Now i want to build xenomai for my
>> target
>>>>>>> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I us=
e
>>>>>>> arm-linux-gcc 3.4.1 for compiler,
>>>>>>> is it suitable for build
>>>>>>> xenomai=EF=BC=9Fwhich xenomai vision is better for me?
>>>>>
>>>>>> Xenomai 2.5.6 is the latest stable release, it should work. But I-=
pipe
>>>>>> patches for later linux kernel releases have support for FCSE, whi=
ch
>>>>>> greatly improves latencies. As for the version of gcc, I have only=

>> been
>>>>>> using gcc 4 for a long time.
>>>>>
>>>>> --
>>>>>
>>>>
>>>>
>>>>
>>>>>                                             Gilles.
>>>>>
>>>>      Hi Gilles
>>>>            thank you for your kindly replying.I have used linux-2.6.=
25
>>>> and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai
>>
>>> If you have no special reason for using such old versions, you should=

>>> probably use the latest releases.
>=20
>      Actually,I want to use RTnet-0.9.12 for my target platform.The net=
work
> card driver contained in RTnet-0.9.12 comes from linux kernel vision2.6=
=2E25.I
> prepare to use the same kernel vision as the author who ported standard=

> linux network card driver to RTnet.

As I already told you, you can use Xenomai 2.5.6 with linux 2.6.25, so,
that is not a good reason.

> ---|------------|------------|------------|--------|-------------------=
------
> RTS|      20.975|      50.453|      86.167|       0|    00:00:11/00:01:=
00
>=20
> I think my Xenomai environment built successfully.And I want to do more=

> performance test on Xenomai,is there any other existing test program i =
can
> use?

The usual way to assess the latencies of your system is with the
"latency" test, but running it several hours with the machine under
load. latency results, when run 11seconds on an idle machine are
meaningless.

>=20
> With above-mentioned linux and Xenomai I compiled RTnet0.9.12.There see=
ms
> something wrong with RTnet.
>  [@NewMsg9263: modules]# insmod rt_macb.ko
> RTnet: registered rteth0
> MACB_mii_bus: probed
> rteth0: Atmel MACB at 0xfffbc000 irq 21 (12:34:56:78:90:12)
> rteth0: attached PHY driver [Davicom DM9161A] (mii_bus:phy_addr=3Dfffff=
fff:00,
> irq=3D-1)
> [@NewMsg9263: modules]# lsmod
> rt_macb 8164 0 - Live 0xbf014000
> rt_loopback 2404 0 - Live 0xbf012000
> rtipv4 25484 0 - Live 0xbf00a000
> rtnet 33360 3 rt_macb,rt_loopback,rtipv4, Live 0xbf000000
> [@NewMsg9263: sbin]# ./rtifconfig rteth0 up
> [@NewMsg9263: sbin]# rteth0: link up (100/Full)
> RTnet: host 192.168.0.255 unreachable
> RTnet: unable to forward packet from 192.168.0.8
> RTnet: host 255.255.255.255 unreachable
> RTnet: unable to forward packet from 192.168.0.100
> RTnet: host 192.168.0.255 unreachable
> RTnet: unable to forward packet from 192.168.0.122
> RTnet: host 255.255.255.255 unreachable
> RTnet: unable to forward packet from 192.168.0.100
> I know this is Xenomai maillist=EF=BC=8Cbut if you know where is my pro=
blem.Please
> tell me.

Now, the natural question is: do you get the same problems with xenomai
2.5.6? Because if you do not get them with xenomai 2.5.6, it means that
you hit a bug that was already solved. As long as you persist in using
outdated versions, nobody will lift a finger to try and debug issues
that may have already been fixed in later releases.

--=20
                                                                Gilles.


