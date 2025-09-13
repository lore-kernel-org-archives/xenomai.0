Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7EDDD2
	for <xenomai@lists.linux.dev>; Sat, 13 Sep 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770095; cv=none; b=DNPm8bZcG12Sb+52jHz393Rqo0i63Lt2X3NeSFg5rsTDt7bj9PEn5SJknfPp5p2KDRijKCKyHcgNotkVbJkrSDg7JL+6cUOD3E0E9YzSh0AGpq7IxnGgTyZfAx8GUh/uR9q6roVzR6oMlkh+EwFvKfxeiIE+JaOhBZH0cBPQpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770095; c=relaxed/simple;
	bh=1JnhdJPz7ZB76NTlMxJ9Gy8UT1LcETQszveDTFrbtGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrVZM3lS5sLxo7YHxxYXndRgniaj+6IKP7UrII0UIKARS+QK/i6y2pVk+a7w31XWmyDTqRVEUe+3uwFFNFRobPK/PFRgY8D8d0kRFyTd62dcEsRmTZfRvnApTGMdYrGweAqXtXKVzPiEqgo+cG6AJ/oeUrEtK71L94Z0ev7jEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=jMdIlDYF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="jMdIlDYF"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A606439FA;
	Sat, 13 Sep 2025 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757770084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NcIRAuVHME7197WtRAByqQNUJVTw7rCkExl0fsPeplk=;
	b=jMdIlDYFXR1Oa3l9GOVX69OYi5wCINFfuD47LR+1UxEc/iKfOVRwHLmMDqZjhOJVe7JA0k
	+OXr8BLIJV9IGnVKhwQhcIkCK91GDswHPLj02Nq3uuTv3nO80G+nDmH6G+8v/BvQiNeBGo
	tUeHMzud1rsfsgOasz6hvZ5vxb1U6OKsiDpNajBcACzQLs6FdcmHmQ0kw25VTuVVcNsc9v
	w5+n4TDnrKWjLo0O1GXXFzo3SpNzVg2BhBlEK6LqX6I0lM/jCjZSt69TO6IL4qs0BZa5JK
	CPiRDvpYpfkzNnD0QRsDESpRQOPybB7D1kLN8dkiyg9f+u0p5SJ0l+7mQmHyEw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v5 0/3] Dovetail 6.16: Fix some
 regressions introduced during last forward port
In-Reply-To: <20250911-wip-flo-fixes-for-dovetail-6-16-v5-0-4c54bbcfe6b5@siemens.com>
	(Florian Bezdeka's message of "Thu, 11 Sep 2025 14:45:58 +0200")
References: <20250911-wip-flo-fixes-for-dovetail-6-16-v5-0-4c54bbcfe6b5@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 13 Sep 2025 15:27:59 +0200
Message-ID: <874it61nz4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffffkeelffdvhfffjeduteehudeftdehudffffdvuddujedvhedvheejjeelhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> seems that I screwed v4 up, so I have to send v5 after merge.
> Philippe has to fix the rebase branch.
>
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>
> Changes in v5:
> - Patch 1: 
>     - Fix build failure for !CONFIG_DOVETAIL
>     - Use the correct struct thread_info instance in oob_fpu_preempted
> - Link to v4: https://lore.kernel.org/xenomai/875xdrwxja.fsf@xenomai.org/T/#t
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (3):
>       x86/fpu: dovetail: Fix FPU corruption

Merged a fix up for the patch above. The rest is left unchanged.

>       arm64: fpsimd: dovetail: Align with x86 implementation
>       irq_pipeline: Fix pipelining code for level triggered IRQs
>
>  arch/arm64/include/asm/thread_info.h | 10 +++++-----
>  arch/arm64/kernel/fpsimd.c           |  7 +++++--
>  arch/x86/include/asm/fpu/sched.h     | 19 +++++--------------
>  arch/x86/include/asm/fpu/types.h     | 12 ------------
>  arch/x86/include/asm/thread_info.h   | 10 ++++++----
>  arch/x86/kernel/fpu/core.c           | 13 +++++--------
>  kernel/irq/chip.c                    | 22 ++++++++++++++++++++--
>  7 files changed, 46 insertions(+), 47 deletions(-)
> ---
> base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> change-id: 20250911-wip-flo-fixes-for-dovetail-6-16-cccec24f0fd9
>
> Best regards,

Thanks,

-- 
Philippe.
