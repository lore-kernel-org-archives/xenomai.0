Message-ID: <4DA192E0.2090802@domain.hid>
Date: Sun, 10 Apr 2011 13:22:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
In-Reply-To: <20110410065250.GA28869@domain.hid>
Content-Type: multipart/mixed; boundary="------------040201010001010205020801"
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040201010001010205020801
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Richard Cochran wrote:
> On Sat, Apr 09, 2011 at 09:50:16PM +0200, Gilles Chanteperdrix wrote:
>>> Just to have an idea where the issue come from, could you try reverting
>>> all the changes which were made on the tsc and timer? i.e. revert to the
>>> original ipipe_mach_get_tsc and ipipe_mach_set_dec?
>>>
>> The exact commit to revert is this one:
>> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cbd591ed5797f105ff45e04cca3bc939388624ea;hp=a2761e92ecd573bc3a3b068d4ebb7cc06313213c
> 
> Okay, with cbd591ed57 reverted, it works fine even without IPIPE_DEBUG.

Sorry for the multiple answers to each mail...

To help debugging this, please run the kernel which crashes with I-pipe
enabled, without Xenomai, and the attached test, in order to see if the
tsc behaves correctly.

Also, about the performances, Xenomai 2.4 did not have the Xenomai
preemptible context switches. Maybe with FCSE, it results in reduced
latencies to disable this option in Xenomai 2.5.

-- 
                                                                Gilles.

--------------040201010001010205020801
Content-Type: text/x-csrc;
 name="test_tsc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_tsc.c"

#include <stdio.h>
#if 0
#include <native/timer.h>

#define rdtsc() rt_timer_tsc()
#define init_tsc() do {			\
	} while(0)
#elif 1
#include <stdlib.h>

#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
/* Change this according to the real tsc type */
#define XNARCH_ARM_TSC_TYPE __XN_TSC_TYPE_FREERUNNING

#include <asm/xenomai/syscall.h>

struct __xn_tscinfo __xn_tscinfo = {
	.type = XNARCH_ARM_TSC_TYPE,
	/* Change according to real tsc */
	.u = {
		.fr = {
			.counter = 0,
			.mask = 0xffffffff,
			.tsc = (unsigned long long *)(0xffff0fa0 - 0x80),
		},
	},
};

#define rdtsc() __xn_rdtsc()
static void init_tsc(void)
{
	unsigned long phys_addr;
	unsigned page_size;
	void *addr;
	int fd;

	fd = open("/dev/mem", O_RDONLY | O_SYNC);
	if (fd == -1) {
		perror("Xenomai init: open(/dev/mem)");
		exit(EXIT_FAILURE);
	}

	page_size = sysconf(_SC_PAGESIZE);

	/* Counter physical address, depends on hardware */
	phys_addr = 0xC8005000UL;
	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
		    fd, phys_addr & ~(page_size - 1));
	if (addr == MAP_FAILED) {
		perror("Xenomai init: mmap(/dev/mem)");
		exit(EXIT_FAILURE);
	}

	__xn_tscinfo.u.fr.counter =
		((volatile unsigned *)
		 ((char *) addr + (phys_addr & (page_size - 1))));
}

#else
/* The newest version */
#include <stdlib.h>

#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

static unsigned long cntr_addr;

static unsigned long long (*rdtsc_inner)(unsigned long) =
	(void *)(0xffff0fa0 - 0x5c);
#define rdtsc() (*rdtsc_inner)(cntr_addr)
static void init_tsc(void)
{
	unsigned long phys_addr;
	unsigned page_size;
	void *addr;
	int fd;

	fd = open("/dev/mem", O_RDONLY | O_SYNC);
	if (fd == -1) {
		perror("Xenomai init: open(/dev/mem)");
		exit(EXIT_FAILURE);
	}

	page_size = sysconf(_SC_PAGESIZE);

	/* Counter physical address, depends on hardware */
	phys_addr = 0xC8005000UL;
	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
		    fd, phys_addr & ~(page_size - 1));
	if (addr == MAP_FAILED) {
		perror("Xenomai init: mmap(/dev/mem)");
		exit(EXIT_FAILURE);
	}

	cntr_addr =
		(unsigned long)
		 ((char *) addr + (phys_addr & (page_size - 1)));
}
#endif

int main(void)
{
	unsigned long long runtime, jump, tsc1, tsc2;

	init_tsc();

	runtime = tsc2 = rdtsc();
	for(;;) {
		tsc1 = rdtsc();
		if (tsc1 <= tsc2)
			break;
		tsc2 = rdtsc();
		if (tsc2 <= tsc1)
			goto err2;
	}

	runtime = tsc2 - runtime;
	jump = tsc2 - tsc1;
	goto display;
  err2:
	runtime = tsc1 - runtime;
	jump = tsc1 - tsc2;

  display:
	fprintf(stderr, "tsc not monotonic after %Lu.%09Lu ticks, ",
		runtime / 1000000000ULL, runtime % 1000000000ULL);
	fprintf(stderr, "jumped back %Lu tick\n", jump);

	return 1;

}

--------------040201010001010205020801--

