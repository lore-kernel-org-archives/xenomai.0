Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172591;
	b=FN9LLvRr/lr7BUBBF9mhI3I3knwjJj1S+Z7V/5sZtQlE1uoCfMWPecjSCoTiWJ5aZ+1m
	 Z5ip4Ok2HAC+M9n9Ze8qjmnBQSga1cdqAIzRsF1aXAuvIQQebdydnvcnCHfkdOzOaHjC0
	 uIsXb7PbmXxn4nltYFF+zBasH2Zoz+ygQCC5jghIvOzviOD7mvHOlloPiaDEpdbjExGSM
	 ALjaZcjgK2avCchsoQ5ZBD8yBxnn3zaSNxnHgISRtiFDdmHXo49xtAZgc5mpR3OmWyiXh
	 DAyTgzlq4LJi0exCWI/EKDsveAj4kNZqJvFg0LC0mRyqWGTa/R0aW/VRRvJzL4em+Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172591;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=MANXhxCkO9KG13mmOjsTTCyaWUtwhbkT85NvbjaOhZU=;
	b=p/F2nYwYeLR8lzTknloJ1VvluKSpkWufjIXYqgNYR2uXw92cvrDXdnjVk+WS4mm+V6uS
	 S3xavo5cOsUCsvSKov0pr2/zmTGZieLFnPEACuLcA1bjafzRg1eq2TAG0n5aGUfLtKhhH
	 SgWzfWSHnr9M/lYZU8g3Ki6hecWS793VvQCZzbhsrlxTBXZxagmkOn2BEvh86imkGzO45
	 ydw3/Fv0tYhRo5JHYQoJ/3gaQ99+pdOwmfqZzoJzX0CcbEBkndte8MN/a4QD9ecMJ9xyM
	 ITkGoZSiwZ2iza7HWcZrlXFOgmrAWSjmeHy+Wta2ZsaeQqb5LdbZ9AlLk+6dTABT6vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b="AznAl52/";
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51581606A320
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 11:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51581606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=AznAl52/
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 672D73ECC4
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 11:03:07 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2938F560685
	for <xenomai@xenomai.org>; Fri, 20 Nov 2026 11:03:07 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b="AznAl52/";
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::221 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=pass (policy=none) header.from=xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4CF03EBE0;
	Fri, 20 Nov 2026 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795172587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MANXhxCkO9KG13mmOjsTTCyaWUtwhbkT85NvbjaOhZU=;
	b=AznAl52/BdmspdNQ01g20pGMNX4Lvzb7xsBGu1DNc/jreVr/94P4s1spXTONyb7w1Ns1pr
	Z/6TSiPcAC6GC+e9QIOCFw15KRrhK04OQcUyos0dLlamNfrXOM14mYuoyvwka4oFk66heX
	K2JDsQFiDeOy3APBlkC1aHh2vjhsuIDsQpJZwOZVKqx4ynhRLPFXIiFsnbk1Dv7tFDHhHJ
	vE6Z2Tq9ORSZfwv/Ur/SJz24QoCr7500+aF+NhHmaHEpvKJhroCdK+QorYjrtOcbxN87fv
	NLRDA3C0AJokrQH3CykUp4XiqD3HlTZ1fyLtNWMA5I2jNFeJ34PC2s2IiNFLbw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
