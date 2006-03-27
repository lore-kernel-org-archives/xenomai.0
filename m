Message-ID: <4427F7F0.7040309@domain.hid>
Date: Mon, 27 Mar 2006 16:34:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] CONFIG_XENO_OPT_DEBUG_LEVEL
References: <441EFB6D.8000507@domain.hid>
	<441F1675.1010703@domain.hid>	<441F3BE9.5010409@domain.hid>
	<441FB2F3.8090202@domain.hid> <44267889.8040301@domain.hid>
In-Reply-To: <44267889.8040301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> 
> 
> Here is an attempt to base the activation of XENO_ASSERT on a subsystem
> debug switch at compile time, applied on RTDM.
> 
> The procedure of adding a new system for XENO_ASSERT usage would be to
> define the required kbuild switch according to the naming scheme
> CONFIG_XENO_OPT_DEBUG_subsystem, include nucleus/assert.h, and add
> "#define CONFIG_XENO_OPT_DEBUG_subsystem 0" for the unset case.
> XENO_ASSERT is new called with (subsystem, condition, action). If we
> invent further debugging macros, they could be controlled in a similar way.
> 
> What do you think?
> 

I like the flexibity this approach brings (even if I think that the 
context checking in drvlib.c should be done unconditionally, regardless 
of the debug mode -- but that's probably a matter of personal taste). 
I've merged this patch, so that we can further use this debug 
infrastructure in other sub-systems. Thanks.

-- 

Philippe.

