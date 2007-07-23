Message-ID: <2ff1a98a0707230252l4d0e5b43we45d6616757b3659@domain.hid>
Date: Mon, 23 Jul 2007 11:52:46 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707230233l67823789v41c85729bf0335ce@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707222152t2037a987mca3f70d1da9865dd@domain.hid>
	<18084.23878.661537.272573@domain.hid>
	<2862c2c80707230104y5e5c9cc0v8038458e8bcc5f1c@domain.hid>
	<2ff1a98a0707230117n6407f270o9f58f44eeb4f9d9d@domain.hid>
	<2862c2c80707230129m143232d1n2dcfbec22c05962d@domain.hid>
	<2ff1a98a0707230150j216dd5bapbaf08d3df91b4e0e@domain.hid>
	<2ff1a98a0707230210md987ad0la2adaef2210c6f46@domain.hid>
	<2862c2c80707230233l67823789v41c85729bf0335ce@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Testsuite for AT91 - Illegal Instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/23/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> On 7/23/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > On 7/23/07, Gilles Chanteperdrix < gilles.chanteperdrix@xenomai.org> wrote:
> > > I do not think so. Last idea: check the EABI setting. If it is not the
> > > culprit, try running your application in gdb. Really, this will tell
> > > you what goes wrong right away instead of trying to guess.
> >
> > I have just checked the v2.3 branch, it does not support EABI, only
> > trunk does. So, if you are using Xenomai v2.3.2, pass whatever flag is
> > necessary for gcc not to use EABI.
>
> But the ARM GNU toolchain requires the kernel to have EABI feature to
> support BusyBox.

Busybox builds and runs fine without EABI.

>
> Is this going to affect the application compiled with no EABI support?
> Please advice.
> (...)
> Any ideas ?

Read my mail again: you can not compile Xenomai v2.3.2 with EABI
support. So, the choices are:
- disable EABI (the kernel supports application built with and without
EABI, but I am afraid if you built your libc with EABI support, you
can not link a non EABI application with an EABI libc, so this means
that you have to rebuild your user-space support without EABI)
- use Xenomai trunk
- apply the diffs for EABI support from trunk into the 2.3.x branch.
Commits numbers are 2393 and 2402.

I will add support for  EABI to the next release of the v2.3.x branch,
but in the mean time, you will have to work around this issue either
way.

-- 
                                               Gilles Chanteperdrix