In-Reply-To: <216ea921-e542-40b7-b0fe-3d76649ef4b1@siemens.com> (Jan Kiszka's
	message of "Fri, 20 Nov 2026 11:45:47 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	<d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
	<576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
	<87h5hcoesz.fsf@xenomai.org>
	<c37dc798-282b-4b4d-bd9c-f2c2f498e08c@siemens.com>
	<878q2namrv.fsf@xenomai.org> <8733svam8s.fsf@xenomai.org>
	<216ea921-e542-40b7-b0fe-3d76649ef4b1@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 12:03:06 +0100
Message-ID: <87qzgf934l.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE2ndG5yHfww46EIankTZM4yz9ofjYyeIB1YNH8jLs+e7OBdAXhWyfNB+eP0XehqhuED+j+LX4r1F8i/v2VlAhJm/xFsjiD959Vi/xHGsRb1fBLJaF0ZtYwFiiijUAOhklY/PqSjnvL1xTp/Ikqq6GlvgelvJZSO5BCYx6BQkrf93fAaz83KWFjxsIqLaLQ4/qhkCN70ehV0ffe0p8siAufEIZjr66kcUj2zgEL/m2awBu/9mi+stPSMc9fhAiZIYwEG8Uu9QyGdu1yqovlQNq4zmeUCs9BfIFyDPPySGCZ71zF63lV1437+IpWyPj2HEQjfmtly7fClLstvY43YvV5C0xRB8wO0JExJx+DI+yqzDZ7VZU2Q8ddihbQAu/2IqXQFrG9n+HSLS6sI8defjEF+aYKJ5arSvSFgP+xGb8XwDiHb+aF+hRps9vTT8+lRV2gBGa6NdurffViaPIozR1HLBjXOJxJmyE1XwKBg4f3LWdAaTK9AjyvG1lWN8x95d3+o39VHz6GTQ6OvxYoQjjxxXwqP/hGIBc9JMJekauDu1N3CujAmWcK8MxQBjBfaT8dFO4KdaE3Ju3yhNMmkAfW14aLlJNK0LVFLCAENwBrGs5sFyj6oEUTcOl9S4erTHdmkOab2PUpCmR76nTaPYOwgc/I/wfYmYlyUxRkApSdXA
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 20.11.26 10:24, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 19.11.26 19:29, Philippe Gerum wrote:
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> On 11.11.26 13:10, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
>>>>>>> calls into the companion core if the flag is clear, and sets it;
>>>>>>> oob_trap_unwind() calls the exit handler and clears the flag whenever
>>>>>>> it is set.
>>>>>>>
>>>>>>> This does not cope with nested traps. A trap handler running on behalf
>>>>>>> of an oob thread may trigger another trap before it reaches its own
>>>>>>> exit annotation, e.g. a user access from an emulation handler faulting
>>>>>>> in a not yet resident page on ARM:
>>>>>>>
>>>>>>>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>>>>>>>     do_alignment_ldmstm()
>>>>>>>       ldrt/strt to user address       <- translation fault (SVC mode)
>>>>>>>         do_DataAbort()
>>>>>>>           do_page_fault()
>>>>>>>             dovetail_fault_entry()    <- notify suppressed, fine
>>>>>>>             handle_mm_fault()
>>>>>>>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>>>>>>>                                          wrong frame, and the core may
>>>>>>>                                          switch us back to oob
>>>>>>>     ...emulation continues oob...
>>>>>>>   dovetail_fault_exit()               <- no-op, flag already clear
>>>>>>>
>>>>>>> Since _TLF_OOBTRAP is per-thread and the thread does not change across
>>>>>>> nesting levels, the flag alone cannot tell which trap occurrence owns
>>>>>>> the notification. The exception frame can: every nesting level pushes
>>>>>>> its own pt_regs on the kernel stack, and the frame is already passed
>>>>>>> to both the notify and unwind helpers.
>>>>>>>
>>>>>>> Record the owning frame in the task struct when notifying, and only
>>>>>>> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
>>>>>>> exits become no-ops, the outer exit unwinds with the trap number and
>>>>>>> frame the core was notified with. oob_trap_regs can in fact encode the
>>>>>>> semantic of the _TLF_OOBTRAP flag, thus drop it.
>>>>>>>
>>>>>>> A forking parent can never be inside a trap handler, so neither the
>>>>>>> flag nor the owner frame can legitimately be set when a new task
>>>>>>> inherits its state. Add a debug assertion for this in
>>>>>>> inband_task_init(), which turns an unbalanced trap entry into a
>>>>>>> loud warning on the next fork instead of silently propagating the
>>>>>>> stuck state to the children.
>>>>>>>
>>>>>>> Assisted-by: opencode:Fable-5.1
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> ---
>>>>>>>  arch/arm/include/asm/thread_info.h   |  1 -
>>>>>>>  arch/arm64/include/asm/thread_info.h |  1 -
>>>>>>>  arch/riscv/include/asm/thread_info.h |  1 -
>>>>>>>  arch/x86/include/asm/thread_info.h   |  2 --
>>>>>>>  include/linux/dovetail.h             | 12 ++++++++++--
>>>>>>>  include/linux/sched.h                |  5 +++++
>>>>>>>  kernel/dovetail.c                    | 10 ++++++++--
>>>>>>>  7 files changed, 23 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>>>>>> index 23cae59037c1e..12ab7e49b7b76 100644
>>>>>>> --- a/arch/arm/include/asm/thread_info.h
>>>>>>> +++ b/arch/arm/include/asm/thread_info.h
>>>>>>> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>>>>>  #define _TLF_OOB		0x0001
>>>>>>>  #define _TLF_DOVETAIL		0x0002
>>>>>>>  #define _TLF_OFFSTAGE		0x0004
>>>>>>> -#define _TLF_OOBTRAP		0x0008
>>>>>>>  
>>>>>>>  #endif /* __KERNEL__ */
>>>>>>>  #endif /* __ASM_ARM_THREAD_INFO_H */
>>>>>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>>>>>> index 48563d782a99a..934b080246146 100644
>>>>>>> --- a/arch/arm64/include/asm/thread_info.h
>>>>>>> +++ b/arch/arm64/include/asm/thread_info.h
>>>>>>> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>>>>>>>  #define _TLF_OOB			0x0001
>>>>>>>  #define _TLF_DOVETAIL			0x0002
>>>>>>>  #define _TLF_OFFSTAGE			0x0004
>>>>>>> -#define _TLF_OOBTRAP			0x0008
>>>>>>>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>>>>>>>  
>>>>>>>  #endif /* __ASM_THREAD_INFO_H */
>>>>>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>>>>>> index 820a596d9bf65..11164e12317fa 100644
>>>>>>> --- a/arch/riscv/include/asm/thread_info.h
>>>>>>> +++ b/arch/riscv/include/asm/thread_info.h
>>>>>>> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>>>>>>  #define _TLF_OOB		0x0001
>>>>>>>  #define _TLF_DOVETAIL		0x0002
>>>>>>>  #define _TLF_OFFSTAGE		0x0004
>>>>>>> -#define _TLF_OOBTRAP		0x0008
>>>>>>>  
>>>>>>>  #endif /* _ASM_RISCV_THREAD_INFO_H */
>>>>>>
>>>>>> This hunk was forgotten while merging the patch.
>>>>>>
>>>>>> Jan
>>>>>
>>>>> Not sure how that can ever happen since I'm applying patches with mu4e
>>>>> directly from the MUA (mu4e-action-git-apply-mbox). Anyway, ... fixed.
>>>>>
>>>>
>>>> Please fold the fixup commit into the original one, or we will have this
>>>> commit twice in the 7.3 and 7.2 trees.
>>>>
>>>
>>> Not yet, this will go away when the whole stack is squashed per topic
>>> next time.
>> 
>> Unless it breaks some of your tooling.. But if you can live with it
>> until dovetail 7.4 is out, this duplicate will be gone by then.
>> 
>
> 7.3 is likely the next LTS. Latest by then, this inconsistency should be
> cleanups as that tree would live longer.
>

Makes sense, will fold it then.

-- 
Philippe.
