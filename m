Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065C2561B9
	for <xenomai@lists.linux.dev>; Sun, 28 Sep 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759062385; cv=none; b=cRcOdIPEAcMdb3EYp3P4u4n10hFLYdl/6HephzXHwdJFpWBGq9O4qx1EG5XkjvKUGNpz7AtCaDX9BXqASxP0tx9THW0uJE5JNqESSmHilHoB3DyZbNdGOOp7k2UB8+JCGPg6743wfiss/LTFcZEZl7uGGatY05GjLjUBIKil9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759062385; c=relaxed/simple;
	bh=C+RJI/i+9dt2YuNaffdQ9YpSNXRKDALBbH9/RzIN8FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EpN2Kdi0d+3ceY4E5Ri+++eXApbLIP9n1IfWaV1Jd7tLRhDXny35aAELAJdrC7Ye4hzt7BZ05L28XAOfMRUmESzYuHgkXhJ1WhJYJ15xtDZ4+I+f2QzmFoLToNTr0k48JRQonzp80NsyWUO9UZC+XerCH6DBzoMY0oqEsCl8zNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ESzhWrPK; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ESzhWrPK"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 51525584176
	for <xenomai@lists.linux.dev>; Sun, 28 Sep 2025 12:24:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A77AE43289;
	Sun, 28 Sep 2025 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1759062278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+BzVyTViwR2QeWSWIo0PMAic5sH5/Xw2a8d3PReIz0=;
	b=ESzhWrPKwtngd0QgTg4M/2IgIchQVqheacTEAR0qrzxjsxrVo1EiBLFLPyvPdefdCz+BG2
	UfhjatTkszOcacItzXIaIJFWNWcv1M7ybYrEqRHrr6QF7xMvc2zPkoCZhPEVQjV0ueJC8j
	WGkkzTQ34iHGcaviLJtEOhnQIoXcNup6Teg9v19MhEOZ9GSbha5PaagWOmuqLhU0kc+gtI
	aNJ47nYZjXDPubm8ls3q8INqrd8QsEyDIudyOE47xFomGaTguT89W1rmVNSCtUJaKcaEfc
	li4kL+GeOKkskv5vu/PfD2L6cSfGMVTD8sSfqR0B1pAEFjN51wcKbNSz2Y4l9g==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.16 0/2] Dovetail: Fix lockdep warning
 observed on 6.16
In-Reply-To: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-0-8a8475e2cdc0@siemens.com>
	(Florian Bezdeka's message of "Wed, 24 Sep 2025 23:23:13 +0200")
References: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-0-8a8475e2cdc0@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 28 Sep 2025 14:24:37 +0200
Message-ID: <87wm5irchm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffffkeelffdvhfffjeduteehudeftdehudffffdvuddujedvhedvheejjeelhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> as disussed in [1] this series is trying to fix the lockdep report that
> was quite easy to observe on 6.16 in an qemu environment.
>
> [1] https://lore.kernel.org/xenomai/871poezs9z.fsf@xenomai.org/T/#m2e90cf7017d5a2ca3a8bd9276528e9f80aded314
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       locking: irq_pipeline: Rename MUTABLE_SPINLOCK to HYBRID_SPINLOCK
>       genirq: irq_pipeline: Migrate mask_lock to a hybrid spinlock
>
>  include/linux/spinlock_types.h | 8 ++++----
>  kernel/irq/manage.c            | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: 138f1183deed300fd1f03abb6511635a916b98d0
> change-id: 20250924-wip-flo-fix-lockdep-warning-for-6-16-a13fec53f60e
>
> Best regards,

Ack. No regression found by long-running tests on a couple of armv7 and
armv8 platforms.

-- 
Philippe.
