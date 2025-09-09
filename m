Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0D24502C
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425473; cv=none; b=V5HgrlcZr1jKN+hKemzNohQUM9hCDE/dNUq7jhv7lCyUqZVD23f618jTXr2JHo9fqYPy34YB0DVGy7RQLxajD+D/R/80wl0FUymVETMpUgQDJ7LjYpeRwv+lBZS/Xs+gVhieR3wlGdNcTbDZsKYlR/n0KpTmmyktaTpTs5dqwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425473; c=relaxed/simple;
	bh=CPYsygfZJkMHojdIYqyDNbK+Vb75v/AXuK1c1xgknvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1EramSkUgmbWmnCvJVGh8vGVMFQAzrhXqH/gj0AGvepQPrQqEgKKlJEFlOI0Ho7KFq5RpEDMcDfPLlVGUXNifyRRrrGGKWTrQIIZUijF62h1o0SEP6OfFraHsfDZjRZoafM70z8D6Fh6aFRhVUCg5JytQ+j6kxPF6OxbvIy7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NryZCfke; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NryZCfke"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBDC043B48;
	Tue,  9 Sep 2025 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757425469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0SsAPqyzAPw1rIGsLEdP9Lt2IfpI67CdQSUt+G/OK8=;
	b=NryZCfkeil+1kTPjlJLc0MUSNkaPrRnfGjnkslcISOmS5UyYTIMHjuEez7UY4F6DiMLwwh
	NdK7IwaDv59mhtqlPh5tpIKhhGtbqC2tlwEZFI+6j16QgX9iFEP3XyfPU5Yhw0UJdAG4od
	7rlpb/4TuUNFkPbJIuIm/kHdUMtnqYRZk33VpGJMsR5cGjqkgrqO4WNaW7piZGpodFFyE6
	EhvZQqyqM1bvqLreOuJ4OUiTIWap1CKC7NpoIaWXKS0br8P73ZYeNAmhn7Mf5AzJ9CF1Fa
	StSYWOfrg0r1mgI315FW0tN7zu1/34INH5n0hgB9d7+8gKO0po7QFQC8m2Zmvw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v4 0/3] Dovetail 6.16: Fix some
 regressions introduced during last forward port
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v4-0-d661652d03fa@siemens.com>
	(Florian Bezdeka's message of "Mon, 08 Sep 2025 23:17:53 +0200")
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v4-0-d661652d03fa@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 09 Sep 2025 15:44:25 +0200
Message-ID: <875xdrwxja.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffffkeelffdvhfffjeduteehudeftdehudffffdvuddujedvhedvheejjeelhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> seems the last forward port to 6.16 introduced some regressions.
> Please review carefully, thanks!
>
> With that applied I have two open problems:
>   - Running dmesg kills the system, no idea yet
>     Requires at least 3 CPUs on my qemu system to reproduce.
>     Update: I know how to fix that, but not fully understood yet.
>     Update: Discussion ongoing, see ML.
>
>   - I'm able to reproduce [1] on 6.16 now
>     Update: This one is understood now. Xenomai 3 bug.
>     Tests already ongoing.
>     Update: Fix posted to ML and merged into Xenomai next.
>
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>
> [1] https://lore.kernel.org/xenomai/6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com/T/
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v4:
> - Patch 1: Define _TLF_KERNEL_FPU_PREEMPTED as an alias to 
>            TS_KERNEL_FPU_PREEMPTED
> - Link to v3: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com
>
> Changes in v3:
> - Rework patch 1: Move preemption marker to thread local flags
> - Added patch 2: Align arm64 and x86 fpu preemption code
> - Patch 3: was Patch 2 in v2, updated to match latest Linux code
> - Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v2-0-535e4fa355f7@siemens.com
>
> Changes in v2:
> - Patch 1: Reworked as discussed on the list
>            Following the same pattern as for arm64 
> - Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com
>
> ---
> Florian Bezdeka (3):
>       x86/fpu: dovetail: Fix FPU corruption
>       arm64: fpsimd: dovetail: Align with x86 implementation
>       irq_pipeline: Fix pipelining code for level triggered IRQs
>
>  arch/arm64/include/asm/thread_info.h | 10 +++++-----
>  arch/arm64/kernel/fpsimd.c           |  7 +++++--
>  arch/x86/include/asm/fpu/sched.h     | 17 ++++-------------
>  arch/x86/include/asm/fpu/types.h     | 12 ------------
>  arch/x86/include/asm/thread_info.h   | 10 ++++++----
>  arch/x86/kernel/fpu/core.c           | 13 +++++--------
>  kernel/irq/chip.c                    | 22 ++++++++++++++++++++--
>  7 files changed, 45 insertions(+), 46 deletions(-)
> ---
> base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> change-id: 20250820-wip-flo-fixes-for-dovetail-6-15-1368f7f6e0b1
>
> Best regards,

Thanks Florian, merged.

-- 
Philippe.
