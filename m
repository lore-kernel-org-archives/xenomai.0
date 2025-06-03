Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9A1F5858
	for <xenomai@lists.linux.dev>; Tue,  3 Jun 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933929; cv=none; b=ilOfWnACFVFmsYsrPi1nGyhPFWu1uzzYzqlUuAKVg18Z7s8cuJ7LtPKHDyW3oZiVH3awNKPLufIUUgLhzY5jqyT2ekoLW0qZKEzAG22oYpF7U0cILYgLWrnwGw/m7gPudLBQqBjA7uauPs3Lo5iSUDC6fVMvg2lMCPbPcV1QME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933929; c=relaxed/simple;
	bh=QBsp12q+Irb5EVkYODXwDwRSunYyGJ62CF70FTk0Wdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LPxqJ+D45EjHo9P2fsjd1hBX4mPGAcufWDor3CgpYZVz100N69qUwnYv1N+BVY4fCCmhNp6gkp8dbyg7diFH9Sp45wc2iEhk1du2jS5abCN5pk2cEipE7Wg3fjJCffG82xXVRwpVe+bh7czVTnhwLgxgodP7/fCfdYiAvxgUEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Urvj3Vgx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Urvj3Vgx"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8503444154;
	Tue,  3 Jun 2025 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1748933924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naq4l5Af/LvNPwfi3eH2RHujKXMAjX4PMhi4MnyWjtY=;
	b=Urvj3Vgxq5RlkUZYt6CjO83zJpDMKq1mAnnKlfXFfIKLgN7Ub/9ChmVUBo4TWl4GBxFACv
	2NtzNSNi+LkqpBPuqDX2Dm6sCti6En7xA7KPMAjopdIfB6DvO67akHYIbEpyjSxkODIGVE
	8N0baVhEaSu4+BbIIu4+F8CO1YqhysPWoCt9a+5UIS4ezqdbyri4Vy5wRiN+/+tUSqvysB
	XhObAcR/yGEL8E4ALLY0ADwAA6T+sHVHKtdzAn/jhD0b8nRmiiQVcrpZI4tuq6s2QTA675
	fkuIgryd9rC3quBoSybzbkZj3cnPOmVljrsSGHcYQVHzr1aMte9BCrCTa+XZaw==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai@lists.linux.dev
Subject: Re: Port of a RTAI based code
In-Reply-To: <87ldqakw63.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	02 Jun 2025 17:20:04 +0200")
References: <1d29632f21dc51b0f1d5434b8ccd16239bb73c37.camel@lapp.in2p3.fr>
	<87ldqakw63.fsf@xenomai.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 03 Jun 2025 08:58:40 +0200
Message-ID: <87ecw148gv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleekkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegvmhhmrghnuhgvlhdrphgrtggruhgusehlrghpphdrihhnvdhpfedrfhhr
X-GND-Sasl: rpm@xenomai.org


Philippe Gerum <rpm@xenomai.org> writes:
>
> long oob_ioctl(..., unsigned in cmd, long arg)
> {
> 	long this_task_index;
> 	unsigned long flags;
> 	int ret;
>
> 	switch (cmd) {
> 	case IOC_TASK_WAIT: /* Or whatever you name it. */
> 		this_task_index = arg;
> 		if (this_task_index >= NR_TASKS)

- 		if (this_task_index >= NR_TASKS)
+ 		if ((unsigned long)this_task_index >= NR_TASKS)

-- 
Philippe.
