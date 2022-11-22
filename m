Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F410FD
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 10:39:15 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 15870100004;
	Tue, 22 Nov 2022 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669113553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX9BxOw/fPRCkVuCxJtg3NYwi1C2JwB0Brv1BO6yqz0=;
	b=PKWD9V9gkXd4s2xLd/ueFhGGFNoINLYkXFWKjRyQ1Dhy3f7k2bmxlKoIjwRj5tW5vNIQWi
	BYau/X/5vXQSpFLLxnj+Zt6BZMS8eIvdV1hZ0ZcH+S8UYnvw74U2GU6aAnL3N45ofWGJq+
	93992i2NWyh2JgG9UlSWJaeIFsy/HnCArZDbUgAcngosaEHbr9VRaz4hCPB5sU2TgT3zLw
	ao1d2d+phykwGbJxG9VQO3bGlpUXjWRMsc9KvXCYEVoBiPiLC4hG9OAMiQqzJh+qDGltXd
	isa3l0/++x/3VqFjlGBkKvcj7pQVDIFfD8e5gLVzB4/Ref9jmwpLD3xTFqCn5g==
References: <0835bd39-0dc8-e767-b39d-ee316f6b7ffd@siemens.com>
 <87a64j9zxm.fsf@xenomai.org>
 <0d485cdd-62eb-37e0-c60c-826565d957b4@siemens.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: "suspicious RCU usage" in heapcheck driver
Date: Tue, 22 Nov 2022 11:38:04 +0100
In-reply-to: <0d485cdd-62eb-37e0-c60c-826565d957b4@siemens.com>
Message-ID: <875yf79stt.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 22.11.22 09:00, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> while preparing Xenomai for recent kernels, switching prandom_u32 to
>>> get_random_u32 [1], I triggered some RCU warning:
>>>
>>> [  515.060011] =============================
>>> [  515.060011] WARNING: suspicious RCU usage
>>> [  515.060012] 6.1.0-rc5+ #10 Not tainted
>>> [  515.060014] -----------------------------
>>> [  515.060014] ../include/linux/rcupdate.h:740 rcu_read_lock() used
>>> illegally while idle!
>>> [  515.060017]
>>> [  515.060017] other info that might help us debug this:
>>> [  515.060017]
>>> [  515.060017]
>>> [  515.060017] rcu_scheduler_active = 2, debug_locks = 1
>>> [  515.060019] RCU used illegally from extended quiescent state!
>>> [  515.060019] 1 lock held by smokey/1435:
>>> [  515.060021]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>> __is_insn_slot_addr+0x5/0x120
>>> [  515.060049]
>>> [  515.060049] stack backtrace:
>>> [  515.060050] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>>> [  515.060053] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>>> [  515.060054] IRQ stage: Xenomai
>>> [  515.060055] Call Trace:
>>> [  515.060056]  <TASK>
>>> [  515.060058]
>>> [  515.060058] =============================
>>> [  515.060059] WARNING: suspicious RCU usage
>>> [  515.060060] 6.1.0-rc5+ #10 Not tainted
>>> [  515.060061] -----------------------------
>>> [  515.060061] ../include/linux/rcupdate.h:768 rcu_read_unlock() used
>>> illegally while idle!
>>> [  515.060063]
>>> [  515.060063] other info that might help us debug this:
>>> [  515.060063]
>>> [  515.060063]
>>> [  515.060063] rcu_scheduler_active = 2, debug_locks = 1
>>> [  515.060065] RCU used illegally from extended quiescent state!
>>> [  515.060065] 2 locks held by smokey/1435:
>>> [  515.060067]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>> __is_insn_slot_addr+0x5/0x120
>>> [  515.060073]  #1: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>> __is_insn_slot_addr+0x5/0x120
>>> [  515.060078]
>>> [  515.060078] stack backtrace:
>>> [  515.060078] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>>> [  515.060081] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>>> [  515.060082] IRQ stage: Xenomai
>>> [  515.060083] Call Trace:
>>> [  515.060084]  <TASK>
>>> [  515.060086]  dump_stack_lvl+0x7d/0xb5
>>> [  515.060106]  __is_insn_slot_addr+0x10e/0x120
>>> [  515.060112]  kernel_text_address+0xbf/0xd0
>>> [  515.060126]  __kernel_text_address+0xe/0x40
>>> [  515.060129]  show_trace_log_lvl+0x18c/0x3f0
>>> [  515.060152]  ? dump_stack_lvl+0x7d/0xb5
>>> [  515.060162]  dump_stack_lvl+0x7d/0xb5
>>> [  515.060168]  __is_insn_slot_addr+0xd8/0x120
>>> [  515.060171]  kernel_text_address+0xbf/0xd0
>>> [  515.060176]  __kernel_text_address+0xe/0x40
>>> [  515.060179]  show_trace_log_lvl+0x18c/0x3f0
>>> [  515.060196]  ? dump_stack_lvl+0x7d/0xb5
>>> [  515.060206]  dump_stack_lvl+0x7d/0xb5
>>> [  515.060212]  inband_irq_save+0xa/0x30
>>> [  515.060215]  get_random_u32+0x2f/0x230
>>> [  515.060228]  heapcheck_ioctl+0xa42/0xbb0
>>> [  515.060244]  ? ktime_get_mono_fast_ns+0x3b/0xa0
>>> [  515.060260]  ? rtdm_fd_ioctl+0xec/0x340
>>> [  515.060270]  rtdm_fd_ioctl+0xec/0x340
>>> [  515.060284]  ? CoBaLt_fcntl+0x20/0x20
>>> [  515.060286]  CoBaLt_ioctl+0xa/0x20
>>> [  515.060288]  handle_head_syscall+0x115/0x5c0
>>> [  515.060301]  pipeline_syscall+0x85/0x120
>>> [  515.060307]  syscall_enter_from_user_mode+0x3f/0xa0
>>> [  515.060312]  do_syscall_64+0x15/0xb0
>>> [  515.060317]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> From my understanding of the code path we are taking here, it's a non-RT
>>> IOCTL that should be fine to take random Linux locks or disable Linux
>>> IRQs. But 5.10, 5.15 and 6.1 all complain about being idle here. Any
>>> idea where we may confuse lockdep?
>> 
>> This syscall is processed from the head stage otherwise it would have
>> been routed to handle_root_syscall() I believe, so the issue is most
>> likely with rcu_is_watching(). There is a fix for this in the linux-evl
>> tree [1], still in the -next branch ATM, will be upstreamed soon.
>> 
>> [1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/03d19b028241d0385ea72e91481d7468d806ffe8
>> 
>
> We are coming from head stage, but the caller should have been migrated
> to Linux before calling the ioctl_nrt handler. The whole purpose of
> that

> [  515.060082] IRQ stage: Xenomai

As a matter of fact, the core thinks that rtdm_fd_ioctl() did not relax.

-- 
Philippe.
