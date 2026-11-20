Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166010;
	b=Kqoze5O2UyjYzd1/D10OoenP28IeV6k6pIL2z4e/LJL6fc57S7h7S+t6t6bnpk5V2Yb6
	 W1AA5QbRwarULvAOU0ZGw+0E68jiMvd6WqOggBqiTKa1Wf28jKXGeMPbmxBNTu/iCQtms
	 jIkDRpz3lSpXFyQMM6kOvV+QzDskXXxW05kkPrKm9AwuqA71iliVBHDXgkMfJduiTid4I
	 dnupV1bm3h7uuR6B1aL1WV4j5mSY7sm78dopC4TnrnQz3QWjlq0/xURTA2VuP62/IMw1t
	 a7Gazbj8y8w+6Uc+hGf5ec+RFgmkqRuT0u5xgrOp8lsZwRSUJVmk5POkoEgxkIF4EBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166010;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=rlWUpQUEmZJZgzGm9+ZMyY1MxyzVzkH2iOF0Ux79FUo=;
	b=Uk+j6KSxPfjNvIa6gonwAAw/DfZcZxuO2+RzJM/YnTDJK4VdihigPrn5l0aF3vz2tBu4
	 YGXaxiW0SPrj3WTH3M958qXpQ7H1Kq0qE0CQr6hN3REerGGuv5+OxOxmMEfqZYTl6GnoW
	 TcvXV+hmeBPI9WdDdvsfqxS/RiY41+IZbKG2uu0Es1UZQsnKYdj6Ag15x3ZE47QFjFR6o
	 BZ650YwjsUCTDY4DHTMYToxN5lq8IVKTtsq3j7bViuOdEJiNWrYrElcPYLwrvIoDbnQsx
	 Dt401uKmee2UYIAEgzUtVcBHdFN4/p30QH4/6TSscQNDqvbEApIwz8Zl9Dj9LlokdTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=AaLkbSvZ;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F244606A320
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 09:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F244606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=AaLkbSvZ
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 20CC73ECB3
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 09:13:26 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D7D6E5604AB
	for <xenomai@xenomai.org>; Fri, 20 Nov 2026 09:13:25 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=AaLkbSvZ;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.201 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=pass (policy=none) header.from=xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7347A3E809;
	Fri, 20 Nov 2026 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795166005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlWUpQUEmZJZgzGm9+ZMyY1MxyzVzkH2iOF0Ux79FUo=;
	b=AaLkbSvZqaPLP2YNu9ERdTe1Pu9hHUw210lDUlQ1/7eCjAWYlK/inCinudtMeumsasOr14
	+eYxjW2IdXIkU73o+hDfqjmybFfTDpxQiFQLNc5dkWWcn49PLSLHtahXvV7utX+mNgnWvc
	OdKiRqY2qyrAzVNx1OULLMSd8XXDJ0NwBk3SYTsl0C8gc929cMpX6Qlrl3cUeRbI+thTNR
	OGwYpRRtG3yn23b7lCX45qehfV5wcDKHkMBprgRmYGl9aGV6CaR2YbUQzeLkb2YJJJIV1k
	laEWTNzRazYpYQfMe7kObRE8TUki9k22d7cKuT/5wg8eSniUqjlzMxrW/qt/DA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
