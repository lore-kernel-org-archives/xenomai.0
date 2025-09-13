Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94D287241
	for <xenomai@lists.linux.dev>; Sat, 13 Sep 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773536; cv=none; b=BRIgegM3IbBMlmvydMH8M2mNWOImmMK6IgfdHtNLqEyXatVCPhtVDL4yis8z65hTTMYQFr9YEzX5qpFj240SAWswaFByTutXsU8BVEThKVc181b2z2PipAT3h9+U5Xspqymkg5wcDf9CltYCpMr48xPug/yaCUBVy0e5pmuFiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773536; c=relaxed/simple;
	bh=tu8LvVwzoSP8uceB6xqHo8eMwsqDDvvC6imeORhBI5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebVqa0co4niwRVB9hEqU24iYWSDwcF/0Z1eJAFsj9m9uyzfRLV1eIWDqA6khbhV1tf480aJPZBl64XaoDBHv8FZgykwYhXfStwA0BR/RtfDW2v30YDyk8SRdI5m9hbFS9IdooVUc4VlNZgwNzUaJyZNoKUoNXWeQKsnUYpPYlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Hdyp7NRk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Hdyp7NRk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B7BD43889;
	Sat, 13 Sep 2025 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757773525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwcnrfHjVutfJUJ6jaMOcaEn53AWP8XfCrTOsaID51g=;
	b=Hdyp7NRkYwR5v+WTLGWpcyhLvzAXiR9Oqy/WXExUYHvWvgwZSDSmxmrvbrnuVX3KE8QO1B
	Hhycx6UM/bDDGJCqTyTGYA+wy0RvzohioccM9uoLI6CkGo1c6ex+BV+Ox7LXqoHORFGJ6+
	xVYFINYRdd+byCXn3QW44fEA7pwxldOBtVmJB7S2NbmmmdEhM8Vd7FoGemgZhfBOEWI5nK
	v0Wh1Z8mcGmn1nerlk1jvfOAj++l9y1e6Y1giHXrxEoFgUMLQS/+/gFpRy2z/rFKeUYRh0
	q0BJI7AdYEK1UBKvYVIYBfb/qd99mMOMKgDLF3gAAOwzWUZoYMQy4UzqZIRrHQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] lib/vdso: Update vdso parser to latest Linux
 version
In-Reply-To: <5d552093-0177-4d80-9c9c-58828aa05ade@siemens.com> (Jan Kiszka's
	message of "Sat, 13 Sep 2025 11:47:35 +0200")
References: <5d552093-0177-4d80-9c9c-58828aa05ade@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 13 Sep 2025 16:25:24 +0200
Message-ID: <87v7lmzay3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This widely aligns our copy of
> linux/tools/testing/selftests/vDSO/parse_vdso.c with the version found
> in 6.17-rc5+. We were primarily missing support for DT_GNU_HASH. This
> becomes noticeable with the Debian 13 toolchain on arm64 which caused
> DT_HASH to become absent from the vDSO.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  lib/parse_vdso.c | 157 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 99 insertions(+), 58 deletions(-)
>

Merged, thanks.

-- 
Philippe.
