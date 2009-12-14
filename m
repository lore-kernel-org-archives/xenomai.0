Message-ID: <4B264422.3010302@domain.hid>
Date: Mon, 14 Dec 2009 14:56:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B263E6A.7040104@domain.hid> <4B264295.9080308@domain.hid>
In-Reply-To: <4B264295.9080308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Alexis Berlemont <alexis.berlemont@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>> 
>> I am working on automated build tests of several configurations of 
>> Xenomai head. While running them, I found a few issues, and would
>> need acks, since it is in parts others maintain.
>> 
>> Alex: https://mail.gna.org/public/xenomai-git/2009-12/msg00112.html
>> 
>> 
>> Wolfgang:
>> https://mail.gna.org/public/xenomai-git/2009-12/msg00113.html
>> 
> 
> Though I'm not Wolfgang:
> 
> config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG -       depends on
> XENO_DRIVERS_CAN_SJA1000 +       depends on XENO_DRIVERS_CAN_SJA1000
> && !PARPORT tristate "PEAK Parallel Port Dongle" help
> 
> That's not obviously related. Why do we need it?

Kconfig says:

config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
        depends on XENO_DRIVERS_CAN_SJA1000
        tristate "PEAK Parallel Port Dongle"
        help

        This driver is for the PCAN Dongle, the PC parallel port to CAN
        converter from PEAK Systems (http://www.peak-system.com). You need
        to disable parallel port support in the kernel (CONFIG_PARPORT) for
        proper operation. The interface type (sp or epp), I/O port and
        interrupt number should be defined via module parameters.

> 
>> Anyone:
>> https://mail.gna.org/public/xenomai-git/2009-12/msg00114.html
>> 
> 
> If it builds, it's fine (I don't think anyone is using x86 on 2.4
> anymore).

I do not think so either, but since we ship this patch, we should
check that it compiles at least... Or remove it.

> 
>> Philippe (check powerpc 2.4): 
>> https://mail.gna.org/public/xenomai-git/2009-12/msg00115.html
>> 
>> The current status of the tests may be found here: 
>> http://sisyphus.hd.free.fr/~gilles/bx/
> 
> Nice! That's not buildbot-based, is it?

No. Only plain shell. Anyway, what dominates the run-time is the
x86 debian-like .config builds. I do not plan to run these tests
after each commit or even every night, only to validate a relase
before pushing it on the download area.

-- 
                                          Gilles


