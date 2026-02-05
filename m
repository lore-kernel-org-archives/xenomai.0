Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1B243956
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298845; cv=none; b=FbYh0wPAhNl2BtjGsyKHfGctzv9BuoCqYlGFzmHmN1xw0yQBl6vKY/id+ych9WOvntqOwPKQo3n1T56tSSvfmJWgXBBd/f3mB5qi3L/arjcVNnCkcgCZl70DUZfg1sfsWEGexl4dRhqTgcF2TqsuT50n01QjMqW9rbRbUfs1Zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298845; c=relaxed/simple;
	bh=Ve/K2f5iX32ezPuWfS64ssk46Rh7lgJ71NBZ9nJSTuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=inD+9FrVCRvx/xVTa+bf6t08NtW/JFV2Vtx0Pb8QJbirMBMfc8Bwi8qFk6xPlXIgBElBLKZZiCI13X5ykLG37ub2L2cGIIOvUv9q0aynY17FLqGGQMCQbGuI6xixRH3IOBwyLDqY7njKxZ2JtzutzOun2LPzTsOkvaiFO9VKNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=SL1v7Dc6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="SL1v7Dc6"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57E4943B7B;
	Thu,  5 Feb 2026 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770298842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FmmicozCd39emYHwHV+v2Scqs93BaGCn0ZMujOzkqk=;
	b=SL1v7Dc68Pye1Qweu6pOGrsbD6wqHWYZm3k7uYMC13eI71GjuotMn6Q+uKeutqOemU1HUb
	6bfX6Y14/AEnD2mUfInqVSJM1FUQd6u5EcnL/0Vpnt566r0MsaCK/hEXZMCb4YJTSYinXU
	cy6ta2DFW3+WOnXpb45hGZno8n51OS0itS0NAiAF77AHRQfxeJi/8+h6wOKJP9XoV+8yPS
	35agaGbbe4tg1BNxp1N4F97DyNnQKRqf+Oj4nA8IYJ441ZpkqdgJagm3rR2JpKEdFdwiOS
	FuRvG0Gp/q+hASrdzj7Go2JLRoisCxC1vCZSYoIIcv8vXHgMHFCoQqtjy3tqag==
From: Philippe Gerum <rpm@xenomai.org>
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  "Kiszka, Jan (T CED)"
 <jan.kiszka@siemens.com>
Subject: Re: Trigger xenomai-images CI for linux-evl and libevl
In-Reply-To: <db8c1dc5-eb36-4f68-969f-c07e408bf03d@siemens.com> (Clara
	Kowalsky's message of "Thu, 5 Feb 2026 14:32:10 +0100")
References: <db8c1dc5-eb36-4f68-969f-c07e408bf03d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 05 Feb 2026 14:40:37 +0100
Message-ID: <87a4xnb962.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepheejgfegleegfeeujeeupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghlrghrrgdrkhhofigrlhhskhihsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Clara Kowalsky <clara.kowalsky@siemens.com> writes:

> Hi,
>
> I am planning to add support for triggering pipelines in
> xenomai-images on pushes to linux-evl and libevl, as suggested by Jan
> Kiszka. In this way, they are covered by xenomai images just like
> xenomai-3 and dovetail.
>
> I would trigger the xenomai-images pipeline for pushes to:
> - linux-evl branches: head (6.18), 6.12, 6.1, in combination with
>   libevl next
> - libevl branches: next, in combination with linux-evl head
>
> Would that be in line with your thinking, Philippe?
>

Yep, looks good, thanks.

-- 
Philippe.
