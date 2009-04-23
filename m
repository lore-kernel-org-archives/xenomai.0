From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
In-Reply-To: <49F05891.8040408@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<49F05891.8040408@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Apr 2009 15:34:34 +0200
Message-Id: <1240493674.16510.36.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] adeos patch 2.6.28.9-x86-2.2-07 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Gilles

On Thu, 2009-04-23 at 14:01 +0200, Gilles Chanteperdrix wrote:
> Vikesh Rambaran wrote:
> > I am going to test with CONFIG_NO_HERTZ and ACPI_PROCESSOR disabled
> > as per Gilles suggestions on other emails.
> 
> Yes, you should disable ACPI_PROCESSOR. I am surprised that it is not
> already done, because it is (or should be) written everywhere.
> 

Thanx for your reply. It is well documented on the mailing lists ..:)

However, I have previously disabled ACPI completely (not just
ACPI_PROCESSOR) ONLY because it gave the lowest latencies across all the
platforms which i tested. Well that's the way it seemed for our
application. (unfortunately, i know this is not what's recommended on
the lists)

To retest, I have rebuilt the kernel 2.6.28.9 with ACPI enabled, but
ACPI_PROCESSOR disabled. Our applications latency report goes up 
to 250uS for the few minutes that it was run on the Core 2 PC.

On the Core Duo laptop, the above kernel and application give latencies
< 40uS. By the way, is it ok to use a kernel compiled for Core2 on a 
Core Duo platform ?

The latency test does not show any significant difference whether ACPI
is completely disabled or only ACPI_PROCESSOR is disabled.


> As for CONFIG_NO_HZ, CONFIG_NO_HZ works correctly with Xenomai, it had a
> bug on ARM on 2.6.26, but the bug was specific to ARM (actually specific
> to architectures with unlocked context switches), I was only asking
> Martin to test this because his bug looked like the NO_HZ bug on ARM,
> but Martin's problem turned out to be with CONFIG_X86_PM_TIMER, so is
> completely unrelated to NO_HZ.
> 

Ok, great.

Thanx again
Vicki



