Message-ID: <4BF50C56.5040307@domain.hid>
Date: Thu, 20 May 2010 12:17:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTil5O99TYi2HF9QsN2kz8em4pFiJXTAmteBoee1Z@mail.gmail.com>
In-Reply-To: <AANLkTil5O99TYi2HF9QsN2kz8em4pFiJXTAmteBoee1Z@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> Hi All,
> 
> I am still new to learn to use xenomai. I have managed to compile and
> install xenomai to
> my beagleboard. It seems that the installation is OK since I can run
> the kernel/latency test
> fine. But I am still struggling to compile the examples comes with the xenomai.
> 
> Here is hardware and software setup:
> 
> Host: PC with Ubuntu 10.04, with code sourcery's cross compiler to
> 2010q1 installed. I followed
> the README.INSTALL from the xenomai 2.5.3 for arm installation. And my
> new kernel is
> 2.6.33.3
> 
> This is the procedure I used for install xenomai
> 
> 1) patch my linux kernel:
> ./scripts/prepare-kernel.sh --arch=arm
> --adeos=/usr/xenomai/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-arm-*
> --linux=/usr/src/linux
> 
> 2)  Config the kernel
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- omap3_beagle_defconfig
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- menuconfig
> 
> 3) Compile and install the kernel and modules
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- uImage modules
> then copied resulted uImage into my SD boot, copied my lib/modules/2.6.33.3
> 
> 4) Configure xenomai
> ./configure --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi
> --enable-arm-mach=omap3 --enable-arm-tsc
> 
> 5) Compile and install xenomai to my SD
> make DESTDIR=/media/Angstrom install
> 
> Upon reboot to the new kernel using beagleboard, I can run
> testsuit/kernel/latency/ fine
> 
> The problem happens when I try to compile the examples in xenomai. i
> issued this:
> 
> cd xenomai-2.5.3/examples/rtdm/profiles/serial
> make XENO=/media/Angstrom/usr/xenomai/bin ARCH=arm
> KSRC=/home/everett/BB/xenomai-2.5.3/ksrc

I guess it should be XENO=/media/Angstrom/usr/xenomai

-- 
					    Gilles.

