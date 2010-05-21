MIME-Version: 1.0
In-Reply-To: <4BF50C56.5040307@domain.hid>
References: <AANLkTil5O99TYi2HF9QsN2kz8em4pFiJXTAmteBoee1Z@mail.gmail.com>
	<4BF50C56.5040307@domain.hid>
Date: Fri, 21 May 2010 11:58:03 +0800
Message-ID: <AANLkTikSzbCnuC3Y2eki4pAPaQH2mzAD_l_90W1Twnc-@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to compile xenomai examples?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks for your kind reply. If I do that, the result is similar:

cd /examples/rtdm/profiles/serial
make XENO=3D/media/Angstrom/usr/xenomai ARCH=3Darm
KSRC=3D/home/everett/tmp/xenomai-2.5.3/ksrc
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead
--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead
arm-none-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   -L/usr/xenomai/lib -lxenomai
-lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker /usr/xenomai/lib
cross-link.c   -o cross-link
In file included from /usr/xenomai/include/nucleus/thread.h:25,
                 from /usr/xenomai/include/nucleus/sched.h:31,
                 from /usr/xenomai/include/native/task.h:25,
                 from cross-link.c:28:
/usr/xenomai/include/nucleus/types.h:40: fatal error:
asm/xenomai/system.h: No such file or directory
compilation terminated.
make: *** [cross-link] Error 1

I have checked that /media/Angstrom/usr/xenomai has files installed:
everett@domain.hid$ ls
bin  include  lib  sbin  share

and

cd /home/everett/tmp/xenomai-2.5.3/ksrc/
everett@domain.hid$ ls
arch  Config.in  drivers  Makefile  nucleus  skins
everett@domain.hid$

I can only see a system.h in this directory

/usr/xenomai/include/asm-arm/system.h

Is this the right file that compiler is looking for?

Best regards,

Everett




On Thu, May 20, 2010 at 6:17 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> Hi All,
>>
>> I am still new to learn to use xenomai. I have managed to compile and
>> install xenomai to
>> my beagleboard. It seems that the installation is OK since I can run
>> the kernel/latency test
>> fine. But I am still struggling to compile the examples comes with the x=
enomai.
>>
>> Here is hardware and software setup:
>>
>> Host: PC with Ubuntu 10.04, with code sourcery's cross compiler to
>> 2010q1 installed. I followed
>> the README.INSTALL from the xenomai 2.5.3 for arm installation. And my
>> new kernel is
>> 2.6.33.3
>>
>> This is the procedure I used for install xenomai
>>
>> 1) patch my linux kernel:
>> ./scripts/prepare-kernel.sh --arch=3Darm
>> --adeos=3D/usr/xenomai/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-arm-*
>> --linux=3D/usr/src/linux
>>
>> 2) =A0Config the kernel
>> make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- omap3_beagle_def=
config
>> make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- menuconfig
>>
>> 3) Compile and install the kernel and modules
>> make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- uImage modules
>> then copied resulted uImage into my SD boot, copied my lib/modules/2.6.3=
3.3
>>
>> 4) Configure xenomai
>> ./configure --build=3Di686-pc-linux-gnu --host=3Darm-none-linux-gnueabi
>> --enable-arm-mach=3Domap3 --enable-arm-tsc
>>
>> 5) Compile and install xenomai to my SD
>> make DESTDIR=3D/media/Angstrom install
>>
>> Upon reboot to the new kernel using beagleboard, I can run
>> testsuit/kernel/latency/ fine
>>
>> The problem happens when I try to compile the examples in xenomai. i
>> issued this:
>>
>> cd xenomai-2.5.3/examples/rtdm/profiles/serial
>> make XENO=3D/media/Angstrom/usr/xenomai/bin ARCH=3Darm
>> KSRC=3D/home/everett/BB/xenomai-2.5.3/ksrc
>
> I guess it should be XENO=3D/media/Angstrom/usr/xenomai
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

