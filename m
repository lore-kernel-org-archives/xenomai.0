MIME-Version: 1.0
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Tue, 1 Nov 2011 10:55:43 +0100
Message-ID: <CAAeYjM=YwjH0SsVDLaxt0v1HzzR5rM5N1pZW0K+yHq7KDeg9PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] patching a kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'having problems with patching the 2.6.38.8 kernel.
I prepare my kernel first to work on my device (mini2440). I configure
it to use arm processor, etc.
Then I patch from xenomai:

scripts/prepare-kernel.sh --arch=3Darm
--adeos=3Dksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.patch
--linux=3D../linux-2.6.38.8

Now when I enter the ../linux-2.6.38.8 and run make xconfig (or
menuconfig) I don't even see my processor there - it's set to Pentium
PRO.

What should I do now?

regards,
--
=C5=81ukasz Dragilla Sacha

