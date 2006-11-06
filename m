Message-ID: <454EFA9A.2050001@domain.hid>
Date: Mon, 06 Nov 2006 10:04:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
References: <4548C170.1000504@domain.hid>
	<4548F8BE.90809@domain.hid>	<454901B6.80606@domain.hid>
	<454B0FA0.9080307@domain.hid>	<454B1363.8080805@domain.hid>
	<454B15C5.1050803@domain.hid>	<454B17A1.7000805@domain.hid>
	<454B345A.9050606@domain.hid> <454B7AC1.9010305@domain.hid>
In-Reply-To: <454B7AC1.9010305@domain.hid>
Content-Type: multipart/mixed; boundary="------------030600050700050704080701"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030600050700050704080701
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Webb wrote:
> Jan Kiszka wrote:
> 
>>>>>> I found the reason: "3-dimensional" memcpy (__memcpy3d/_mmx_memcpy)
>>
>> ... True.
>>
>> This patch fixes the issue for me.
> 
> 
> Works for me as well on my Athlon64 X2 machine.

To see if trying to use this mmx_memcpy is worth the trouble, I made a
test program to benchmark __memcpy versus _mmx_memcpy. Could you try
it on AMD ?

-- 
                                                  Gilles Chanteperdrix

--------------030600050700050704080701
Content-Type: text/x-csrc;
 name="test_memcpy.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_memcpy.c"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <setjmp.h>
#include <sys/io.h>		/* iopl */
#include <sys/mman.h>		/* mlockall */

#define unlikely(expr) (__builtin_expect((expr), 0))
#include <asm/processor.h>

#define COUNT 1000
#define SIZE 512

#define hw_cli() \
	__asm__ __volatile__ ("cli")

#define hw_sti() \
	__asm__ __volatile__ ("sti")

void *_mmx_memcpy_prefetch(void *to, const void *from, size_t len);

void *_mmx_memcpy(void *to, const void *from, size_t len);

static inline __attribute__((always_inline)) void * __memcpy(void * to, const void * from, size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
	"rep ; movsl\n\t"
	"movl %4,%%ecx\n\t"
	"andl $3,%%ecx\n\t"
#if 1	/* want to pay 2 byte penalty for a chance to skip microcoded rep? */
	"jz 1f\n\t"
#endif
	"rep ; movsb\n\t"
	"1:"
	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
	: "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
	: "memory");
return (to);
}

jmp_buf jmpbuf;

void sigill_handler(int sig __attribute__((unused)))
{
	longjmp(jmpbuf, 1);
}

int main(void)
{
	char src[SIZE];
	char dst[SIZE];
	unsigned long long begin, end;
	double d;
	unsigned i, use_prefetch;
	
	if (iopl(3)) {
		perror("iopl(3)");
		return EXIT_FAILURE;
	}

	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
		perror("mlockall");
		return EXIT_FAILURE;
	}

	memset(src, '\0', sizeof(src));
	memset(dst, '\0', sizeof(src));

	if (signal(SIGILL, sigill_handler) == SIG_ERR) {
		perror("signal");
		return EXIT_FAILURE;
	}

	if (!setjmp(jmpbuf)) {
		use_prefetch = 1;

		__asm__ __volatile__ ("prefetch (%0)"
				      : /* no out */ : "r" (src));
	} else
		use_prefetch = 0;

	if (signal(SIGILL, SIG_DFL) == SIG_ERR) {
		perror("signal");
		return EXIT_FAILURE;
	}

	hw_cli();
	rdtscll(begin);
	for (i = 0; i < COUNT; i++)
		memcpy(dst, src, sizeof(dst));
	rdtscll(end);
	hw_sti();
	
	printf("libc memcpy: %llu\n", (end - begin)/COUNT);

	hw_cli();
	rdtscll(begin);
	for (i = 0; i < COUNT; i++)
		__memcpy(dst, src, sizeof(dst));
	rdtscll(end);
	hw_sti();
	
	printf("__memcpy: %llu\n", (end - begin)/COUNT);

	d = 0;
	for (i = 0; i < COUNT; i++) /* use fpu in order to avoid a fault when
				     * fxsave is called. */
		d += 0.1;

	if (use_prefetch) {
		hw_cli();
		rdtscll(begin);
		for (i = 0; i < COUNT; i++)
			_mmx_memcpy_prefetch(dst, src, sizeof(dst));
		rdtscll(end);
		hw_sti();

		printf("_mmx_memcpy(with prefetch): %llu\n",
		       (end - begin)/COUNT);
	} else {
		hw_cli();
		rdtscll(begin);
		for (i = 0; i < COUNT; i++)
			_mmx_memcpy(dst, src, sizeof(dst));
		rdtscll(end);
		hw_sti();

		printf("_mmx_memcpy(without prefetch): %llu\n",
		       (end - begin)/COUNT);
	}

	printf("d: %g\n", d);	/* Use d to avoid it being optimized out. */

	return EXIT_SUCCESS;
}

