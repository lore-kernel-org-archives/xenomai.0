Message-ID: <49366235.7060101@domain.hid>
Date: Wed, 03 Dec 2008 11:40:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid> <49330CD3.4090700@domain.hid>
	<4933BAE2.3000502@domain.hid> <4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <49363D9C.7010201@domain.hid>
	<49365B75.4020207@domain.hid> <4936638B.50306@domain.hid>
In-Reply-To: <4936638B.50306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> Gilles Chanteperdrix wrote:
>>>> For architectures with a high-resolution counter,
>>>> clock_gettime(CLOCK_MONOTONIC) is a xenomai service which uses the
>>>> counter and does not issue any syscall, this includes arm unless you
>>>> configured xenomai with --enable-arm-arch=generic or with
>>>> --disable-arm-tsc, and this probably includes powerpc.
>>>>
>>> clock_gettime() is wrapped to __wrap_clock_gettime(), which does a syscall:
>>>
>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/src/skins/posix/clock.c?v=SVN-trunk#058
>>>
>>> Have I missed something?
>> Yes, read the code again.
> 
> I was aware of CONFIG_XENO_HW_DIRECT_TSC but didn't look it up correctly
> :-(. It is set for my ARM  but not for my PowerPC system. Which explains
> some differences.

In include/asm-powerpc/syscall.h, I see:
#define CONFIG_XENO_HW_DIRECT_TSC 1

-- 
                                                 Gilles.

