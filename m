MIME-Version: 1.0
In-Reply-To: <4EAFC7DB.1070400@domain.hid>
References: <CAAeYjM=YwjH0SsVDLaxt0v1HzzR5rM5N1pZW0K+yHq7KDeg9PA@mail.gmail.com>
	<4EAFC7DB.1070400@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Tue, 1 Nov 2011 11:25:13 +0100
Message-ID: <CAAeYjMn-3iCucDRtHaOPNK2ijuq0LVFptqsKzKm85jc697Hv1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] patching a kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Nov 1, 2011 at 11:20, Philippe Gerum <rpm@xenomai.org> wrote:
> On 11/01/2011 10:55 AM, =C5=81ukasz Sacha wrote:
>>
>> Hi,
>>
>> I'having problems with patching the 2.6.38.8 kernel.
>> I prepare my kernel first to work on my device (mini2440). I configure
>> it to use arm processor, etc.
>> Then I patch from xenomai:
>>
>> scripts/prepare-kernel.sh --arch=3Darm
>> --adeos=3Dksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.patch
>> --linux=3D../linux-2.6.38.8
>>
>> Now when I enter the ../linux-2.6.38.8 and run make xconfig (or
>> menuconfig) I don't even see my processor there - it's set to Pentium
>> PRO.
>>
>> What should I do now?
>
> Check the README.INSTALL file, section 2.4, Building for ARM.
>
> $ make ARCH=3Darm xconfig
> =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^
>
> Your .config file for your 2440 board is probably broken by now if you sa=
ved
> your previous configuration attempt (i.e. switched to x86 settings). You =
may
> want to check this as well.

I didn't get to the make part yet. The situation I describe is after
prepare-kernel.sh.
And i'm using README.INSTALL of course. the line in 2.4 for
prepare-kernel.sh is:
$ $xenomai_root/scripts/prepare-kernel.sh --arch=3Darm \
  --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \
  --linux=3D$linux_tree

small "--arch=3Darm"

--=20
LS

