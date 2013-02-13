MIME-Version: 1.0
Date: Tue, 12 Feb 2013 22:08:45 -0600
Message-ID: <CAPeEhaoS1dLW0VfiGVVsyEcGokO8zDNP-yg_2SFMRxzXD5a6Rw@mail.gmail.com>
From: uMinded Strikes Again <iceblu3710@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Porting IPIPE to SUN5I (Allwinner A13)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to port IPIPE to my allwinner A13 board but do not know where
to exactly start on this... I know what needs to be done but not how to do
it.

Sofar:$
cd xenomai-2.6.2.1
$ ./scripts/prepare-kernel.sh --arch=arm \

--adeos=./ksrc/arch/arm/patches/adeos-ipipe-3.0.36-arm-1.18-11.patch.fixed \
  --linux=../linux-sunxi-sunxi-v3.0.36-r1
$ cd ../linux-sunxi-sunxi-v3.0.36-r1
$ make ARCH=arm a13_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage

edit ./sunxi-xenomai/arch/arm/include/asm/xenomai/hal.h:
#elif defined(CONFIG_ARCH_SUN5I)
#warning "CONFIG_ARCH_SUN5I timers are not configured in hal.h yet!)
#define RTHAL_TIMER_DEVICE  "tmr2"
#define RTHAL_CLOCK_DEVICE "tmr2"
#else

Just to get past the #error "Unsupported ARM machine"

I can then fully compile and at the uImage linking stage I get the
undefined reference to IPIPE symbols as I expected.

I then greped around and I will use mach-at91 as an example:
../mach-at91/at91_ipipe_time.c:int __ipipe_mach_timerint =
KERNEL_TIMER_IRQ_NUM;
../mach-at91/at91_ipipe_time.c:EXPORT_SYMBOL(__ipipe_mach_timerint);

I can see that the at91 has full IPIPE support and I checked out how it
configures timers and export the chip specific functions to generic calls
for xenomai to call.

http://linux-sunxi.org/A10/TIMER#TMR_2_CTRL Is the info to the timers in
the SUN4I/SUN5I chips but I do not know how to actually use them. Should I
copy and port ALL the function from the at91_ipipe_time.c?

http://pastebin.com/tAxwTGNZ here is a dump of all the undefined symbols I
will need to port.


Any ideas where to start?
