MIME-Version: 1.0
Date: Wed, 18 Aug 2010 14:37:32 +0200
Message-ID: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>
From: marc doz <doz.marc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] kernel compilation problem with a Cortex A8,
	AM3517 EVM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I try to compile a kernel (2.6.32 patched with
adeos-ipipe-2.6.33-arm-1.17-02.patch	) with xenomai.
The target is AM3517 Evaluation Module. It runs correctly without
xenomai and the compilation proccess sucess with only adeos patch

this is my current method :

1)with xenomail :
./scripts/prepare-kernel.sh
--linux=/home/marc/sdk/AM35x-OMAP35x-PSP-SDK/src/kernel/linux-03.00.00.05_xenomai
 --arch=arm
2)in the kernel directory :
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- menuconfig
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-

These errors occur :
arch/arm/xenomai/built-in.o: In function `rthal_irq_host_release':
/home/marc/sdk/AM35x-OMAP35x-PSP-SDK/src/kernel/linux-03.00.00.05_xenomai/arch/arm/xenomai/hal.c:193:
undefined reference to `__bad_lock_type'
arch/arm/xenomai/built-in.o: In function `rthal_irq_host_request':
/home/marc/sdk/AM35x-OMAP35x-PSP-SDK/src/kernel/linux-03.00.00.05_xenomai/arch/arm/xenomai/hal.c:172:
undefined reference to `__bad_lock_type'

the test is done with  xenomai-2.5.0 and  xenomai-2.5.4
the toolchain is a codeSourcery toolchain : arm-none-linux-gnueabi-gcc
(Sourcery G++ 4.3-234) 4.3.3

have you a suggestion ? can you suggest me a kernel version and a
xenomai version ?

regards,
marc

