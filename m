Message-ID: <53C38058.4030903@siemens.com>
Date: Mon, 14 Jul 2014 09:01:44 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <53BF7A2A.7020302@siemens.com> <53C11BBC.6020102@xenomai.org>
In-Reply-To: <53C11BBC.6020102@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Inconsistent traced Linux IRQ state on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-07-12 13:27, Gilles Chanteperdrix wrote:
> On 07/11/2014 07:46 AM, Jan Kiszka wrote:
>> Gilles,
>>
>> we see an warning about an inconsistency of the Linux IRQ state on ARM
>> with CONFIG_PROVE_LOCKING and, thus, CONFIG_TRACE_IRQFLAGS. I just
>> browsed code and history and stumbled over 11a959bf53 ("ipipe/arm:
>> disable calls to trace_hardirqs_(on|off) from assembly", ipipe-3.4.6),
>> the only obvious related delta between vanilla and the ipipe kernel. Can
>> you comment on both why you disabled it
> 
> The reason why I disabled it is that:
> 1- the spots where these functions are called are spots where hardware
> interrupts may be off, but the root stage not necessary stalled, which
> will may be confusing;
> 2- these spots are also deep enough in the assembly code to be called
> for real-time tasks, which again may confuse these functions.

It's ok to remove Linux tracing from the heart of those functions if
they are used in RT context as well. But then we should fix up the state
when handing over to Linux again. Apparently, we are missing at least
one fix-up here.

> 
> Since I do not really understand the need for enabling this option with
> CONFIG_IPIPE (if you want to debug some Linux critical sections, you
> can do it without CONFIG_IPIPE, if you are after non-virtualized hard
> irq flags, the I-pipe tracer has an option to debug them), I simply took
> the easy way out and removed these calls.

The need for not breaking the kernels debugging infrastructure is being
able to analyze kernel components that use both real-time and plain
Linux locking and interrupt infrastructure. We do have such use cases.
It also helped in the past on x86 to validate the I-pipe patch itself.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

