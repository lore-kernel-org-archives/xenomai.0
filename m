Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981730F92C
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579935; cv=none; b=hyciNElUqwoa9C1WuXg6Fqt7rWvUTu94hu1VexrHGyKTU3+2HrngAMX22Xvhx2ML5kalIr+4K3jKlX14t7Pc3s0QB6rgQZEuFEnkcINhs/n/0zcVsW5wlPD0uBh6Bylc797rOw1IMKbPl0CAGLJOs0OIWFs/8/Zej41EOTw6JFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579935; c=relaxed/simple;
	bh=I1hDvjjZDXMj9UzsOR5nlqa58kfdEXDna5wc7pWW594=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ib1H6RTG0ZtmM1POxgFlbzhceXWL3Eso3ncJDXD3+hJNuVWThQdM5J3oHtfEQMV5RAt7g1kUMfVpgUg3SVdRId2nqCZLXqXoAsfmEKgD+ELBi6SvQm9zuA39TuIe86BVjAnmT0QmXoon8Ssy/aMN6CIwqg3CIzHU7tvS2461HQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=S+boPCr1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="S+boPCr1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7411243126;
	Mon, 27 Oct 2025 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761579930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qznDs3RL66RxKpeFl4RaDLN7dfpH4lWoL/5zavC3gs=;
	b=S+boPCr1AGh77kMhtf4eGw8dwAzyewJbGxGy36JjlbQy0rKDuuYjOA1oD3MsspQ447qOEi
	KEpEWe41Cfd3REIP7yA3rZZQPQ1uuKniczezFkkAbOKtQsnDk4W3wOruBVaGX6echF+0wY
	PvCjSubVR5AjmAU7BQIncQLsSwFZx5h0QlKxVRlMecCaiSTkBNJqGUqvEuY2FRz1sFKWGu
	MUps6iwqsi3Y10H9XGeBYzZS3QmJxeSyydvtKK+a/jksGAw4OMPoepjEXiTgEwOhNbQF8V
	nxLs0pAdWgsL/ZaNRgKPQwHjsXWOdaf4sd8pwVzdZCYm7MTuKT+uIcLwKkTgTQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
In-Reply-To: <878qgw740t.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	27 Oct 2025 16:33:54 +0100")
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
	<b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
	<e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
	<878qgw740t.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Oct 2025 16:45:29 +0100
Message-ID: <87347473hi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 19.09.25 08:40, Florian Bezdeka wrote:
>>> On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> 
>>> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> 
>>>> ---
>>>>
>>>> Changes for 6.1 will look different.
>>>>
>>>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>>>  1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>>> index 1f5fcac32b2d2..21f8785948ca3 100644
>>>> --- a/arch/arm64/kernel/fpsimd.c
>>>> +++ b/arch/arm64/kernel/fpsimd.c
>>>> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>>>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>>>  				  unsigned long cmd, void *v)
>>>>  {
>>>> -	unsigned long flags;
>>>> -
>>>>  	switch (cmd) {
>>>>  	case CPU_PM_ENTER:
>>>> -		flags = hard_cond_local_irq_save();
>>>>  		fpsimd_save_and_flush_cpu_state();
>>>> -		hard_cond_local_irq_restore(flags);
>>>>  		break;
>>>>  	case CPU_PM_EXIT:
>>>>  		break;
>>>> -- 
>>>> 2.51.0
>>
>> Philippe, this cleanup is still pending, applying as-is to
>> v6.17.y-dovetail-rebase now.
>>
>
> Which tree is this? If you mean v6.17-rebase, this patch is redundant.
>
> void fpsimd_save_and_flush_cpu_state(void)
> {
> 	unsigned long flags;
>
> 	if (!system_supports_fpsimd())
> 		return;
> 	WARN_ON(preemptible());
> 	flags = hard_local_irq_save();
> 	fpsimd_save_user_state();
> 	fpsimd_flush_cpu_state();
> 	hard_local_irq_restore(flags);
> }

Oh dear, I read it backwards, this is definitely not redundant
then. However, which tree are you applying this to? 6.17.y does not
exist ATM here.

-- 
Philippe.
