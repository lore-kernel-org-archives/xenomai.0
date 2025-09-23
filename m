Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFD288522
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653486; cv=none; b=Veoqe+XbrNwZo68GhxyR/Z8iXTErDZg+wPsM1lkgO3TguFUpG1AKrGQHlw3l8m8UwCSmAJt83Vp3Oryx/nLzhzXOCuPPXed33HkLPptgYuc+qaS9U9BPEYYMZTilfypOSl+kKTih/h02AaQ0E47ZeppmalRJh6mOgKgRjSll2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653486; c=relaxed/simple;
	bh=F4faAcaCUKPHwOY79tpto8O/dar4RzhGdpu0A7SDFSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hC8dpse+8WuwrE5Vj4VYIxKjgH13dvVMS48oaN4O+aNaAwWQbKJz6OaiduPI8x5Eaygmm5KO3GuOQWCwGgsKzjCDLNJhjamAatd1hnkDnQ5mrbj9cRQfl2lI6Ouh5F1colVVwwjpXziafudMjlX5lfTK8ntTttfbDtqRIo1liBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Lnmes/9H; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Lnmes/9H"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id A904F43C60
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 18:51:22 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8EA257803CF
	for <xenomai@xenomai.org>; Tue, 23 Sep 2025 18:51:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E65D442C8;
	Tue, 23 Sep 2025 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758653482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFqjsKNw6jiZV8OxTwflSQZdP/7SP2fMtuV80dXsweo=;
	b=Lnmes/9HkfD/actwz6Q/nhqYZNIm5i2uTNBZxc/1012wLn4tG99roQMxVRz37ZyxZ+Opmo
	Z9RzKmZ+H6YxfYcc15iiwK7k87BtEQhbF5rxCiw+WcvmHlysQn8Y0wt7EGw7ehNd7B4tWQ
	xBZRc4ZpwvdRe3/4omczjYg6aYHwhOw4KwgRXyIryZTfuu/fLUnFR9YXGKp+J+9hD3qv3Q
	/Tm5OXiqNkzGfYb7Fn2XvDnl/0xMvScGHwltL6tlrfS9HxDfkRnqWQddXR63V55IRF9ClL
	02LSMEb45DAcD/bs4uBNc19vRmjVD5bmi41lwl8x3Oe+7CRSokvkhk7HRTpqZg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
In-Reply-To: <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
	(Jan Kiszka's message of "Fri, 19 Sep 2025 08:55:02 +0200")
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	<b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 23 Sep 2025 20:51:21 +0200
Message-ID: <87bjn1m28m.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgrihesgigvnhhomhgrihdrohhrghdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b="Lnmes/9H";
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.197 as permitted sender) smtp.mailfrom=rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvudejrdejtddrudejkedrvddufedpvddujedrjedtrddukeefrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Not all callers of this function do that themselves.
>

Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp()
would not benefit from doing that themselves precisely, to create an
atomic section around their internal state change _and_ the fpsimd flush
op?

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 83b8492984982..ba804fcdfdb3f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1951,10 +1951,10 @@ void fpsimd_save_and_flush_cpu_state(void)
>  	if (!system_supports_fpsimd())
>  		return;
>  	WARN_ON(!hard_irqs_disabled() && preemptible());
> -	__get_cpu_fpsimd_context();
> +	get_cpu_fpsimd_context();
>  	__fpsimd_save();
>  	fpsimd_flush_cpu_state();
> -	__put_cpu_fpsimd_context();
> +	put_cpu_fpsimd_context();
>  }
>  
>  #ifdef CONFIG_KERNEL_MODE_NEON

-- 
Philippe.
