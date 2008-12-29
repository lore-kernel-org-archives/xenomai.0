Message-ID: <495933ED.9070507@domain.hid>
Date: Mon, 29 Dec 2008 21:32:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4958E439.9040503@domain.hid> <4958F2EE.8080804@domain.hid>
	<495908DA.7030304@domain.hid>
In-Reply-To: <495908DA.7030304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] Fix include for kernel/panic.c
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> +++ b/kernel/panic.c
>>> @@ -21,6 +21,7 @@
>>>  #include <linux/debug_locks.h>
>>>  #include <linux/random.h>
>>>  #include <linux/kallsyms.h>
>>> +#include <linux/ipipe_trace.h>
>> That is not enough, when compiling a kernel without I-pipe enabled, the
>> compiler complains about ipipe_processor_id.
> 
> Good point. But I wonder where the ipipe_processor_id wrapper for the
> disabled case is - can't find it in adeos-ipipe-2.6.26-arm-1.11-02.patch
> right now.
>

I have a pending fix for this one as well. I'll push my tree tomorrow.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.

