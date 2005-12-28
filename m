Message-ID: <43B2BA1B.8090909@domain.hid>
Date: Wed, 28 Dec 2005 17:15:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43B2AF57.10004@domain.hid>
In-Reply-To: <43B2AF57.10004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] ipipe-tracer-v5
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
> Hi Philippe,
> 
> this is a revised version of the tracer patch, addressing your concerns
> hopefully in the right way. Changes since the previous release:
> 
>  * move __ipipe_init_trace_proc() declaration to linux/ipipe.h
>  * define __BUILTIN_RETURN_ADDRESSx in linux/ipipe.h unless some arch
>    defines BROKEN_BUILTIN_RETURN_ADDRESS and provides its own variants
>  * improve ipipe_tsc2ns() for i386 so that it makes use of do_div (and
>    also accepts 64 bit input)
>  * move ipipe_tsc2us() to asm-i386/ipipe.h
>  * fix a display bug in the output of "frozen"
>  * reformatting
>  * remove inclusion of linux/ipipe_trace.h from linux/sched.h
> 
> NOTE: The last change makes the local inclusion of ipipe_trace.h
> necessary when instrumenting some code. Previous instrumentation patches
> are likely broken now.
> 
> I think it should be ready for apply now, shouldn't it?
> 

Yes; you guys did a nice job. v5 is on the merge queue, and will be 
applied tomorrow. We'll work on that basis for enhancements/fixes. Thanks.

-- 

Philippe.

