Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4918DF8D
	for <xenomai@lists.linux.dev>; Sat, 27 Sep 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758999267; cv=none; b=sFbqjFgUCpLl09C9igV3H144p9cdvfA4BPHa28fhg1YsD8Pd7yyfkbbauErXk08vpKMe5o/5jIs0aPCkNWTvzO0FDrkSPJ2iDvYY0iGKCCTrugO4nqInr7RX0Nu5C4py0HmRQ3xwm75u4SXF77lL71WSVPbx1zmDrQ3Q8+wGvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758999267; c=relaxed/simple;
	bh=oZXoxoESQ1lZpKtsnpk5xp/OWs89j8lG7qdXFIsZ7WY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5eOKVLtZfJeL3+UE37sj4biBLsFgx0rPEnUXMwOytPXVK4c4NJqbWE+o2lv4+mK4vxn2vDS22YzfFL6jUmB8cog68q3OZIhQLvGxvt4x+Ztxn9ZnNYZws0kmY0ADADo418y7wKwlXNPQayjL2jr2eSbK0G8OcygpBUwKR/Z/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=blnihsG3; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="blnihsG3"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 1E01D43CC3
	for <xenomai@lists.linux.dev>; Sat, 27 Sep 2025 18:54:14 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7DE5178003C
	for <xenomai@xenomai.org>; Sat, 27 Sep 2025 18:54:13 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250927185412142bd1d59a0002074f
        for <xenomai@xenomai.org>;
        Sat, 27 Sep 2025 20:54:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lJbFxLtfguTdghUFKaKKez89yh5adg3hcphIXAdgGa8=;
 b=blnihsG36qT++NLz1IrBxxmfMjRaAAaot5t4CmXKd9K8BbxP671wwcMwY3esQNZGThpHeD
 yH9Ot9y71DTyypEnCltnzFLTLJee73rblQ+/VNbN4+B3kjMZAZJthbXHCLGIm+kUFS55jhqP
 2cS2uG7KfENf7Tt3mKhjo5ss4sr4dGU4KsHbARqeAcP+zQgVL8qaIzvmGtHEoWxVTiU5E4c8
 Vakg2iwAI3J7zTzVQVeYPxfNUHKwpRPTqZmkhmW7bBIj96bigPa52KaOBOJKlrOLBUa632z6
 aIssQ7Rt8FsNn+6M9zwWm1qgVVA6gzH27mgH51G/Wzt0ouwi30rH9hjg==;
Message-ID: <ed58111d2e01e76f3a64df0379e4f71e90680f0b.camel@siemens.com>
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org
Date: Sat, 27 Sep 2025 20:54:10 +0200
In-Reply-To: <87qzvrkcip.fsf@xenomai.org>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
		<b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
		<87bjn1m28m.fsf@xenomai.org>
		<e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
		<f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
		<8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
		<682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
	 <87qzvrkcip.fsf@xenomai.org>
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
	dkim=pass header.d=siemens.com header.s=fm1 header.b=blnihsG3;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20250927185412142bd1d59a0002074f-G71EFr@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-68982-20250927185412142bd1d59a0002074f-G71EFr@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfedtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgggesthhqredttddtjeenucfhrhhomhephfhlohhrihgrnhcuuegviiguvghkrgcuoehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeelleffffeivdejgfdvvddvleevteekueeuieehhfffieduteegfeetffekjedthfenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvddufedpudekhedrudefiedrieehrddvvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqdeikeelkedvqddvtddvhedtledvjedukeehgeduvddugedvsgguudguheelrgdttddtvddtjeegfhdqifejudfghfhrsehrthhsqdhflhhofihmrghilhgvrhdrshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On Sat, 2025-09-27 at 19:53 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Thu, 2025-09-25 at 14:49 +0200, Jan Kiszka wrote:
> > > On 25.09.25 14:47, Florian Bezdeka wrote:
> > > > On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
> > > > > On 23.09.25 20:51, Philippe Gerum wrote:
> > > > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > > > > >=20
> > > > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > > >=20
> > > > > > > Not all callers of this function do that themselves.
> > > > > > >=20
> > > > > >=20
> > > > > > Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu=
_put_fp()
> > > > > > would not benefit from doing that themselves precisely, to crea=
te an
> > > > > > atomic section around their internal state change _and_ the fps=
imd flush
> > > > > > op?
> > > > >=20
> > > > > Is kvm on arm64 officially enabled for oob (-preemption), or are =
we
> > > > > patching blindly here? If no one was looking at kvm yet, then you=
 might
> > > > > be right. If it was reviewed already, then this here is just clea=
ning up.
> > > >=20
> > > > We have
> > > > https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3=
655577fb34cac7996f166d2a
> > > >=20
> > > > since 6.14 (AFAICT). At the time of writing this was the first kern=
el
> > > > release that used in-kernel FPU. Maybe that changed (thanks to
> > > > backports)? Btw: Which version are we talking about right now? 6.1?
> > > > 6.12?
> > >=20
> > > All of them.
> > >=20
> >=20
> > In case backporting is considered:
> >=20
>=20
> We already have 028ad3b2 in [rebase/]6.1.y-cip, I'll pick 97cb63af01de
> as well.
>=20
> > Please also take
> >=20
> > 97cb63af01de ("arm64: fpsimd: dovetail: Align with x86 implementation")
> >=20
> > into account. Just a "couple of weeks" old and brings some
> > optimizations.
> >=20
> >=20
>=20
> We also need to enable the oob preemption test in switchtest, which was
> disabled so far due to lack of support. Now that 028ad3b2 enables safe
> preemption of kernel_neon_begin/end sections by oob thread, we should
> allow testing this feature in v3 as well with something along these
> lines:
>=20
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kern=
el/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> index 0958d5e2a..b8c0c39c5 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> @@ -10,16 +10,20 @@
>  #include <linux/errno.h>
>  #include <asm/xenomai/uapi/fptest.h>
>  #include <asm/hwcap.h>
> +#include <asm/neon.h>
> =20
>  #define have_fp (ELF_HWCAP & HWCAP_FP)
> =20
>  static inline int fp_linux_begin(void)
>  {
> -	return -ENOSYS;
> +	kernel_neon_begin();
> +
> +	return 0;
>  }
> =20
>  static inline void fp_linux_end(void)
>  {
> +	kernel_neon_end();
>  }
> =20
>  static inline int fp_detect(void)
>=20
> This was just done in v4 by [1], no issue detected afterwards by the
> 'hectic' test (switchtest equivalent).
>=20
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/0396a52a9b3dc3=
52ef10e6a9d2ed096718ef5d80

Thanks for the reminder...

I'm quite sure I had sent that to the list. Might have got forgotten or
it's hiding successfully in my xenomai queue. I will check and take
care of the test enablement.

