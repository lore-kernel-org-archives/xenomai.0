Message-ID: <497F6EE8.2000402@domain.hid>
Date: Tue, 27 Jan 2009 21:30:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <497F6524.2080601@domain.hid>	<200901272006.06314.paul_c@domain.hid>
	<497F6B6F.2090406@domain.hid>
In-Reply-To: <497F6B6F.2090406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] FPU support
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Paul wrote:
>> Hi Giles
>>
>> On Tuesday 27 January 2009, Gilles Chanteperdrix wrote:
>>> So, the question is: are there people around who either:
>>> - need FPU support for kernel-space real-time threads;
>>> - do not want to pay the price of a trap when using the FPU in user-space.
>> One application that I work on uses floating point math in kernel space, but 
>> it is a constant source of problems - Being forced to migrate to user space 
>> would be a welcome move.. The only question is how much of an overhead does 
>> the trap incur ?
> 
> The answer probably depends on the machine. You can probably estimate it
> for x86 by using rdtsc in well chosen places. What you need to measure
> is the time between the fpu fault in user-space and the beginning of the
> fpu fault handler in kernel-space, then the time between the end of the
> fpu fault handler and the return to user-space.
> 

Enabling the I-pipe tracer would help in determining how many cycles are burnt
from early trap handling back to the supervisor exit point; if you do this, you
may want to keep IPIPE_DEBUG_CONTEXT off, since this adds some overhead on low
end hw. user/supervisor transition time would have to be added as well, but this
is likely not the most significant portion of the overhead.

-- 
Philippe.

