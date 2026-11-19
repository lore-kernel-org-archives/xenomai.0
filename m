Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795112982;
	b=Ebt+1GaVUMbwjruHu+qeGgclxRZx+9Wnh9D0HP7U4UxUOeOPOEH7Qp3cPt6iluWAEx5d
	 2o5AHN17yb/uy5CGyD/JV3lgBfh1DiNHgR9IenSglC09RHPhaDqvz9NNlPIje8O4UR+M6
	 G997qgPiGOZdMDkKwy/DRz10drdcdl0gwe30MwEwT7fRQ39Z0dQX6guuuYeDfnepBQN3x
	 n8WLvEDTWVoKEF8+tr/dtydz35zZSzQRdmOZOAhFyv63d0t1cbo8dsk834K9pmQOFILM+
	 hlWlMVuj0JDFLlCn7K8+FpqXs1lvbiH/TMsSFDWGHDGkSrV8KAEYN9rolIFAok2B0Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795112982;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=7XM5McGHGmiwrs4g2LTGn1vy/tHwZBwH+fJaNNdJ52M=;
	b=zNiQCtT77wvfZvJByNDtDNqYKnOgPo0lgNHUmOsW11Ln3AsVjF+nbP2VK6jREUy/3TgW
	 eaU4NYmUKzSym2GMOaFZyunduDtAttgbVEHIyNrmvJ1NWRDYNcVm0qfQjIT86T3GiHqlh
	 A6MdoiUVPybFgg2AunnwshOEc6w/AjBo+mlkY0DtwcdZGO9t8ZXs/rEzMvkQ0Q9ghF2IA
	 crzsoBqU+FcLdnynxPxM99lNkGAp5QiaB2S/RAuacQJDeqQBDP0l5SoHr7yN89ep/8SPi
	 wOa60rZ8NSe/KE1e8MTtsQDag6CNecuvnczKOkIw+YXAz/A/1eo+SAMl9FSZHbPlouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Mdann2CB;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEB606A334
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 18:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39AEB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Mdann2CB
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 981EE3E88B
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 18:29:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 608B727E0030
	for <xenomai@xenomai.org>; Thu, 19 Nov 2026 18:29:33 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=Mdann2CB;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.197 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=pass (policy=none) header.from=xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id E25213E96B;
	Thu, 19 Nov 2026 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795112973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XM5McGHGmiwrs4g2LTGn1vy/tHwZBwH+fJaNNdJ52M=;
	b=Mdann2CBt+6JdLhWMPPBiT7InaQmcP7uarf7i8CpIelWjgd/1MJFqr4/p4oEHGLpG0qt0G
	SuJKEh9dmgQU9DjEyy9Gjk8ecLbo0ruWD4KrR7oVcyVYaL0NzmD9uDf6oJ93tZgnhmt2+o
	Neh3ePjJ1vxMA7oLvEyiK/65LT6QrL3i3fOdLlLRR0pa96irMEAY2jgtXh+/sP2DPVpVgT
	5HFVZEUO25amWLZ2C8DF7lULSrlfZQl9M8duZ88uhNS6tkcaJ7mEl5Rog4KQLnDegfdJum
	ugCLUIbFNHD0ylMpymCjAPtHESybHx8TA+xhtou+upI1aQU3maEpyYv0MRSM0A==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
