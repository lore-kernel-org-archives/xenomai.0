Message-ID: <44679108.7000109@domain.hid>
Date: Sun, 14 May 2006 22:20:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4467860A.9020103@domain.hid> <44678805.2000904@domain.hid>
In-Reply-To: <44678805.2000904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] Re: [patch] kgdb for ipipe -
	updated version
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
Cc: xenomai-core <xenomai@xenomai.org>, adeos-main@gna.org

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Hi all,
>>
>>here is an improved version of the kgdb-over-ipipe patch. This version
>>specifically addresses the concerns Gilles brought up recently:
>>
>>o No more dependencies on Xenomai, thus also no need to have the nucleus
>>  compiled into the kernel. There is now a registrable handler,
>>  ipipe_safe_current, which is invoked by the kgdb code to obtain
>>  "current". When the xeno nucleus arms its services, it overloads this
>>  handler to always provide a valid current (either the real one or
>>  init_task for kernel-only threads).
>>
>>o Replaced smp_processor_id with ipipe_processor_id in critical kgdb
>>  code. I haven't tested this replacement, so no guarantees here. But so
>>  far it looks consistent - at least for me.
>>
>>To use the kernel debugger with Xenomai, you need the latest kgdb
>>patches [1] and have to follow the attached patch series.
>>
> 
> 
> Oops, one patch was missing: the one to add the handler registration to
> Xenomai. See attachment.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/nucleus/pod.c
> ===================================================================
> --- ksrc/nucleus/pod.c	(Revision 1095)
> +++ ksrc/nucleus/pod.c	(Arbeitskopie)
> @@ -43,6 +43,9 @@

Ok with the basic idea, but this code should definitely go to the 
arch-dependent section and not to the nucleus core directly, probably to 
include/asm-*/system.h, xnarch_init would be the proper place.
-- 

Philippe.

