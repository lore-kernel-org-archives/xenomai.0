From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Working example for direct memory mapped IO
Date: Fri, 15 Dec 2006 21:25:09 +0100
References: <200612132248.36493.niklaus.giger@domain.hid>
	<45814E2A.9020106@domain.hid>
In-Reply-To: <45814E2A.9020106@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lSwgFnXwZRd4Q2p"
Message-Id: <200612152125.09368.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_lSwgFnXwZRd4Q2p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 14. Dezember 2006 14:14 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > Hi
> >
> > To document basic Xenomai/Linux patterns I developed the attached small
> > example for our PPC405 board, which just rolls the 8 debug LEDs.
> >
> > Are there any comments about it?
>
> I like the idea of having useful generic code patterns like this in the
> examples repos. But I also have a few wishes regarding this particular one:
>
>  * I would prefer that generic patterns are coded against POSIX or maybe
>    Native, not against a special RTOS skin (not everyone know the
>    VxWorks API by heart ;) ).
>
>  * Try to make use of as less additional patterns beyond the core aspect
>    as possible. E.g., running the lights in main would avoid quite some
>    code for init/cleanup. This helps the reader to grab the essence of
>    the demo. Still, the demo should remain functional!
I used the Linux "sleep" function and could eliminate all RT specifics and it 
still runs, albeit five times slower on my target.
>  * Please format your code according to kernel style (could be any
>    style, but we need a standard, so pick that one)
Tried, using Documentation/CodingStyle from the kernel. Hope I didn't miss to 
many thinks
> > Shall I put it into the Wiki at http://www.xenomai.org/index.php/Examples
> > or does somebody want to commit it to the examples part of the subversion
> > trunk?
>
> I would happily merge a cleaned up version into the repos, e.g. under
> the related skin.
I hope the attached version satisfy you now. Also added some suggestions made 
by Stephan Fillod.

> PS: If you want to contribute VxWorks-specific code pattern, you are
> welcome as well!
Will come to this a little bit later, as I making good progress to port our 
existing vxWorks application over to Xenomai. In any case, there is 
ksrc/skins/vxworks/demos/satch.c and the the simulator testsuite under
sim/skins/vxworks/testsuite/. But if you open for each skin a directory (what 
could be a good idea) one could add a README pointing to it.

Best regards

-- 
Niklaus Giger

--Boundary-00=_lSwgFnXwZRd4Q2p
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="hw_direct_io.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hw_direct_io.c"

/*
 * This small examples shows how to access memory directly.
 *
 * Copyright (c) 2006 Niklaus Giger <niklaus.giger at member.fsf.org>
 *
 * It will only work on PPC405GPr based custom HW board of Nestal Maschinen AG
 *
 * It should, however, be easily adapted to similar HW
 * It will scroll across 8 LEDs (interval 1/2 of second), which are mapped
 * to some bit of the GPIO of the PPC405GPr processor.
 * To sleep it uses the Linux sleep a second, so do not expect a real time behaviour.
 * Compile it with at least -O to expand the inline assembler code.
 *
 * You may find another example at http://www.denx.de/wiki/bin/view/\
 *     PPCEmbedded/DeviceDrivers#Section_AccessingPeripheralsFromUserSpace
 *     Wherefrom we stole the out_32 and iounmap procedures.
 *
 * Fillod Stephane recommends:
 * "Personally, I always access hardware registers through in_[lbe]{8,16,32}
 * "out_[lbe]{8,16,32} macros, so the code is portable across machines of 
 * "different endianess, and thanks to the integrated memory barriers, 
 * "I known exactly when the CPU will actually perform the I/O with respect 
 * "to the other C instructions." 
 * These macros are defined e.g. asm-ppc/io.h, but only available to the kernel
 *
 */

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <unistd.h>

void  *mapDirectIoRegister(unsigned long addr, size_t length);
int    iounmap(volatile void *start, size_t length);
void   sysLedSet(unsigned char value);

#define MAP_SIZE			4096UL
#define MAP_MASK 			(MAP_SIZE - 1)
#define HCU3_LED_REGISTER               0xEF600700

volatile unsigned long *ledRegister;

#ifdef __PPC__
extern inline void out_32(volatile unsigned long *addr, unsigned val)
{
        __asm__ __volatile__("stw%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
}
/* etc., cf asm/io.h */
#else
extern inline void out_32(volatile unsigned long *addr, unsigned val)
{ * which shows you how to use PPC assembler code to ensure correct IO ordering.

        *addr = val & 0xff;
}
#endif

void  *mapDirectIoRegister(unsigned long addr, size_t length)
{
	void *map_base, * virtAddr;
	off_t target = ((unsigned int) addr) & ~MAP_MASK;
	int fd;
	
	if ((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
		printf("/dev/mem could not be opened.\n");
		exit(1);
	}
	
	// Map one page
	map_base = mmap((void *)target, length, PROT_READ | PROT_WRITE, MAP_SHARED,
			fd, target);
	if(map_base == (void *) -1) {
		printf("Memory map failed for address 0x%lx\n", addr);
		return map_base;
	}
	
	virtAddr = (void *) ((unsigned long)map_base + ( (unsigned long)addr & MAP_MASK));
	printf("Memory map 0x%lx -> %p offset 0x%lx virtual %p\n", addr, map_base,
		addr & MAP_MASK, virtAddr);
	return virtAddr;
}

int iounmap(volatile void *start, size_t length)
{
	unsigned long ofs_addr;
	ofs_addr = (unsigned long)start & (getpagesize()-1);
	
	/* do some cleanup when you're done with it */
	return munmap((void*)start-ofs_addr, length+ofs_addr);
}

void   sysLedSet(unsigned char value)
{
	/* For obscure HW reasons, we have to negated it and shift the value 23 bits to the left  */
	*ledRegister = (( unsigned long ) ~value << 23) ;
        out_32(ledRegister, ( unsigned long ) ~value << 23);
}

int main (int argc, char *argv[])
{
	unsigned char j;
	printf("%s: %s %s\n", __FUNCTION__, __DATE__, __TIME__ ); 
	
	/* HW initialisation */
	ledRegister     = (unsigned long *)mapDirectIoRegister(HCU3_LED_REGISTER, MAP_SIZE);
	/* next we set the correct control mask in the GPIO_TCR */
	ledRegister[1]  = 0x7ffe0000; /* Three State Control */
	
	/* Now scroll our leds and pause a little bit between */
	for (j=0; j <= 8; j++) {
		sleep(1);
                printf("."); fflush(stdout);
		sysLedSet(1 << j);
	}
	iounmap((volatile void *)HCU3_LED_REGISTER, MAP_SIZE);
	printf("\n%s:done\n", __FUNCTION__); 
	return 0;
}

--Boundary-00=_lSwgFnXwZRd4Q2p--

