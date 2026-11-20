Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166695;
	b=klizofxjDUHE9ywLz0f7j5pGyMeMmlYdULdZlm0wDdKGR2BuuKuMnQkO4S6IAIh3t7na
	 cKpjonG9AOcyRmIu2mQeLcw5P1XnTjafmKJGgNTFP25WcR2SmKl4a2fBc0lBPGMJz1kBm
	 0uvAg+B8Gg3yOeJ9D5lgopr71641GK7/FTvDbITwOalgJjE/VZjauXytQbgy7cUjbimGL
	 gN8hfml72lM5Vr/9Px4neHrG1sCO3SegmXOlLq6PLrR9DVLtIrlaDUTHI2RUZRJiVd5bA
	 /hLjJzlQJv8LJMOQ8AYacxOKRVMZJQCLAmK9C7vAvRM3nYmbwT9EWagL2yb9XAADdGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166695;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=6pyqNkOFev8eY5eURhNeNUYlUVmZlAdmLqIhFOcGjn0=;
	b=h7OOnlLl3XhvkBMDzClkkNAVboKamJUwkLybNugLD0KIa1ueiOryfTAR1KXIRDgFFmUp
	 fK79OusvqIpp0BdpYWEabsn7b8XS5pjE182pZ1OGgFjymy2qWVzPrxlrFBnfvD7aW6lO7
	 WUG3jKmKIsqkEZO3ttkJLsFUCjIEII0LUQInWTQ2LNgmq4pAF/QSju9XoubBHJmMvwWXe
	 otV5GyZo9kyFWtkaImKlojVb65bBU2QlR0VpWiSJ0fDK098Vfz9sh49JaNhaJK5tyI6Qs
	 9OhcB0j+vMCBWuIN6Am1DvIIbGfBs022/AI+lPE+H0xZv+rrX131tk6VIJP+Hqfbrrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b="W/miOGcx";
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D8606A320
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 09:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=W/miOGcx
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 7F8193ECBD
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 09:24:52 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 437CD27E0107
	for <xenomai@xenomai.org>; Fri, 20 Nov 2026 09:24:52 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b="W/miOGcx";
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.197 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=pass (policy=none) header.from=xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD51E3EB86;
	Fri, 20 Nov 2026 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795166692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6pyqNkOFev8eY5eURhNeNUYlUVmZlAdmLqIhFOcGjn0=;
	b=W/miOGcxuOHDPU1bDDX5XAyApnYcEj64RSWIBuU9kj9Mxa/CZbAqL7iDb4Zy3/zVDBhhNZ
	VEWcrL9cW4tgUCSP9aZdrHHcpTgsBCuwvOz9LaAcqpRS8GI2fUiJEDvkuovI7PV3FIFm+v
	/TU8SC0/CVhEhP79CAK7xw0Ib9d1IWTj8IvJPhM4Zgx4Sv82jsWTb9+9KYVSikJMDXrb8B
	z0apj4hGGk29j/kMa2u+M+8lBi7Dz4D0ypqBhXzcWhup7Vv9Z4WDOgOz4Ox42I8YbyQ4yQ
	dhsk8Dld5vRCRVJnQfk+FuRF351Uy5u3rmnLIwIuWP1YgGoRVUyn3SgAcJUPng==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
In-Reply-To: <878q2namrv.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	20 Nov 2026 10:13:24 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	<d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
	<576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
	<87h5hcoesz.fsf@xenomai.org>
	<c37dc798-282b-4b4d-bd9c-f2c2f498e08c@siemens.com>
	<878q2namrv.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 10:24:51 +0100
