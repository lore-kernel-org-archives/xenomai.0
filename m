Message-ID: <499D5FC4.4030303@domain.hid>
Date: Thu, 19 Feb 2009 14:33:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499D359C.3060805@domain.hid> <499D3801.5040303@domain.hid>
	<499D3FE6.4030208@domain.hid> <499D5B0A.7020608@domain.hid>
In-Reply-To: <499D5B0A.7020608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] XENO_OPT_SYS_STACKPOOLSZ vs. switchtest
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi Gilles,
>>>>
>>>> how much XENO_OPT_SYS_STACKPOOLSZ do I need to run switchtest for
>>>> default settings? At least on x86-64, the default 32K is not enough.
>>>> Unless we talk about GB ;), maybe it makes sense to adjust the default
>>>> size accordingly.
>>> It depends on the arguments you pass to switchtest.
>> None, ie. the default settings.
> 
> Then 6 kernel-space tasks are created. Since switchtest is not the

6*4 is 20k... Ah, the well-known allocator overhead, I guess. Will try
with >= 40k.

> average use of Xenomai, and is supposed to be used only for validating
> the context/FPU switches, I would not change XENO_OPT_SYS_STACKPOOL_SZ,
> maybe only add a clear message when creation of kernel-space tasks fails.

Well, isn't the switchtest part of xeno-test? Would be unfortunate to
require a kernel rebuild just for running the standard tests. I think we
don't loose much by slightly increasing the stack to, say, 64K on 32 bit
and 128K on 64 bit archs.

BTW, XNARCH_THREAD_STACKSZ for x86-64 equals the x86-32 bit value (4K)
while I don't think the have they same demands (nor the same resource
restrictions).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

