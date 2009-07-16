MIME-Version: 1.0
In-Reply-To: <4A5CC870.3030208@domain.hid>
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>
	<4A5CC870.3030208@domain.hid>
Date: Thu, 16 Jul 2009 09:58:27 +0200
Message-ID: <b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
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

The Xenomai applications (cyclictest, latency) result in a hangup of the sy=
stem.

I did a complete rebuild of the openembedded Angstrom console-image
distribution, compiled this time with the CodeSourcery 2007q3
cross-compile environment. This is a gcc 4.2.1 version. But has the
same hangup behaviour as the default 4.3.3 version.

I build the xenomai userspace with:
./configure --build=3Di686-pc-linux-gnu
--host=3Darm-angstrom-linux-gnueabi --enable-arm-mach=3Dat91sam926x
--enable-arm-eabi

Any help is appreciated.

Thanks, Henri


On Tue, Jul 14, 2009 at 8:03 PM, Gilles
Chanteperdrix<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> Hi all,
>>
>> I have a problem with running apps that are linked with the xenomai
>> userspace libraries. At the startup of the apps, when loading these
>> libraries the result is a segmentation fault.
>>
>> I am using Xenomai version 2.4.8, but also tried the previous 2.4.7.
>> The ARM platform is basically the same as the at91sam9263ek board. The
>> Linux distribution is build with the OpenEmbedded (x11-image,
>> Angstrom) cross-compile environment, 2.6.28 kernel.
>>
>> Note: I have been able to run a kernel RTDM driver with success.
>>
>> While debugging I have been able to trace untill the
>> XENOMAI_DO_SYSCALL() in ./src/include/asm/xenomai
>
> Do the Xenomai applications run?
> Are you using gcc 4.3, if yes, switch to gcc 4.2, gcc 4.3 has a bug that
> we can not workaround.
> Have you built the kernel and xenomai user-space with compatible
> settings with regard to EABI?
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

