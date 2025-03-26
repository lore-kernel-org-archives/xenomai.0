Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4C1BD9C8
	for <xenomai@lists.linux.dev>; Wed, 26 Mar 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997424; cv=none; b=U49JND0FAwR964HMC8JQ4s1Bp5QYcXiFXrRulh5GaErVF4xPHrJeN0Ov69nUNrgb7QvCGRYYETpbfu9n9Eofhqz4vYEq0CASYFv/eZeRdVCsaVe8T+IDEqihHEwIoqHDiJpNvz1BP0SHi6veLTtzZyCOl/OuqKr+HN6pCzJ8cUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997424; c=relaxed/simple;
	bh=E9HuO2D9U/MmT0LMvIKMq4pudct3Z3I6Nil2YH8WQLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QS5sVO3BMeskRtg3UFMJQnXNLGfaPTe3XI09jMMMVxVUDmJSiP+GR/pW0fbIMGxwG0WJ/9fQ1OtwFxKiRzo+2rbTenuQMH6vR22DIsimPLfQ1sREQnSlAyoX93CgJ4/sA9rMqU8spZxoAki1gZ/tuvZG4NchyQfrz9YKC0rp9PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=cEnRYlUC; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="cEnRYlUC"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB73F44289;
	Wed, 26 Mar 2025 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742997414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuOBNQJRKvVprN+7q0QyIMix5L1tPccYf59gKfQDEvM=;
	b=cEnRYlUCMzjxKTnXSyrRz9SBm1mS+CXQWmgzuZrmhIPCgRaajokJkzuRMyxMSoI86o+GsO
	UX3ke04DmXHRxdShxXsgPe8RYpdv/EWoJuGiAPysbWOCvVQhKfp7fN114bs481goXOeIDO
	LPlFSnYE7U6BollrBESABriJJ2/edE7MCPAF35LwH3ew+3EwCi0gGFPa80v50xYZMMkTUG
	G3TCPy9pe132tkNwuklVnFRtkyC6N+z3vxjstO4yj1rN+jSodsugeyS2xb+7XG2utA0MCX
	Mexi5FASvQs8c6Y36d3ty7n0SabGmei/66uyGFcaEF6Wg44FeE6uAdy//Bk+Ug==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] x86: dovetail: Fix inverted debug check in
 lock_vector_lock
In-Reply-To: <ba24a21ef53181c0c7e576d5f1dab2402a72d2d5.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 26 Mar 2025 13:14:11 +0100")
References: <e9a4daa3-7a28-45b3-89cb-76c6484a44af@siemens.com>
	<199b7a20107bf6756f3579debb7313ff96e33e7d.camel@siemens.com>
	<87ldst30cn.fsf@xenomai.org>
	<ba24a21ef53181c0c7e576d5f1dab2402a72d2d5.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Mar 2025 14:56:49 +0100
