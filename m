Message-ID: <4DCB23D6.9010706@domain.hid>
Date: Thu, 12 May 2011 02:03:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA192E0.2090802@domain.hid>
	<20110414164248.GA4725@domain.hid>
In-Reply-To: <20110414164248.GA4725@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 04/14/2011 06:42 PM, Richard Cochran wrote:
> On Sun, Apr 10, 2011 at 01:22:08PM +0200, Gilles Chanteperdrix wrote:
>> To help debugging this, please run the kernel which crashes with I-pipe
>> enabled, without Xenomai, and the attached test, in order to see if the
>> tsc behaves correctly.
> 
> Getting back to this, I did try the test program with ipipe 2.6.35 but
> without xenomai. It seems to run fine. But I only ran it for a few
> minutes.  The exact version was ipipe-2.6.35.9-arm-1.18-01 plus endian
> fix, and I attached the config.

Hi Richard,

the issue on ixp looks like the last one to be fixed on arm. If you have
time, could you try the following program? It makes a very basic test,
but not having a big-endian ixp at end, I am wondering about very basic
assumptions...:

#include <stdio.h>

__attribute__((naked)) unsigned long long f(unsigned long long *x)
{
	asm("ldrd r0, [r0]\n\t"
	    "mov pc, lr");
}

__attribute__((naked)) unsigned long long g(unsigned long long *x)
{
	asm("ldm r0, {r0, r1}\n\t"
	    "mov pc, lr");
}

int main(void)
{
	unsigned long long x = 0xffffffffULL;

	printf("f: %Lx\n", f(&x));
	printf("g: %Lx\n", g(&x));
	return 0;
}

If you do not have time, do you agree for a revert of the KUSER_TSC code
to the one we had before, and which is working for you?

Regards.

-- 
                                                                Gilles.

