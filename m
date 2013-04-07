Message-ID: <51618C48.7040505@xenomai.org>
Date: Sun, 07 Apr 2013 17:10:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515DE96F.7080508@xenomai.org> <515FEF85.5010801@web.de>
	<51606911.7050205@xenomai.org> <51606A47.8000606@web.de>
In-Reply-To: <51606A47.8000606@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe on ARM platform.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/06/2013 08:32 PM, Jan Kiszka wrote:

> On 2013-04-06 20:27, Gilles Chanteperdrix wrote:
>>> And it has to map directly to might_fault
>>> in case CONFIG_IPIPE_DEBUG_CONTEXT is disabled (thus zero overhead).
>>
>> That would defeat the purpose of the patch. might_fault can not be
>> called over non root domains.
> 
> True. But we should avoid leaving the costly irq-disable/enable and
> domain checks in production code behind when might_fault actually
> resolves to a nop. That should be the case for
> !CONFIG_DEBUG_ATOMIC_SLEEP && !CONFIG_PROVE_LOCKING.


I am almost sure I did not have either of these two options enabled when
I observed the bug.

-- 
                                                                Gilles.

