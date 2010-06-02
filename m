Message-ID: <4C066109.9040902@domain.hid>
Date: Wed, 02 Jun 2010 15:47:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100601135005.GA5483@domain.hid>	<1275402757.27918.151.camel@domain.hid>	<20100601155403.GA8240@domain.hid>	<4C053C51.4090903@domain.hid>	<4C061823.70005@domain.hid>	<1275470136.18250.16.camel@domain.hid>
	<4C06485B.3000500@domain.hid>
In-Reply-To: <4C06485B.3000500@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> On 02/06/10 11:15, Philippe Gerum wrote:
> 
>> Actually, we could extend this logic and forge a stack frame to return
>> to the preempted application code via some userland trampoline code,
>> doing the switch:
>>
>> [watchdog trigger]
>> 	forge_return_frame(on =regs->sp, to =regs->pc);
>> 	regs->pc = __oops_I_did_it_again;
>>
>> __oops_I_did_it_again:
>> 	__xn_migrate(LINUX_DOMAIN);
>> 	ret (via forged frame)
>>
>> The thing is, that this brings in some arch-dep code to forge a stack
>> frame (like the kernel uses for signals), that should rather live in the
>> pipeline core.
> 
> Am I to naive thinking that this solution would let the user space
> choose what to do when the watchdog interrupts the current thread? In
> your example, it would be enough to assign to __ops_I_did_it_again a
> function pointer to the function that has to be executed.
> 
> Probably there will be hard constraint on what this function can do, but
> it would be a nice feature for debugging and for solving application
> specific issues.

You already have that with SIGDEBUG. You can register whatever signal
handler you want for the SIGDEBUG signal. The same goes for SIGSEGV. The
only issue we are talking about here is that the SIGDEBUG mechanism does
not work when a piece of code is blocked in an infinite loop without
calling any syscall. But that should be a pretty rare case.

-- 
					    Gilles.

