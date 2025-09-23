Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AE2BE644
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653567; cv=none; b=PIiLbk6gfPPY5ROvMLi8LVTT0Ff0YCfkvvLCrDqra/j7i4eg3r3qRqyj+wnxG7MNYzf9TszX2KbtD/fqOVPqHrADkkrZxgvPb9FwlXQy7QzxKQwGt0Vysue76UP8dOe8J4blNlZuoNzYyq9s7CpHyaKmOFKcQs/LrxK5gDZljv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653567; c=relaxed/simple;
	bh=5U1G10tNft3U91kK3uZRC5zvon7/1gAsYXIZIZu1CGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTGTGQK6CrrVJ+wz0XdhSU63+puY1h4b3ZQ6VVPaqwJTmdzvnEy6rRkahfFxEkvUJQonhkLse5OZnm5514a1ae5O4PLqo7byvN3T+w6YCn/nJOqyRrOo5/qBTUM7mYLohyxMdGCfXTACnPVZmxpYhOiFKV8cJYmu/YFxExr72ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=nisrhRtc; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="nisrhRtc"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 2154543C66
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 18:52:44 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 929C47803D1
	for <xenomai@xenomai.org>; Tue, 23 Sep 2025 18:52:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BCD444385;
	Tue, 23 Sep 2025 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758653563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYiv4ub9p4+I9FljFYaoQBmuYPLTD77XAByJ0cz3mpU=;
	b=nisrhRtcjuywedtj2lYfEFwTB8B7HO9HHHAlqb1/7LfFTbq5dXhyBkAe22O1OhJZrisa3c
	yjIj4pwsaX2sRX6QP5hP9hgqSXNe5VFBiG+NMFjkyKyRjaSY/Z0mxra7zf1tsb74ln8ooZ
	jT3LRXfjIvq686dihxBPNSLrYaZDD06Ao2USsrlTH4wY5MK/ZgfRHSt8M4X9eWPXaT7Lkm
	nNPLR3pB0ZViV5k+WN+ZKViqv+cBa6xv8+D+v43yrXHRfA7f/bSYiMXO0v7UEWfmMnSIan
	h/8JO3gK8pgmMA2HIVVOAhfNCLCs1JEtpSEWmhZQT+eHcE9AfKOSVWcMOFNJhA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org
Subject: Re: [dovetail 6.1.y-cip][PATCH 3/3] arm64: fpsimd: dovetail: Drop
 extra condition from WARN_ON
In-Reply-To: <f53cbf9e9098b3c54a8986aab50c5325be5fda1a.1758264904.git.jan.kiszka@siemens.com>
	(Jan Kiszka's message of "Fri, 19 Sep 2025 08:55:04 +0200")
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	<f53cbf9e9098b3c54a8986aab50c5325be5fda1a.1758264904.git.jan.kiszka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 23 Sep 2025 20:52:42 +0200
Message-ID: <875xd9m26d.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgrihesgigvnhhomhgrihdrohhrghdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=nisrhRtc;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::227 as permitted sender) smtp.mailfrom=rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvudejrdejtddrudejkedrvddufedpvddttddumeegsgelkeemuggtgeemkeemmedvvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> There is no indication that this function is called over oob context as
> well, and newer dovetail versions do not carry this extra condition
> anymore.
>

Depends on whether patch 2/3 is actually correct.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index f915706332191..ed269edea7907 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1950,7 +1950,7 @@ void fpsimd_save_and_flush_cpu_state(void)
>  {
>  	if (!system_supports_fpsimd())
>  		return;
> -	WARN_ON(!hard_irqs_disabled() && preemptible());
> +	WARN_ON(preemptible());
>  	get_cpu_fpsimd_context();
>  	__fpsimd_save();
>  	fpsimd_flush_cpu_state();

-- 
Philippe.
