Message-ID: <43B3C10D.7000704@domain.hid>
Date: Thu, 29 Dec 2005 11:57:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] ipipe-tracer-v5
References: <43B2AF57.10004@domain.hid> <43B3B978.7020106@domain.hid>
In-Reply-To: <43B3B978.7020106@domain.hid>
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
> Jan Kiszka wrote:
> 
>>------------------------------------------------------------------------
>>
>>--- linux-2.6.14.3/arch/i386/boot/compressed/misc.c.orig	2005-11-24 23:10:21.000000000 +0100
>>+++ linux-2.6.14.3/arch/i386/boot/compressed/misc.c	2005-12-28 16:12:43.000000000 +0100
>>@@ -15,6 +15,12 @@
>> #include <asm/io.h>
>> #include <asm/page.h>
>> 
>>+#ifdef CONFIG_IPIPE_TRACE
>>+void __attribute__ ((no_instrument_function)) mcount(void)
>>+{
>>+}
>>+#endif
>>+
>> /*
>>  * gzip declarations
>>  */
>>@@ -112,7 +118,7 @@
>> #define INPLACE_MOVE_ROUTINE  0x1000
>> #define LOW_BUFFER_START      0x2000
>> #define LOW_BUFFER_MAX       0x90000
>>-#define HEAP_SIZE             0x3000
>>+#define HEAP_SIZE             0x4000
>> static unsigned int low_buffer_end, low_buffer_size;
>> static int high_loaded =0;
>> static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
>>@@ -125,6 +131,7 @@
>> static void * xquad_portio = NULL;
>> #endif
>> 
>>+#define ZLIB_INFLATE_NO_INFLATE_LOCK
>> #include "../../../../lib/inflate.c"
>> 
> 
> 
> With the recent advent of a broken-out latency trace patch for the
> standard kernel, it became clear what the last patched line is for:
> nothing in this case, it only makes sense as the full
> reduce-zlib-stack-hack.patch available from
> 
> http://people.redhat.com/mingo/latency-tracing-patches/patches
> 
> One only need this add-on patch when running the tracing kernel with 4k
> stacks.
> 
> Philippe, I think we should not merge this particular line change. In
> contrast, the HEAP_SIZE change also appears in the tracer patch itself.
> 

Ack.

-- 

Philippe.

