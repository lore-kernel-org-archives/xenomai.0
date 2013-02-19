Message-ID: <51236B02.2030106@xenomai.org>
Date: Tue, 19 Feb 2013 13:07:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com>
	<511DDBD5.4060505@web.de>	<51236088.1030402@gmail.com>
	<51236A75.5090400@siemens.com>
In-Reply-To: <51236A75.5090400@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Manuel Huber <manuel.h87@gmail.com>, xenomai@xenomai.org

On 02/19/2013 01:05 PM, Jan Kiszka wrote:

> On 2013-02-19 12:22, Manuel Huber wrote:
>> Thanks for your reply and sorry for the delay ;)
>> I have tried disabling the options and attached the logs. It still fails :(
>>
>> I hope it's okay to attach so many files... I can also add the config
>> files for
>> every build if that helps.
> 
> I'll try your config later, though in a different environment. If I'm
> unable to reproduce, I'll provide further instrumentation suggestions.
> 
> Gilles instrumentation confirmed that the CPU is taking a standard
> external IRQ (#23: 0x37-FIRST_EXTERNAL_VECTOR). I suspect we are
> enabling hardware IRQs too early during the boot of secondary CPUs,
> causing this BUG as not all data structures are initialized yet. What
> enables then can be some code that we do not run normally, on x86-64 or
> maybe also x86-32 unless using your .config and/or your hardware.


Remember that we have had such problems with grub2, so, the error could
depend on the bootloader, for instance a network-aware bootloader could
keep the network interface configured and we would take an interrupt
when re-enabling interrupts.

-- 
                                                                Gilles.