Message-ID: <8733svam8s.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Cause: dmFkZTEagn+ADkzinwJk3FzikFIdv6O/YJ/F9Mpt/FtnAkQJVk0Pk3qz604yeFhTujMWGdRfF1ZQyMoPRJ6vRUrRyyuypWpv87N4Bl7tRNr+iM1HkioS+dkX9uGm8GOE+iavyEX9M4+QvanbC6+JyO9k+qZ1agN85/i8DBShAMX44kYORHqEhzAByraHQjJ18P9+P+60DjWRm7y1n8b0QwJHdhgenc3RhMG09JYhEa5XWW/IrIssfJRbKWKyuE76lpJwLzRLT6+ZojgMdv3bgc+7SAtR1N44wVHrE2fE61iGfuzWa/d6pmy5/W0srNZTTgcMP4qyyVIWJCRYJY/yyfkhY24sY4niG9Iy5XfDSKkrkl2A6XcghnNzP78KQTnkJPYbkl6Ts6VsL/ERU3SpZ62yhaAifgPdsxIsMFejTTvEjUOe1sTUOIcpxtAP9juQtJGQphFMD/BVXmSJSFP5MqnEv4dm7fWLwF/WvXBZuYJVRkXuZrowO3F3LiRgXRG6qu8o77ihq+Q1UdOUfPGR3cC4VTYdWS4nCsoZW5dyZh/F8ly6WyPaZOy6JaZz+RgZF+ptAjN49ypJvy1VPbBmSEoQ1T0gVwEvI3SyLi05GcJ7BhqqzvV/Lx9Ds7FQ3b2F3nFKI/7dRj/y4Pqm2LDSOeI77GJHtYQjw3Nfv8GkTvueo1laZw
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 19.11.26 19:29, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>> 
>>>> On 11.11.26 13:10, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
>>>>> calls into the companion core if the flag is clear, and sets it;
>>>>> oob_trap_unwind() calls the exit handler and clears the flag whenever
>>>>> it is set.
>>>>>
>>>>> This does not cope with nested traps. A trap handler running on behalf
>>>>> of an oob thread may trigger another trap before it reaches its own
>>>>> exit annotation, e.g. a user access from an emulation handler faulting
>>>>> in a not yet resident page on ARM:
>>>>>
>>>>>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>>>>>     do_alignment_ldmstm()
>>>>>       ldrt/strt to user address       <- translation fault (SVC mode)
>>>>>         do_DataAbort()
>>>>>           do_page_fault()
>>>>>             dovetail_fault_entry()    <- notify suppressed, fine
>>>>>             handle_mm_fault()
>>>>>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>>>>>                                          wrong frame, and the core may
>>>>>                                          switch us back to oob
>>>>>     ...emulation continues oob...
>>>>>   dovetail_fault_exit()               <- no-op, flag already clear
>>>>>
>>>>> Since _TLF_OOBTRAP is per-thread and the thread does not change across
>>>>> nesting levels, the flag alone cannot tell which trap occurrence owns
>>>>> the notification. The exception frame can: every nesting level pushes
>>>>> its own pt_regs on the kernel stack, and the frame is already passed
>>>>> to both the notify and unwind helpers.
>>>>>
>>>>> Record the owning frame in the task struct when notifying, and only
>>>>> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
>>>>> exits become no-ops, the outer exit unwinds with the trap number and
>>>>> frame the core was notified with. oob_trap_regs can in fact encode the
>>>>> semantic of the _TLF_OOBTRAP flag, thus drop it.
>>>>>
>>>>> A forking parent can never be inside a trap handler, so neither the
>>>>> flag nor the owner frame can legitimately be set when a new task
>>>>> inherits its state. Add a debug assertion for this in
>>>>> inband_task_init(), which turns an unbalanced trap entry into a
>>>>> loud warning on the next fork instead of silently propagating the
>>>>> stuck state to the children.
>>>>>
>>>>> Assisted-by: opencode:Fable-5.1
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>  arch/arm/include/asm/thread_info.h   |  1 -
>>>>>  arch/arm64/include/asm/thread_info.h |  1 -
>>>>>  arch/riscv/include/asm/thread_info.h |  1 -
>>>>>  arch/x86/include/asm/thread_info.h   |  2 --
>>>>>  include/linux/dovetail.h             | 12 ++++++++++--
>>>>>  include/linux/sched.h                |  5 +++++
>>>>>  kernel/dovetail.c                    | 10 ++++++++--
>>>>>  7 files changed, 23 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>>>> index 23cae59037c1e..12ab7e49b7b76 100644
>>>>> --- a/arch/arm/include/asm/thread_info.h
>>>>> +++ b/arch/arm/include/asm/thread_info.h
>>>>> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>>>  #define _TLF_OOB		0x0001
>>>>>  #define _TLF_DOVETAIL		0x0002
>>>>>  #define _TLF_OFFSTAGE		0x0004
>>>>> -#define _TLF_OOBTRAP		0x0008
>>>>>  
>>>>>  #endif /* __KERNEL__ */
>>>>>  #endif /* __ASM_ARM_THREAD_INFO_H */
>>>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>>>> index 48563d782a99a..934b080246146 100644
>>>>> --- a/arch/arm64/include/asm/thread_info.h
>>>>> +++ b/arch/arm64/include/asm/thread_info.h
>>>>> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>>>>>  #define _TLF_OOB			0x0001
>>>>>  #define _TLF_DOVETAIL			0x0002
>>>>>  #define _TLF_OFFSTAGE			0x0004
>>>>> -#define _TLF_OOBTRAP			0x0008
>>>>>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>>>>>  
>>>>>  #endif /* __ASM_THREAD_INFO_H */
>>>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>>>> index 820a596d9bf65..11164e12317fa 100644
>>>>> --- a/arch/riscv/include/asm/thread_info.h
>>>>> +++ b/arch/riscv/include/asm/thread_info.h
>>>>> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>>>>  #define _TLF_OOB		0x0001
>>>>>  #define _TLF_DOVETAIL		0x0002
>>>>>  #define _TLF_OFFSTAGE		0x0004
>>>>> -#define _TLF_OOBTRAP		0x0008
>>>>>  
>>>>>  #endif /* _ASM_RISCV_THREAD_INFO_H */
>>>>
>>>> This hunk was forgotten while merging the patch.
>>>>
>>>> Jan
>>> 
>>> Not sure how that can ever happen since I'm applying patches with mu4e
>>> directly from the MUA (mu4e-action-git-apply-mbox). Anyway, ... fixed.
>>> 
>>
>> Please fold the fixup commit into the original one, or we will have this
>> commit twice in the 7.3 and 7.2 trees.
>>
>
> Not yet, this will go away when the whole stack is squashed per topic
> next time.

Unless it breaks some of your tooling.. But if you can live with it
until dovetail 7.4 is out, this duplicate will be gone by then.

-- 
Philippe.
