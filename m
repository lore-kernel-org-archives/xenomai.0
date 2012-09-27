Date: Thu, 27 Sep 2012 10:05:16 +0000 (UTC)
From: Forconi <forconi@wavecomm.it>
Message-ID: <25260467.3976688.1348740316127.JavaMail.root@zmail.sgconsulting.it>
In-Reply-To: <1942547306.3976213.1348739521182.JavaMail.root@zmail.sgconsulting.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 - Kernel
 compilation fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, 
this is my first approach to Xenomai, I'm trying to compile a Xenomai patched Linux kernel to run on a AT91SAM9260 embedded board.

This is my environment:
CROSS-GCC: gcc-4.2.3-glibc-2.3.3
KERNEL: Linux 2.6.38.8
XENOMAI: Xenomai-2.6.1

I'm following the "Installation instructions" on web site (section 3.4. Building for ARM).

The prepare-kernel.sh script runs ok, all files are patched with no errors, this is the command I've used:
$xenomai_root/scripts/prepare-kernel.sh --arch=arm --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-08.patch --linux=$linux_tree

Then I configure/build the kernel:
make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnu- at91sam9260ek_defconfig
make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnu- uImage

But compilation fails:
...
AS      arch/arm/nwfpe/entry.o
LD      arch/arm/nwfpe/nwfpe.o
LD      arch/arm/nwfpe/built-in.o
CC      arch/arm/kernel/elf.o
AS      arch/arm/kernel/entry-armv.o
AS      arch/arm/kernel/entry-common.o
arch/arm/kernel/entry-common.S: Assembler messages:
arch/arm/kernel/entry-common.S:449: Error: bad instruction `ldm sp,{r0-r3}'
make[1]: *** [arch/arm/kernel/entry-common.o] Error 1
make: *** [arch/arm/kernel] Error 2


Maybe I have to try with other versions of xenomai and kernel?

