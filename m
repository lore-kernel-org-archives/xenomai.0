Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2671DDA1E
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804462; cv=none; b=PhDUCJn5+VLGrNtqqq28sEIsaKP98lcj9KbZdjELxFyuC7SX0YG7c8LQEakqXjxwykmYHwFX0jDGjLAUoMtRZaVJQWfN2n6uOQWaiJq81PiUaLzTBEv+01iZAdFlije/GtMnJamtvrWyORm6IO5f2f9/wV1UifkEysaeih4NMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804462; c=relaxed/simple;
	bh=/mULB40LGR5V+DSYiGPTopIrNIRjEZGU6oUR3IAMOu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8bjXs0eNy8LrQO+WCHPiRFSj/Ry6AVDqEsxNi2PAJBxEL43+sI+QiiCcKpotas7D5RCV3bj+AxsYeTc6fBUqxCSYOxZlAU+cC4k9G6JLZheiugnEcrOAXdyhjmWRLBPOMUNjKlNh6swGecg9ORvp1F6h7FYqNP4/ahUJNYj4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jDwUuYtG; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jDwUuYtG"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 60D044363B
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:47:36 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id ADD817803DA
	for <xenomai@xenomai.org>; Thu, 25 Sep 2025 12:47:35 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202509251247347b9d77d3c100020749
        for <xenomai@xenomai.org>;
        Thu, 25 Sep 2025 14:47:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SAHzHQeClD59kthoDuUbB2wbLut9qz2ToyoR9X89E+k=;
 b=jDwUuYtG3mGJkn0cDleP6dfVQA/7j9ennDv23/ms3fFIw2x3OQLEc3DNdl4RzOq/fvo/aT
 3THVoSZvW5Cu9NBzlWR+6jzrdynJrSFsLyW05cpvDx5ZTmfzBkRb1KHjR+6Dux9R+q9XEPYk
 FnXAhng10xsjxDkiqwwA5b9qeMmRI4J/HbWDm7cfxlMR61J59l0GXmxDuWIHNYkEGZH+9Za0
 ZgjfxHDYLXkJWR7Epr7KsSxr80pnn/4U2+9Dg3WXI5jM6D+iX5d7JqzoGQAE1T0jTfHFuuHZ
 tCD2xTSbIZo8YLeQIRZjSkQcd94mZLr18ZNweZ1YKih/W1fKsUMmpzEw==;
Message-ID: <f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Date: Thu, 25 Sep 2025 14:47:33 +0200
In-Reply-To: <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
	 <87bjn1m28m.fsf@xenomai.org>
	 <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
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
	dkim=pass header.d=siemens.com header.s=fm1 header.b=jDwUuYtG;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-202509251247347b9d77d3c100020749-lj0GYN@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-68982-202509251247347b9d77d3c100020749-lj0GYN@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgggesthhqredttddtjeenucfhrhhomhephfhlohhrihgrnhcuuegviiguvghkrgcuoehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeelleffffeivdejgfdvvddvleevteekueeuieehhfffieduteegfeetffekjedthfenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvddufedpudekhedrudefiedrieehrddvvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqdeikeelkedvqddvtddvhedtledvheduvdegjeefgeejsgelugejjegufegtuddttddtvddtjeegledqlhhjtdfijgfpsehrthhsqdhflhhofihmrghilhgvrhdrshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
> On 23.09.25 20:51, Philippe Gerum wrote:
> > Jan Kiszka <jan.kiszka@siemens.com> writes:
> >=20
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > Not all callers of this function do that themselves.
> > >=20
> >=20
> > Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(=
)
> > would not benefit from doing that themselves precisely, to create an
> > atomic section around their internal state change _and_ the fpsimd flus=
h
> > op?
>=20
> Is kvm on arm64 officially enabled for oob (-preemption), or are we
> patching blindly here? If no one was looking at kvm yet, then you might
> be right. If it was reviewed already, then this here is just cleaning up.

We have
https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3655577fb=
34cac7996f166d2a

since 6.14 (AFAICT). At the time of writing this was the first kernel
release that used in-kernel FPU. Maybe that changed (thanks to
backports)? Btw: Which version are we talking about right now? 6.1?
6.12?


>=20
> Jan
>=20
> >=20
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  arch/arm64/kernel/fpsimd.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > index 83b8492984982..ba804fcdfdb3f 100644
> > > --- a/arch/arm64/kernel/fpsimd.c
> > > +++ b/arch/arm64/kernel/fpsimd.c
> > > @@ -1951,10 +1951,10 @@ void fpsimd_save_and_flush_cpu_state(void)
> > >  	if (!system_supports_fpsimd())
> > >  		return;
> > >  	WARN_ON(!hard_irqs_disabled() && preemptible());
> > > -	__get_cpu_fpsimd_context();
> > > +	get_cpu_fpsimd_context();
> > >  	__fpsimd_save();
> > >  	fpsimd_flush_cpu_state();
> > > -	__put_cpu_fpsimd_context();
> > > +	put_cpu_fpsimd_context();
> > >  }
> > > =20
> > >  #ifdef CONFIG_KERNEL_MODE_NEON
> >=20
>=20
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
