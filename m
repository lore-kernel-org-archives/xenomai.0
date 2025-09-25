Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E741E2AE68
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805028; cv=none; b=eT+YwD5ux//2ogIZjsqNOIU1N80jRFNiDZmq2o5SqWCMZMrYdeJ8sVr4FrCIcjQlRN6pDXymnqnkQbfSxlNIi8pA0Qbv7a6DmmAdFhFTtgO+0PKUfhIt3keArAHQ2cZ6tkfByg6xDdSjJG6gDIZGctEUcxF3/IR9KmkfwxEKsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805028; c=relaxed/simple;
	bh=fFsOOQjm1la+xTKihymnFPCeYnGZF220IfmdLiT1T/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bppqIChZFlSOvA1I9d4Jp3NnNgwENcIcaZMJVBj7wrF851vxe6VA1tPDE1bgrr1o0OOsg+41Vuk4C/gTfoZGp6kMN7UumCmv9w62tuxvWs9HLZ5GxTErrfTqMVGseYC7kMMG3GSnBeb5P65+xvx0DDmiCxIsmFOf/FS5ayr8PGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=k2jFJfHu; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="k2jFJfHu"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 4C54C42FE2
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:57:04 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B8ACD740037
	for <xenomai@xenomai.org>; Thu, 25 Sep 2025 12:57:03 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250925125703495e7daef5000207d6
        for <xenomai@xenomai.org>;
        Thu, 25 Sep 2025 14:57:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fFsOOQjm1la+xTKihymnFPCeYnGZF220IfmdLiT1T/w=;
 b=k2jFJfHui7nlHSHjDpnLx9ikDQoVVSEW0n2TuBfSELxbyDc18bOyiIcUYcdozuenXIqy1t
 htEMleVlnWRPOi6i9PINzB1tZf++w4L7gjD9QXP2gVvRCffVrA+cutyCCmd4kLuvnYV8o3t+
 1OZYi4NtPgk4poJBVjo30ZU/9HwcXD+/tZZbmF6Cht7EFDsWlPyVfSWfDGI+zG9AveTdpkNI
 Hlu8lNvA2u09Is5NJUV2l6ztmoWxSETWrurKZ+4YbRXKWOUR33cEHWcpUKbZ4FBSm7/usSUJ
 uIGCn90E3+DqsYr2YvMbB4H0hUjQOJ3HCyYPhCoIHHlx1TpwBjTuenlA==;
Message-ID: <682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Date: Thu, 25 Sep 2025 14:57:02 +0200
In-Reply-To: <8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
	 <87bjn1m28m.fsf@xenomai.org>
	 <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
	 <f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
	 <8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=k2jFJfHu;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20250925125703495e7daef5000207d6-cMhBjT@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-68982-20250925125703495e7daef5000207d6-cMhBjT@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgggesthhqredttddtjeenucfhrhhomhephfhlohhrihgrnhcuuegviiguvghkrgcuoehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeelleffffeivdejgfdvvddvleevteekueeuieehhfffieduteegfeetffekjedthfenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvdduuddpudekhedrudefiedrieegrddvvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddupdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqdeikeelkedvqddvtddvhedtledvheduvdehjedtfeegleehvgejuggrvghfhedttddtvddtjeguiedqtgfohheujhfvsehrthhsqdhflhhofihmrghilhgvrhdrshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On Thu, 2025-09-25 at 14:49 +0200, Jan Kiszka wrote:
> On 25.09.25 14:47, Florian Bezdeka wrote:
> > On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
> > > On 23.09.25 20:51, Philippe Gerum wrote:
> > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > > >=20
> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >=20
> > > > > Not all callers of this function do that themselves.
> > > > >=20
> > > >=20
> > > > Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put=
_fp()
> > > > would not benefit from doing that themselves precisely, to create a=
n
> > > > atomic section around their internal state change _and_ the fpsimd =
flush
> > > > op?
> > >=20
> > > Is kvm on arm64 officially enabled for oob (-preemption), or are we
> > > patching blindly here? If no one was looking at kvm yet, then you mig=
ht
> > > be right. If it was reviewed already, then this here is just cleaning=
 up.
> >=20
> > We have
> > https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a36555=
77fb34cac7996f166d2a
> >=20
> > since 6.14 (AFAICT). At the time of writing this was the first kernel
> > release that used in-kernel FPU. Maybe that changed (thanks to
> > backports)? Btw: Which version are we talking about right now? 6.1?
> > 6.12?
>=20
> All of them.
>=20

In case backporting is considered:

Please also take

97cb63af01de ("arm64: fpsimd: dovetail: Align with x86 implementation")

into account. Just a "couple of weeks" old and brings some
optimizations.


>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