Message-ID: <87bjtn99pa.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2025-03-25 at 10:50 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > On Mon, 2025-03-24 at 18:18 +0100, Jan Kiszka wrote:
>> > > From: Jan Kiszka <jan.kiszka@siemens.com>
>> > > 
>> > > Code and comment were no in line, but the comment actually make more
>> > > sense here, given that unlock_vector_lock will unconditionally reenable
>> > > hard IRQs.
>> > > 
>> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> > > ---
>> > >  arch/x86/kernel/apic/vector.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > 
>> > > diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
>> > > index a08b0dff066ac..af60f138d590b 100644
>> > > --- a/arch/x86/kernel/apic/vector.c
>> > > +++ b/arch/x86/kernel/apic/vector.c
>> > > @@ -142,7 +142,7 @@ void lock_vector_lock(void)
>> > >  	 * entry. In addition, we assume that hard irqs are on as well
>> > >  	 * (which is the regular case).
>> > >  	 */
>> > > -	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
>> > > +	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
>> > >  	hard_cond_local_irq_disable();
>> > >  	/* Used to the online set of cpus does not change
>> > >  	 * during assign_irq_vector.
>> > > -- 
>> > > 2.43.0
>> > 
>> > With that applied there is still one warning left in 6.14:
>> > 
>> > [   17.921496] ------------[ cut here ]------------
>> > [   17.921502] WARNING: CPU: 3 PID: 33 at arch/x86/mm/tlb.c:516 switch_mm_irqs_off+0x39d/0x4f0
>> > [   17.921512] Modules linked in:
>> > [   17.921517] CPU: 3 UID: 0 PID: 33 Comm: cpuhp/3 Not tainted 6.14.0-rc7+ #82
>> > [   17.921521] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> > [   17.921523] IRQ stage: Linux
>> > [   17.921526] RIP: 0010:switch_mm_irqs_off+0x39d/0x4f0
>> > [   17.921531] Code: 06 75 de 65 c6 05 e6 82 db 7e 00 e9 77 fd ff ff 48 8b 05 3e 79 18 01 b9 49 00 00 00 48 89 c2 48 c1 ea 20 0f 30 e9 fb fc ff ff <0f> 0b e9 9f fc ff ff 0f 0b e9 4f fd ff ff 65 48 c7 05e
>> > [   17.921533] RSP: 0018:ffffc90000133de8 EFLAGS: 00010202
>> > [   17.921537] RAX: 0000000000000001 RBX: ffffffff8270e000 RCX: 0000000000000207
>> > [   17.921539] RDX: 0000000000000206 RSI: ffffffff8270e000 RDI: ffff8880065ae3c0
>> > [   17.921541] RBP: ffff88800378ab80 R08: ffff88803e79c5c8 R09: 000000000000019d
>> > [   17.921543] R10: ffff88803e79c5a0 R11: 0000000000000001 R12: ffff8880065ae3c0
>> > [   17.921545] R13: 0000000000000000 R14: 0000000000000003 R15: ffff88803e79c5c8
>> > [   17.921558] FS:  0000000000000000(0000) GS:ffff88803e780000(0000) knlGS:0000000000000000
>> > [   17.921574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   17.921577] CR2: 000055ed7e138e28 CR3: 0000000003ea8000 CR4: 00000000003506f0
>> > [   17.921579] Call Trace:
>> > [   17.921622]  <TASK>
>> > [   17.921625]  ? __warn+0x85/0x140
>> > [   17.921630]  ? switch_mm_irqs_off+0x39d/0x4f0
>> > [   17.921634]  ? report_bug+0x164/0x190
>> > [   17.921641]  ? handle_bug+0x65/0xd0
>> > [   17.921645]  ? exc_invalid_op+0xb2/0xd0
>> > [   17.921648]  ? asm_exc_invalid_op+0x1a/0x20
>> > [   17.921653]  ? switch_mm_irqs_off+0x39d/0x4f0
>> > [   17.921657]  ? __pfx_sched_cpu_wait_empty+0x10/0x10
>> > [   17.921661]  sched_cpu_wait_empty+0x93/0xc0
>> > [   17.921665]  cpuhp_invoke_callback+0x114/0x4b0
>> > [   17.921669]  cpuhp_thread_fun+0xee/0x190
>> > [   17.921674]  ? __pfx_smpboot_thread_fn+0x10/0x10
>> > [   17.921678]  smpboot_thread_fn+0xdd/0x1d0
>> > [   17.921683]  kthread+0xf1/0x1e0
>> > [   17.921689]  ? __pfx_kthread+0x10/0x10
>> > [   17.921693]  ret_from_fork+0x34/0x50
>> > [   17.921698]  ? __pfx_kthread+0x10/0x10
>> > [   17.921701]  ret_from_fork_asm+0x1a/0x30
>> > [   17.921717]  </TASK>
>> > [   17.921719] ---[ end trace 0000000000000000 ]---
>> > 
>> > There were some changes to the scheduler code in between. I'm currently
>> > testing with:
>> > 
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 50b082b41e7d..4427fc13086d 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -8032,10 +8032,10 @@ static void sched_force_init_mm(void)
>> >  
>> >         if (mm != &init_mm) {
>> >                 mmgrab_lazy_tlb(&init_mm);
>> > -               local_irq_disable();
>> > +               hard_local_irq_disable();
>> >                 current->active_mm = &init_mm;
>> >                 switch_mm_irqs_off(mm, &init_mm, current);
>> > -               local_irq_enable();
>> > +               hard_local_irq_enable();
>> >                 finish_arch_post_lock_switch();
>> >                 mmdrop_lazy_tlb(mm);
>> >         }
>> > 
>> > Florian
>> 
>> Correct. However, since this is an inband call, we want to keep the
>> virtual interrupt state in line with the expectations of the kernel, so
>> we need to keep the original local_irq* calls in place. Dovetail
>> provides a pair of calls namely (un)protect_inband_mm() which is
>> dedicated to guarding the mm switch code from hardware interrupts, the
>> general logic is visible from switch_mm() in arch/x86/mm/tlb.c. Using
>> these calls in this particular case serves as code annotation as well.
>
> This survived testing as well:
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 50b082b41e7d..8bcfb8e7046c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8029,12 +8029,15 @@ void sched_setnuma(struct task_struct *p, int
> nid)
>  static void sched_force_init_mm(void)
>  {
>         struct mm_struct *mm = current->active_mm;
> +       long flags;
>  
>         if (mm != &init_mm) {
>                 mmgrab_lazy_tlb(&init_mm);
>                 local_irq_disable();
> +               protect_inband_mm(flags);
>                 current->active_mm = &init_mm;
>                 switch_mm_irqs_off(mm, &init_mm, current);
> +               unprotect_inband_mm(flags);
>                 local_irq_enable();
>                 finish_arch_post_lock_switch();
>                 mmdrop_lazy_tlb(mm);
>
> That should probably be squashed into 
> 8646b1d5622f ("x86: dovetail: enable alternate scheduling")
> for the 6.14 branch (only).
>
> Agreed?
>

Ack.

-- 
Philippe.
