Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090BF30E0C0
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580940; cv=none; b=Abh8TtduZ+tCjCUUxQFTWOjmnIswP/rr80m9yMJulLjnPvW0deLx4ys+0+XJxi7GA23iX8O/UDEtziFTT+X9dtKtkenqscHQK/vTt4jSLrkcUe63ae3GHlZ5FkOGeYWSHEw2/1M5QJb5xHrskqcp1766OORJnlY2sQs3t2yggRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580940; c=relaxed/simple;
	bh=RMbwAfSYRTpOssRkrdwG5PBg1ij9RbOCAgZSPA4M3Hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JXPrRlT1kNtuDPEzo37Vwv2650gV6/i0+fSJcKr9ORG0B88bNX8fn0k6prf0aIVq/jnjVrJDeNanaN0KoaXRpqnEzM84H/RYHSH7IPP9GIHk5XsyEmt/D5RYu7q8Kl4lZ4zWYmLZaAWSWRtthGOFnx7XOvlM2gAxjKtYYKJ8Gak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=DV7IujXD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="DV7IujXD"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEAA7441E0;
	Mon, 27 Oct 2025 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761580936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAIK0Gj5bTXgKng0ZnOdMdaRqt7c7wkrK+fXwHpI8Qw=;
	b=DV7IujXD9jTRvvUIXdJ2SH0galSwiItlzRrpgzSdTekiDdnEn96iXt5wQQ7egIjeKAeguR
	LVCstF2SYCAMyIRfcz65mlJnwxxAs9nidIeG6KDRAlGnnnPnjGG8c43mL17/6niNW9X1XX
	Bdk8/6hVfNRDL4BJaTZAgkMct6/Pb0zagviZWtfd55uBlbumVh8RIYivOPwChOo3FEdxFy
	OtOzJlD2YqTdzQRtrrytXOBz8KY+IBL3lDAoiujz35elLSIqM7spE1BWfzHPfmCIIzJzy6
	zUxzoYhiGKpYLJAoXzDRsMQC76ZvjR0AZe0Y6rjm17551GH76Dlo3D2p0ZrOkw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
In-Reply-To: <87347473hi.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	27 Oct 2025 16:45:29 +0100")
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
	<b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
	<e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
	<878qgw740t.fsf@xenomai.org> <87347473hi.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Oct 2025 17:02:15 +0100
Message-ID: <87wm4g5o54.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 19.09.25 08:40, Florian Bezdeka wrote:
>>>> On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> 
>>>> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> 
>>>>> ---
>>>>>
>>>>> Changes for 6.1 will look different.
>>>>>
>>>>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>>>> index 1f5fcac32b2d2..21f8785948ca3 100644
>>>>> --- a/arch/arm64/kernel/fpsimd.c
>>>>> +++ b/arch/arm64/kernel/fpsimd.c
>>>>> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>>>>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>>>>  				  unsigned long cmd, void *v)
>>>>>  {
>>>>> -	unsigned long flags;
>>>>> -
>>>>>  	switch (cmd) {
>>>>>  	case CPU_PM_ENTER:
>>>>> -		flags = hard_cond_local_irq_save();
>>>>>  		fpsimd_save_and_flush_cpu_state();
>>>>> -		hard_cond_local_irq_restore(flags);
>>>>>  		break;
>>>>>  	case CPU_PM_EXIT:
>>>>>  		break;
>>>>> -- 
>>>>> 2.51.0
>>>
>>> Philippe, this cleanup is still pending, applying as-is to
>>> v6.17.y-dovetail-rebase now.
>>>
>>
>> Which tree is this? If you mean v6.17-rebase, this patch is redundant.
>>
>> void fpsimd_save_and_flush_cpu_state(void)
>> {
>> 	unsigned long flags;
>>
>> 	if (!system_supports_fpsimd())
>> 		return;
>> 	WARN_ON(preemptible());
>> 	flags = hard_local_irq_save();
>> 	fpsimd_save_user_state();
>> 	fpsimd_flush_cpu_state();
>> 	hard_local_irq_restore(flags);
>> }
>
> Oh dear, I read it backwards, this is definitely not redundant
> then. However, which tree are you applying this to? 6.17.y does not
> exist ATM here.

Meanwhile, I picked this patch which fell through the cracks for
6.1.y-cip-rebase, 6.12.y-rebase and v6.17-rebase, both for dovetail and
evl trees, thanks.

-- 
Philippe.