In-Reply-To: <576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com> (Jan Kiszka's
	message of "Thu, 19 Nov 2026 17:52:59 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	<d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
	<576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 19:29:32 +0100
Message-ID: <87h5hcoesz.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFUz/5/55GzfDisfK9sozcF2sOtpliGYY/v40COfNz/i3mOYDFYF0WxkCYQ7YioDfrcMD0U+IWZ9TP2E3EyK4/tjUam+TXNM685QAH769pZvLQJMqi76uiSco6MnN/xZyOHm2WZr82BF8JEFPv4x5+bncI0oRdW+TBQYWMe8+7dfTnMW/EKh0BCLuIhn0TOWzTxJfvNAZBFyuqdoJI8HOIrEHOYn48oVLC5NSHXCkyKaPGZiYMjr40+2cN1aHMDmD2l7ltDA8H8RJ0Pqhpudtd/SE4cS9er1Ek1GCbyMDmtYpz8dMcO1kcufKefjyqk2npsI4xms1o6F1YQBalvJnsgFmd6NoIftacrQjhYuEarMp453ihhyG/Kf/qOLYi+A9YsefRT+O8Gejj9u/Enz3FJw5to2FvXyua0n/099sQWQ3893B0Ck2pdILqOjpLzToncJDWkhUhPQf1ToYIqqTuoAYVq6KABQhJqZabxX4gDCclfeZunkCT4nVPrUPWKKnfHG/ubxoGNap4tl9gBTt/pxXvMSALlriIA8CykgEOl9fq1HIyjlDSuy9SNYdQ9tac8/HsWoFzGla5j5Lknt/65tUtHNgL7QOLq1LvnBYkdThHyocxMgIVs6FAZcJrCYnCbMBxnPIphcn4La8Sm8HLYzOKY4S3Nta07oxWZ6w0neQ
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.11.26 13:10, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
>> calls into the companion core if the flag is clear, and sets it;
>> oob_trap_unwind() calls the exit handler and clears the flag whenever
>> it is set.
>> 
>> This does not cope with nested traps. A trap handler running on behalf
>> of an oob thread may trigger another trap before it reaches its own
>> exit annotation, e.g. a user access from an emulation handler faulting
>> in a not yet resident page on ARM:
>> 
>>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>>     do_alignment_ldmstm()
>>       ldrt/strt to user address       <- translation fault (SVC mode)
>>         do_DataAbort()
>>           do_page_fault()
>>             dovetail_fault_entry()    <- notify suppressed, fine
>>             handle_mm_fault()
>>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>>                                          wrong frame, and the core may
>>                                          switch us back to oob
>>     ...emulation continues oob...
>>   dovetail_fault_exit()               <- no-op, flag already clear
>> 
>> Since _TLF_OOBTRAP is per-thread and the thread does not change across
>> nesting levels, the flag alone cannot tell which trap occurrence owns
>> the notification. The exception frame can: every nesting level pushes
>> its own pt_regs on the kernel stack, and the frame is already passed
>> to both the notify and unwind helpers.
>> 
>> Record the owning frame in the task struct when notifying, and only
>> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
>> exits become no-ops, the outer exit unwinds with the trap number and
>> frame the core was notified with. oob_trap_regs can in fact encode the
>> semantic of the _TLF_OOBTRAP flag, thus drop it.
>> 
>> A forking parent can never be inside a trap handler, so neither the
>> flag nor the owner frame can legitimately be set when a new task
>> inherits its state. Add a debug assertion for this in
>> inband_task_init(), which turns an unbalanced trap entry into a
>> loud warning on the next fork instead of silently propagating the
>> stuck state to the children.
>> 
>> Assisted-by: opencode:Fable-5.1
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm/include/asm/thread_info.h   |  1 -
>>  arch/arm64/include/asm/thread_info.h |  1 -
>>  arch/riscv/include/asm/thread_info.h |  1 -
>>  arch/x86/include/asm/thread_info.h   |  2 --
>>  include/linux/dovetail.h             | 12 ++++++++++--
>>  include/linux/sched.h                |  5 +++++
>>  kernel/dovetail.c                    | 10 ++++++++--
>>  7 files changed, 23 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>> index 23cae59037c1e..12ab7e49b7b76 100644
>> --- a/arch/arm/include/asm/thread_info.h
>> +++ b/arch/arm/include/asm/thread_info.h
>> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>  #define _TLF_OOB		0x0001
>>  #define _TLF_DOVETAIL		0x0002
>>  #define _TLF_OFFSTAGE		0x0004
>> -#define _TLF_OOBTRAP		0x0008
>>  
>>  #endif /* __KERNEL__ */
>>  #endif /* __ASM_ARM_THREAD_INFO_H */
>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>> index 48563d782a99a..934b080246146 100644
>> --- a/arch/arm64/include/asm/thread_info.h
>> +++ b/arch/arm64/include/asm/thread_info.h
>> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>>  #define _TLF_OOB			0x0001
>>  #define _TLF_DOVETAIL			0x0002
>>  #define _TLF_OFFSTAGE			0x0004
>> -#define _TLF_OOBTRAP			0x0008
>>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>>  
>>  #endif /* __ASM_THREAD_INFO_H */
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> index 820a596d9bf65..11164e12317fa 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>  #define _TLF_OOB		0x0001
>>  #define _TLF_DOVETAIL		0x0002
>>  #define _TLF_OFFSTAGE		0x0004
>> -#define _TLF_OOBTRAP		0x0008
>>  
>>  #endif /* _ASM_RISCV_THREAD_INFO_H */
>
> This hunk was forgotten while merging the patch.
>
> Jan

Not sure how that can ever happen since I'm applying patches with mu4e
directly from the MUA (mu4e-action-git-apply-mbox). Anyway, ... fixed.

-- 
Philippe.
