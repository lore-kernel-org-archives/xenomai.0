Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E731D5146
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654141; cv=none; b=jb/qj0nFX9UDkQvfxuqlkcvicTFac4YOJdwpaP3ly4VI3qdJfer+5m7hUxlaO0hp56USBhM3VtHoaZ7CojXF7Dq3XTwaMYJJ32HD1IJFMfMPViwo3Jc0g8xK9guxR376ZZIO/FUsHY5/RrqhKIh0sAEk1lOJOwjqUHh0Nhch5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654141; c=relaxed/simple;
	bh=ajVGFyMOMZ/kjaKcYKLOZqYu7MM5bSGqSBL+VRwbrdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jUox8BVU91/Kg/bYccv8zdxuTAprAy2m3Qxf65qEvu0KvkJfOowbkKtVcwOwd5twslMNqUm77JuA7HqAWanQ+dBaF5T2bwiuZJUgcNUL4hJYdWcSnso8FRtVWoCBw9NaYf/6ghZCSCgRcVPbk5a7NipsG51Zgx9IBqV3nnwJTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=J2zcRLHh; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="J2zcRLHh"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 1945C43C66
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 19:02:17 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 91BF37803CF
	for <xenomai@xenomai.org>; Tue, 23 Sep 2025 19:02:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34FD5443B4;
	Tue, 23 Sep 2025 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758654136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80y9833Jh5T4P/fxvNglNkJNT2Tsoeomnmp9POkmQF0=;
	b=J2zcRLHhPi0DGiDruD0N7es10Cxg5n0cWuccdQs3CZjWmyYhnoZ254/1kNuq70JhIjFoU2
	wqAJsjmv1yzV1a9cU8i3+6Wi93U2wm6DQsbGDoJZlNGGhFdOqhWXNVuP9tfpG7pK4AmS0a
	FDlGCl+v1HiYY6yfwyA/inYlMfACmIA5SGGa0RYGYABH+rU/CW/fdRz7wjtyNnP3FQSeC3
	HpiqeSMyIqv/2m+0b7NmhUf+0Vg3DI5bQyYYCexNFILQ2KGVpGy6GMce0an302Oe7vYI7S
	ZHGN4nKYc3sNjuyHsZMonNFciHcj1lwduxswsbGFBHsF0Se59/1FGl4tIvejVw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org
Subject: Re: [dovetail 6.1.y-cip][PATCH 3/3] arm64: fpsimd: dovetail: Drop
 extra condition from WARN_ON
In-Reply-To: <875xd9m26d.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	23 Sep 2025 20:52:42 +0200")
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	<f53cbf9e9098b3c54a8986aab50c5325be5fda1a.1758264904.git.jan.kiszka@siemens.com>
	<875xd9m26d.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 23 Sep 2025 21:02:15 +0200
Message-ID: <87qzvxkn60.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgrihesgigvnhhomhgrihdrohhrghdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=J2zcRLHh;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::229 as permitted sender) smtp.mailfrom=rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvudejrdejtddrudejkedrvddufedpvddttddumeegsgelkeemuggtgeemkeemmedvvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There is no indication that this function is called over oob context as
>> well, and newer dovetail versions do not carry this extra condition
>> anymore.
>>
>
> Depends on whether patch 2/3 is actually correct.

1/3, not 2/3.

>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index f915706332191..ed269edea7907 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -1950,7 +1950,7 @@ void fpsimd_save_and_flush_cpu_state(void)
>>  {
>>  	if (!system_supports_fpsimd())
>>  		return;
>> -	WARN_ON(!hard_irqs_disabled() && preemptible());
>> +	WARN_ON(preemptible());
>>  	get_cpu_fpsimd_context();
>>  	__fpsimd_save();
>>  	fpsimd_flush_cpu_state();

-- 
Philippe.
