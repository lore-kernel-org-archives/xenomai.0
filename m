Message-ID: <4EAFC7DB.1070400@domain.hid>
Date: Tue, 01 Nov 2011 11:20:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjM=YwjH0SsVDLaxt0v1HzzR5rM5N1pZW0K+yHq7KDeg9PA@mail.gmail.com>
In-Reply-To: <CAAeYjM=YwjH0SsVDLaxt0v1HzzR5rM5N1pZW0K+yHq7KDeg9PA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
To: xenomai@xenomai.org

On 11/01/2011 10:55 AM, Łukasz Sacha wrote:
> Hi,
>
> I'having problems with patching the 2.6.38.8 kernel.
> I prepare my kernel first to work on my device (mini2440). I configure
> it to use arm processor, etc.
> Then I patch from xenomai:
>
> scripts/prepare-kernel.sh --arch=arm
> --adeos=ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-03.patch
> --linux=../linux-2.6.38.8
>
> Now when I enter the ../linux-2.6.38.8 and run make xconfig (or
> menuconfig) I don't even see my processor there - it's set to Pentium
> PRO.
>
> What should I do now?

Check the README.INSTALL file, section 2.4, Building for ARM.

$ make ARCH=arm xconfig
        ^^^^^^^^

Your .config file for your 2440 board is probably broken by now if you 
saved your previous configuration attempt (i.e. switched to x86 
settings). You may want to check this as well.

>
> regards,
> --
> Łukasz Dragilla Sacha
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

