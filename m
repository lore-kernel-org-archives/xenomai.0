Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB522172D
	for <xenomai@lists.linux.dev>; Sat, 27 Sep 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758995625; cv=none; b=F9TutvpJgCGMiQdmu6961IrBB/YO+9GW3QbimTgwflggJ+rI4EXVCXIska2XDJgStS5LtTyiLrCcrZfO6F4V3c05hO0cVVypaGvMY3/VnxadYsVpgz0nf5INbZI1PONZXT70xsE1q/ZF0RYvsfiDqIHnn7mnWwe/yZKRHWUY9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758995625; c=relaxed/simple;
	bh=xHxzTk2n175ADaYvxRv9LBrTFIsD9qlEYLmstaVwpCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YU+jzwSumn1BDCW/EF1P1+qmUs3syRPiJip0a4OiSEWa8fbq46VSu1rkwHZjki6QtJzC/HttkgE0M5zJfUhBGUY3HJ7NBsE3TVrw/nLaTHpTz12+WbM36p6elQCZIVwo0NeAVSgzJnxkIb3GcK+SSWaIt5RNYVfHqkGTsuTVHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=KZGlh4Pm; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="KZGlh4Pm"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 9A73643C30
	for <xenomai@lists.linux.dev>; Sat, 27 Sep 2025 17:53:40 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 18FB0D80084
	for <xenomai@xenomai.org>; Sat, 27 Sep 2025 17:53:40 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A98443195;
	Sat, 27 Sep 2025 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758995620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkXsA/AUpz55y995FH51EZY59psawjUbydmd9icbjOQ=;
	b=KZGlh4Pm2NgCBo+dskXzClimmIV76Fu6vLF1vYpAMsqT9Ai4U3HOjFyXKLQfXLHp8BWSAD
	y5lqoIpK7e2YmFIiIDVuPk7xERKq9UaFnJGVIl8N2GFgKOfSlmbu9CrTkKHIpfJx0ZXNfn
	pj/LYX1hGQANDH/53ULVjAjzMofFSRHGmf3cGaYHOaLSMwatYPh7+Wx87ko9L+pMtj7wJt
	LFqQmC1QSZ0vIm+HZ+rMhckAqJi/qdkQwsPbNXMwqfhw4o0KBErtpe+cQAfUpKNA/rhnm/
	nU6CRgHKmILAVR53aCsAC05kXJqSvj5UbCJicZSI+Kwnij3YK+daj1ce7hv2SA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
In-Reply-To: <682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 25 Sep 2025 14:57:02 +0200")
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	<b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
	<87bjn1m28m.fsf@xenomai.org>
	<e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
	<f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
	<8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
	<682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 27 Sep 2025 19:53:34 +0200
Message-ID: <87qzvrkcip.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepueelgffghedtfeegkefgffduteekkefhheduheefiefggfejkeekleefkeejueevnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghiseigvghnohhmrghirdhorhhgpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=KZGlh4Pm;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::227 as permitted sender) smtp.mailfrom=rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepueelgffghedtfeegkefgffduteekkefhheduheefiefggfejkeekleefkeejueevnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvddujedrjedtrddujeekrddvudegpddvtddtudemgegsleekmegutgegmeekmeemvddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2025-09-25 at 14:49 +0200, Jan Kiszka wrote:
>> On 25.09.25 14:47, Florian Bezdeka wrote:
>> > On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
>> > > On 23.09.25 20:51, Philippe Gerum wrote:
>> > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
>> > > > 
>> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
>> > > > > 
>> > > > > Not all callers of this function do that themselves.
>> > > > > 
>> > > > 
>> > > > Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp()
>> > > > would not benefit from doing that themselves precisely, to create an
>> > > > atomic section around their internal state change _and_ the fpsimd flush
>> > > > op?
>> > > 
>> > > Is kvm on arm64 officially enabled for oob (-preemption), or are we
>> > > patching blindly here? If no one was looking at kvm yet, then you might
>> > > be right. If it was reviewed already, then this here is just cleaning up.
>> > 
>> > We have
>> > https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3655577fb34cac7996f166d2a
>> > 
>> > since 6.14 (AFAICT). At the time of writing this was the first kernel
>> > release that used in-kernel FPU. Maybe that changed (thanks to
>> > backports)? Btw: Which version are we talking about right now? 6.1?
>> > 6.12?
>> 
>> All of them.
>> 
>
> In case backporting is considered:
>

We already have 028ad3b2 in [rebase/]6.1.y-cip, I'll pick 97cb63af01de
as well.

> Please also take
>
> 97cb63af01de ("arm64: fpsimd: dovetail: Align with x86 implementation")
>
> into account. Just a "couple of weeks" old and brings some
> optimizations.
>
>

We also need to enable the oob preemption test in switchtest, which was
disabled so far due to lack of support. Now that 028ad3b2 enables safe
preemption of kernel_neon_begin/end sections by oob thread, we should
allow testing this feature in v3 as well with something along these
lines:

diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
index 0958d5e2a..b8c0c39c5 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
@@ -10,16 +10,20 @@
 #include <linux/errno.h>
 #include <asm/xenomai/uapi/fptest.h>
 #include <asm/hwcap.h>
+#include <asm/neon.h>
 
 #define have_fp (ELF_HWCAP & HWCAP_FP)
 
 static inline int fp_linux_begin(void)
 {
-	return -ENOSYS;
+	kernel_neon_begin();
+
+	return 0;
 }
 
 static inline void fp_linux_end(void)
 {
+	kernel_neon_end();
 }
 
 static inline int fp_detect(void)

This was just done in v4 by [1], no issue detected afterwards by the
'hectic' test (switchtest equivalent).

[1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/0396a52a9b3dc352ef10e6a9d2ed096718ef5d80

-- 
Philippe.
