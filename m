Message-ID: <50644142.3040107@xenomai.org>
Date: Thu, 27 Sep 2012 14:06:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <25260467.3976688.1348740316127.JavaMail.root@zmail.sgconsulting.it>
In-Reply-To: <25260467.3976688.1348740316127.JavaMail.root@zmail.sgconsulting.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 -
 Kernel compilation fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Forconi <forconi@wavecomm.it>
Cc: xenomai@xenomai.org

On 09/27/2012 12:05 PM, Forconi wrote:
> Hi, this is my first approach to Xenomai, I'm trying to compile a
> Xenomai patched Linux kernel to run on a AT91SAM9260 embedded board.
> 
> This is my environment: CROSS-GCC: gcc-4.2.3-glibc-2.3.3 KERNEL:
> Linux 2.6.38.8 XENOMAI: Xenomai-2.6.1
> 
> I'm following the "Installation instructions" on web site (section
> 3.4. Building for ARM).
> 
> The prepare-kernel.sh script runs ok, all files are patched with no
> errors, this is the command I've used: 
> $xenomai_root/scripts/prepare-kernel.sh --arch=arm
> --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-08.patch
> --linux=$linux_tree
> 
> Then I configure/build the kernel: make ARCH=arm
> CROSS_COMPILE=arm-unknown-linux-gnu- at91sam9260ek_defconfig make
> ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnu- uImage
> 
> But compilation fails: ... AS      arch/arm/nwfpe/entry.o LD
> arch/arm/nwfpe/nwfpe.o LD      arch/arm/nwfpe/built-in.o CC
> arch/arm/kernel/elf.o AS      arch/arm/kernel/entry-armv.o AS
> arch/arm/kernel/entry-common.o arch/arm/kernel/entry-common.S:
> Assembler messages: arch/arm/kernel/entry-common.S:449: Error: bad
> instruction `ldm sp,{r0-r3}' make[1]: ***
> [arch/arm/kernel/entry-common.o] Error 1 make: *** [arch/arm/kernel]
> Error 2
> 
> 
> Maybe I have to try with other versions of xenomai and kernel?

No, the problem is the toolchain. Are you sure AS is $(CROSS_COMPILE)as
and not the build system as ?


-- 
					    Gilles.