__attribute__((noinline)) void *_mmx_memcpy_prefetch(void *to, const void *from, size_t len)
{
	struct i387_fxsave_struct fxsave;
	char pad[15] __attribute__((unused));
	struct i387_fxsave_struct *fpenv =
		(struct i387_fxsave_struct *) (((unsigned) &fxsave + 15) & ~15);
	void *p;
	int i;

	p = to;
	i = len >> 6; /* len/64 */

	__asm__ __volatile__ ("fxsave %0; fnclex":"=m"(*fpenv));

	__asm__ __volatile__ (
		"   prefetch (%0)\n"		/* This set is 28 bytes */
		"   prefetch 64(%0)\n"
		"   prefetch 128(%0)\n"
		"   prefetch 192(%0)\n"
		"   prefetch 256(%0)\n"
		: /* no out */ : "r" (from) );
	
	for(; i>5; i--)
	{
		__asm__ __volatile__ (
		"  prefetch 320(%0)\n"
		"  movq (%0), %%mm0\n"
		"  movq 8(%0), %%mm1\n"
		"  movq 16(%0), %%mm2\n"
		"  movq 24(%0), %%mm3\n"
		"  movq %%mm0, (%1)\n"
		"  movq %%mm1, 8(%1)\n"
		"  movq %%mm2, 16(%1)\n"
		"  movq %%mm3, 24(%1)\n"
		"  movq 32(%0), %%mm0\n"
		"  movq 40(%0), %%mm1\n"
		"  movq 48(%0), %%mm2\n"
		"  movq 56(%0), %%mm3\n"
		"  movq %%mm0, 32(%1)\n"
		"  movq %%mm1, 40(%1)\n"
		"  movq %%mm2, 48(%1)\n"
		"  movq %%mm3, 56(%1)\n"
		: /* no out */ : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}

	for(; i>0; i--)
	{
		__asm__ __volatile__ (
		"  movq (%0), %%mm0\n"
		"  movq 8(%0), %%mm1\n"
		"  movq 16(%0), %%mm2\n"
		"  movq 24(%0), %%mm3\n"
		"  movq %%mm0, (%1)\n"
		"  movq %%mm1, 8(%1)\n"
		"  movq %%mm2, 16(%1)\n"
		"  movq %%mm3, 24(%1)\n"
		"  movq 32(%0), %%mm0\n"
		"  movq 40(%0), %%mm1\n"
		"  movq 48(%0), %%mm2\n"
		"  movq 56(%0), %%mm3\n"
		"  movq %%mm0, 32(%1)\n"
		"  movq %%mm1, 40(%1)\n"
		"  movq %%mm2, 48(%1)\n"
		"  movq %%mm3, 56(%1)\n"
		: /* no out */ : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}
	/*
	 *	Now do the tail of the block
	 */
	__memcpy(to, from, len&63);

	__asm__ __volatile__ ("fxrstor %0" : /* no out */ : "m"(*fpenv));

	return p;
}

__attribute__((noinline)) void *_mmx_memcpy(void *to, const void *from, size_t len)
{
	struct i387_fxsave_struct fxsave;
	char pad[15] __attribute__((unused));
	struct i387_fxsave_struct *fpenv =
		(struct i387_fxsave_struct *) (((unsigned) &fxsave + 15) & ~15);
	void *p;
	int i;

	p = to;
	i = len >> 6; /* len/64 */

	__asm__ __volatile__ ("fxsave %0; fnclex":"=m"(*fpenv));

	for(; i>5; i--)
	{
		__asm__ __volatile__ (
		"  movq (%0), %%mm0\n"
		"  movq 8(%0), %%mm1\n"
		"  movq 16(%0), %%mm2\n"
		"  movq 24(%0), %%mm3\n"
		"  movq %%mm0, (%1)\n"
		"  movq %%mm1, 8(%1)\n"
		"  movq %%mm2, 16(%1)\n"
		"  movq %%mm3, 24(%1)\n"
		"  movq 32(%0), %%mm0\n"
		"  movq 40(%0), %%mm1\n"
		"  movq 48(%0), %%mm2\n"
		"  movq 56(%0), %%mm3\n"
		"  movq %%mm0, 32(%1)\n"
		"  movq %%mm1, 40(%1)\n"
		"  movq %%mm2, 48(%1)\n"
		"  movq %%mm3, 56(%1)\n"
		: /* no out */ : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}

	for(; i>0; i--)
	{
		__asm__ __volatile__ (
		"  movq (%0), %%mm0\n"
		"  movq 8(%0), %%mm1\n"
		"  movq 16(%0), %%mm2\n"
		"  movq 24(%0), %%mm3\n"
		"  movq %%mm0, (%1)\n"
		"  movq %%mm1, 8(%1)\n"
		"  movq %%mm2, 16(%1)\n"
		"  movq %%mm3, 24(%1)\n"
		"  movq 32(%0), %%mm0\n"
		"  movq 40(%0), %%mm1\n"
		"  movq 48(%0), %%mm2\n"
		"  movq 56(%0), %%mm3\n"
		"  movq %%mm0, 32(%1)\n"
		"  movq %%mm1, 40(%1)\n"
		"  movq %%mm2, 48(%1)\n"
		"  movq %%mm3, 56(%1)\n"
		: /* no out */ : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}
	/*
	 *	Now do the tail of the block
	 */
	__memcpy(to, from, len&63);

	__asm__ __volatile__ ("fxrstor %0" : /* no out */ : "m"(*fpenv));

	return p;
}

--------------030600050700050704080701--

