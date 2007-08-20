Message-ID: <46C984DC.6090203@domain.hid>
Date: Mon, 20 Aug 2007 14:11:08 +0200
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai degrades syscall time on PPC405
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hello,

I am trying to understand some performance problems I ran into on my 
xenomai system.

The testcode I attached performs a syscall(gettimeofday). Measuring time on 
a vanilla Kernel gives the following output:

ticks for ppc_getccounter: 116, for gettimeofday: 1479

The same kernel with xenomai patched in gives this:

ticks for ppc_getccounter: 116, for gettimeofday: 4278

Is this the expected behaviour? Why is the time for a system call nearly 3 
times as much?

#include <stdio.h>
#include <sys/time.h>
#include <time.h>

static void
ppc_getcounter(unsigned long long *v)
{
	register unsigned long tbu, tb, tbu2;

     loop:
	asm volatile ("mftbu %0" : "=r" (tbu) );
	asm volatile ("mftb  %0" : "=r" (tb)  );
	asm volatile ("mftbu %0" : "=r" (tbu2));
	if (__builtin_expect(tbu != tbu2, 0)) goto loop;

	/* The slightly peculiar way of writing the next lines is
	compiled better by GCC than any other way I tried. */
	((long*)(v))[0] = tbu;
	((long*)(v))[1] = tb;
}

int main(int argc, char* argv[])
{
	while(1) {
		struct timeval tv;
		unsigned long long count0, count1, count2;
		ppc_getcounter(&count0);
		ppc_getcounter(&count1);
		gettimeofday(&tv, NULL);
		ppc_getcounter(&count2);
		printf("ticks for ppc_getccounter: %lld, for gettimeofday: %lld\n",
			count1 - count0, count2- count1);
		sleep(1);
	}
}


Cheers
-- 
Dirk Eibach
Entwicklung
Guntermann & Drunck GmbH Systementwicklung




