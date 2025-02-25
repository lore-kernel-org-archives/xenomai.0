Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EC26982A
	for <xenomai@lists.linux.dev>; Tue, 25 Feb 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490649; cv=none; b=DUY090EdVYFdQ9TyC6oZoK3BbjL1H274lHR3r2bNu2CcAilMKhyoPH8lye2jEWeWNjKLMfCvriqXmFiYzsog/SLcqPT30uWJN8hFpg/xcWrfHygI5i5jybmEj9knxM39HYuOp9Qj8gtcqNDjjPh82G/g+yz/KgkYLogNiG/Jsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490649; c=relaxed/simple;
	bh=N26IVnL1Z9/G8RfxeJ5z6xwkAqwkBCmRrnXuKFduEe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9dXFJJ8sqNjoXAWZKTajc9tFXPanrwrin9o2U02GDYFCfxoo9myEPBnWCUifGp1kn99fXFqOMIgK8tkmMqzBy6/XroayL8doIlnd9h8tOkG+RCmxseYRpoAAgV0W6KRDqhOw7S0NFKqH/Hw/aHYSKqEfcN8IVSMkdn5MMsyqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=njTBXG/y; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="njTBXG/y"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EE6E44226;
	Tue, 25 Feb 2025 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1740490644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N26IVnL1Z9/G8RfxeJ5z6xwkAqwkBCmRrnXuKFduEe4=;
	b=njTBXG/y4Wc3ihqHxAocbb6LZXYIMajUEeeJqq3lLkCPPOwdhfbVEU+N9tIK2xxXet696b
	aoLrucHbifYSGGJ/h8cBGAW0jZSjJu1m44g3LNcu02qq2PcWnMe55kKHj0YJiSIdVhzQqP
	su0EGIu0fejMsj+2XMx8+yc+bzcC9ZXwopfxtHtYiGGiYZJL+4XCJPzsdh3ZAQqdCvmWSU
	6tR/0rpYlo4srlfgjEwJOV2qT5Bx5G/HGaLrMroyjLL8vuhfEiARdDu7mj8rrRIdcvqui3
	z5cDwmIGfErCbv1BAvhVs4xRtFp66e9L1cbkcqWy0MVUyNkVIhlcWOkSjUS7+A==
From: Philippe Gerum <rpm@xenomai.org>
To: JerryJun <jerryjun123@163.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: CXP -- migrating from alchemy to evl
In-Reply-To: <228ce6ee.15f.1953a566904.Coremail.jerryjun123@163.com>
	(JerryJun's message of "Tue, 25 Feb 2025 07:41:36 +0800 (CST)")
References: <228ce6ee.15f.1953a566904.Coremail.jerryjun123@163.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 14:37:20 +0100
Message-ID: <87plj6ywkv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveegudejhedtheeihfelfeffleffleeitdelgfelhfduhedvtdeljeekteeghefhnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjvghrrhihjhhunhduvdefseduieefrdgtohhm
X-GND-Sasl: rpm@xenomai.org

JerryJun <jerryjun123@163.com> writes:

> hi xenomai:
> We have recently been done tests on EVL(Xenomai 4) and have recently lear=
ned about the CXP (Common Xenomai platform).
> are there any specific plans regarding the CXP?
> We would like to know if there is a smooth migration document=C2=A0for mi=
grating the native Xenomai interface,
> the Alchemy API, to Xenomai 4. For example, something similar to "Migrati=
ng from Xenomai 2.x to 3.x."=C2=A0

CXP is basically on hold until somebody starts contributing to the
discussion and implementation.

--=20
Philippe.
