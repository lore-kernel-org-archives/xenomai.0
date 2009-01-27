Message-ID: <497F6B6F.2090406@domain.hid>
Date: Tue, 27 Jan 2009 21:15:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <497F6524.2080601@domain.hid>
	<200901272006.06314.paul_c@domain.hid>
In-Reply-To: <200901272006.06314.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] FPU support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Hi Giles
> 
> On Tuesday 27 January 2009, Gilles Chanteperdrix wrote:
>> So, the question is: are there people around who either:
>> - need FPU support for kernel-space real-time threads;
>> - do not want to pay the price of a trap when using the FPU in user-space.
> 
> One application that I work on uses floating point math in kernel space, but 
> it is a constant source of problems - Being forced to migrate to user space 
> would be a welcome move.. The only question is how much of an overhead does 
> the trap incur ?

The answer probably depends on the machine. You can probably estimate it
for x86 by using rdtsc in well chosen places. What you need to measure
is the time between the fpu fault in user-space and the beginning of the
fpu fault handler in kernel-space, then the time between the end of the
fpu fault handler and the return to user-space.

-- 
					    Gilles.

