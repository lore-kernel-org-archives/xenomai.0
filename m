Message-ID: <53C11BBC.6020102@xenomai.org>
Date: Sat, 12 Jul 2014 13:27:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53BF7A2A.7020302@siemens.com>
In-Reply-To: <53BF7A2A.7020302@siemens.com>
Content-Type: text/plain; charset=UTF-8
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 07/11/2014 07:46 AM, Jan Kiszka wrote:
> Gilles,
> 
> we see an warning about an inconsistency of the Linux IRQ state on ARM
> with CONFIG_PROVE_LOCKING and, thus, CONFIG_TRACE_IRQFLAGS. I just
> browsed code and history and stumbled over 11a959bf53 ("ipipe/arm:
> disable calls to trace_hardirqs_(on|off) from assembly", ipipe-3.4.6),
> the only obvious related delta between vanilla and the ipipe kernel. Can
> you comment on both why you disabled it

The reason why I disabled it is that:
1- the spots where these functions are called are spots where hardware
interrupts may be off, but the root stage not necessary stalled, which
will may be confusing;
2- these spots are also deep enough in the assembly code to be called
for real-time tasks, which again may confuse these functions.

Since I do not really understand the need for enabling this option with
CONFIG_IPIPE (if you want to debug some Linux critical sections, you
can do it without CONFIG_IPIPE, if you are after non-virtualized hard
irq flags, the I-pipe tracer has an option to debug them), I simply took
the easy way out and removed these calls.
-- 
                                                                Gilles.

