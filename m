Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50142620E4
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579844; cv=none; b=pnIfpFamaovZQ/vH3FSNH+shmae5sXlpJ0oYAZUnPvtVLNIKQxZbC1uP8wPFzNPVlhxua1tNC5zJwS+VFTKQfmISd2jE3HRKCGoj1fOJ6gPtxNcZ6YhDX+XJCf7/RApzy1QG1Z2AdLir5Sth7xKiPhQxQPYzxJqS9V8Vs5GJV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579844; c=relaxed/simple;
	bh=0K1zZLa9HpKAEW05RPsEktk+b2YaBQvs5j65XqrNoeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nplXAB6VQJ6tAUfkcbLvJPolVgIq03X7XLJBtIYeSE+Hg96p6h2Jr4YUzbrxmtzVE6B8wxLHJjFP8k1Kqo+mtzzJuwXAqTaMyaFgIRXvkQD8kE+aT1wct78OmZJXs0hzm5WOSu3rPs2FmjcQNWQPpS5NipKKoHZ2WFSvO/opgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Ro3IQOl0; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Ro3IQOl0"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id DB4535815F8
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 15:34:02 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C14E4418D;
	Mon, 27 Oct 2025 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761579235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iFOsR2OU6ey2pyWrODMK94VV1uWMORAKyFsvp+R9mI=;
	b=Ro3IQOl0DbbgcbNpgqA1QhSGd2cA/W+pv//i4Dp4Ml6Ln17chOAtzy/7TXBTIoICbnr0Th
	OlCu3hpYxEqQus4/1rzzxrVAci7Sao3CSO7FPmJxLIo/uhqAOdaan0MBquUYA2uB4T1FOH
	QJrx/6hG5CouCzOLMuOdCML6DEN8G4t7iES6iYjNleuv0y3CsJ+CMD2iSSOgixpMzGlzzh
	gF42S5zCZGdlPSTSqPuztR+zLF/oHEt/kJ2d65OC/CLtdw1FyR0ntnXshu839S/5SB0pMa
	rhr5FF4O2bRVV9dCths/49w1Ki7rmUCEbPJ0jp+qw3jcKV4dxvMvTVbPNZU54w==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
In-Reply-To: <e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com> (Jan Kiszka's
	message of "Mon, 27 Oct 2025 16:10:07 +0100")
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
	<b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
	<e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Oct 2025 16:33:54 +0100
Message-ID: <878qgw740t.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 19.09.25 08:40, Florian Bezdeka wrote:
>> On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> 
>>> ---
>>>
>>> Changes for 6.1 will look different.
>>>
>>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>> index 1f5fcac32b2d2..21f8785948ca3 100644
>>> --- a/arch/arm64/kernel/fpsimd.c
>>> +++ b/arch/arm64/kernel/fpsimd.c
>>> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>>  				  unsigned long cmd, void *v)
>>>  {
>>> -	unsigned long flags;
>>> -
>>>  	switch (cmd) {
>>>  	case CPU_PM_ENTER:
>>> -		flags = hard_cond_local_irq_save();
>>>  		fpsimd_save_and_flush_cpu_state();
>>> -		hard_cond_local_irq_restore(flags);
>>>  		break;
>>>  	case CPU_PM_EXIT:
>>>  		break;
>>> -- 
>>> 2.51.0
>
> Philippe, this cleanup is still pending, applying as-is to
> v6.17.y-dovetail-rebase now.
>

Which tree is this? If you mean v6.17-rebase, this patch is redundant.

void fpsimd_save_and_flush_cpu_state(void)
{
	unsigned long flags;

	if (!system_supports_fpsimd())
		return;
	WARN_ON(preemptible());
	flags = hard_local_irq_save();
	fpsimd_save_user_state();
	fpsimd_flush_cpu_state();
	hard_local_irq_restore(flags);
}

-- 
Philippe.