In-Reply-To: <c37dc798-282b-4b4d-bd9c-f2c2f498e08c@siemens.com> (Jan Kiszka's
	message of "Fri, 20 Nov 2026 07:24:00 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	<d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
	<576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
	<87h5hcoesz.fsf@xenomai.org>
	<c37dc798-282b-4b4d-bd9c-f2c2f498e08c@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 10:13:24 +0100
Message-ID: <878q2namrv.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEuJRn48ZaisCvF0HpxDgIuXlMwJXpN0Yj4Df9Z8dcqHKk2m05ccDe+Fr3rZR6xp5zO6ijT2Am32LGaeVCxfvMmD7AP/eaQJUIw8YyL9Y2nbyXXcCP4W6MTf33TbkQyu4lcvIYRJy/OXnmqhzGVgSp190FVTXAhcuVInir0hTrMh7OdYLDNMiYQc7HBN3TYwgNtqa2F6osOj8mkDgzVYjAiFlHXw2UEXMBzCfODn3nq3PiIi32ckEX4EYeRX1b8QgsD5fPDw35Z8avyVxFNfcUTiK7paxUVjlpTmPH2pmCLRKfN0N6OH2d8IBvYzIoBoWXtYzbiDdhBhagdSsAmHQOatIVBGhqvXubljgZxvRipkJY7JrcCe16rrzP5Hh82AMf68hGdgLh5QQNM0yk2cF081/NJ2BrDXiKxuv2iTaTZWt9+zZSX8r9OopIGxo73RG3sdlHec79eCIc56+m1SOU9DryrsSR5zOo20k5ou0qyJacsDGZad3DRW2lAymJJfSH8Gk1Bb+nA9xr5t0XMFhQaPujDQmAXcAaFnAv1RI/U2ozk3D1zapuX+tZVsKifCRu5AxllQyCga3PALmKNk8u2X7w8BS2Cr6Az2LU6z86lRMxL28EDoxtBCnQjjrgM/2ESUeTPyl8n2QR711ZcBKx22aRpUYPVY04JX+mJL8zuEg
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 19.11.26 19:29, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 11.11.26 13:10, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
>>>> calls into the companion core if the flag is clear, and sets it;
>>>> oob_trap_unwind() calls the exit handler and clears the flag whenever
>>>> it is set.
>>>>
>>>> This does not cope with nested traps. A trap handler running on behalf
>>>> of an oob thread may trigger another trap before it reaches its own
>>>> exit annotation, e.g. a user access from an emulation handler faulting
>>>> in a not yet resident page on ARM:
>>>>
>>>>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>>>>     do_alignment_ldmstm()
>>>>       ldrt/strt to user address       <- translation fault (SVC mode)
>>>>         do_DataAbort()
>>>>           do_page_fault()
>>>>             dovetail_fault_entry()    <- notify suppressed, fine
>>>>             handle_mm_fault()
>>>>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>>>>                                          wrong frame, and the core may
>>>>                                          switch us back to oob
>>>>     ...emulation continues oob...
>>>>   dovetail_fault_exit()               <- no-op, flag already clear
>>>>
>>>> Since _TLF_OOBTRAP is per-thread and the thread does not change across
>>>> nesting levels, the flag alone cannot tell which trap occurrence owns
>>>> the notification. The exception frame can: every nesting level pushes
>>>> its own pt_regs on the kernel stack, and the frame is already passed
>>>> to both the notify and unwind helpers.
>>>>
>>>> Record the owning frame in the task struct when notifying, and only
>>>> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
>>>> exits become no-ops, the outer exit unwinds with the trap number and
>>>> frame the core was notified with. oob_trap_regs can in fact encode the
>>>> semantic of the _TLF_OOBTRAP flag, thus drop it.
>>>>
>>>> A forking parent can never be inside a trap handler, so neither the
>>>> flag nor the owner frame can legitimately be set when a new task
>>>> inherits its state. Add a debug assertion for this in
>>>> inband_task_init(), which turns an unbalanced trap entry into a
>>>> loud warning on the next fork instead of silently propagating the
>>>> stuck state to the children.
>>>>
>>>> Assisted-by: opencode:Fable-5.1
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  arch/arm/include/asm/thread_info.h   |  1 -
>>>>  arch/arm64/include/asm/thread_info.h |  1 -
>>>>  arch/riscv/include/asm/thread_info.h |  1 -
>>>>  arch/x86/include/asm/thread_info.h   |  2 --
>>>>  include/linux/dovetail.h             | 12 ++++++++++--
>>>>  include/linux/sched.h                |  5 +++++
>>>>  kernel/dovetail.c                    | 10 ++++++++--
>>>>  7 files changed, 23 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>>> index 23cae59037c1e..12ab7e49b7b76 100644
>>>> --- a/arch/arm/include/asm/thread_info.h
>>>> +++ b/arch/arm/include/asm/thread_info.h
>>>> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>>  #define _TLF_OOB		0x0001
>>>>  #define _TLF_DOVETAIL		0x0002
>>>>  #define _TLF_OFFSTAGE		0x0004
>>>> -#define _TLF_OOBTRAP		0x0008
>>>>  
>>>>  #endif /* __KERNEL__ */
>>>>  #endif /* __ASM_ARM_THREAD_INFO_H */
>>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>>> index 48563d782a99a..934b080246146 100644
>>>> --- a/arch/arm64/include/asm/thread_info.h
>>>> +++ b/arch/arm64/include/asm/thread_info.h
>>>> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>>>>  #define _TLF_OOB			0x0001
>>>>  #define _TLF_DOVETAIL			0x0002
>>>>  #define _TLF_OFFSTAGE			0x0004
>>>> -#define _TLF_OOBTRAP			0x0008
>>>>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>>>>  
>>>>  #endif /* __ASM_THREAD_INFO_H */
>>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>>> index 820a596d9bf65..11164e12317fa 100644
>>>> --- a/arch/riscv/include/asm/thread_info.h
>>>> +++ b/arch/riscv/include/asm/thread_info.h
>>>> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>>>  #define _TLF_OOB		0x0001
>>>>  #define _TLF_DOVETAIL		0x0002
>>>>  #define _TLF_OFFSTAGE		0x0004
>>>> -#define _TLF_OOBTRAP		0x0008
>>>>  
>>>>  #endif /* _ASM_RISCV_THREAD_INFO_H */
>>>
>>> This hunk was forgotten while merging the patch.
>>>
>>> Jan
>> 
>> Not sure how that can ever happen since I'm applying patches with mu4e
>> directly from the MUA (mu4e-action-git-apply-mbox). Anyway, ... fixed.
>> 
>
> Please fold the fixup commit into the original one, or we will have this
> commit twice in the 7.3 and 7.2 trees.
>

Not yet, this will go away when the whole stack is squashed per topic
next time.

-- 
Philippe.
