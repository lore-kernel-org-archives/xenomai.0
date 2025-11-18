Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31882356C7
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463367; cv=none; b=HrVLfoHpzSW5dIjE3B8EJ2fr/W3U4itJlllmrOO33A4PxQm1HynfaOw8q0sAbyNFaKip8NV29b3vREDHgQjk2SXCykwQQ4rCyZax3tRBOe6aAWOnJrYuHQ8IGBUVnmwOExvXqhmRJWZL4yLg2KQ27gHvklmuFFhUseel5TR9QfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463367; c=relaxed/simple;
	bh=8dnxRl3epsD8DLt1zq9a1zjz8+C6iiWndXWkxhXPcXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSnYsQehbN25fYOtLwfNxZDlI5LnbvZ5pdMhHxy5DmL/VFl8rPdXTYhmszywBAxRDI2T45r85hpXl/a2LVudu/vjXzm/85Uisk91/Acr3pgL+OfE/YG0IrfEmiTKbhpri3so9V4DFdSMhJC0uKaKZHTyyi8weK9+jyL2SZwlNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nCQSOny+; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nCQSOny+"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id AC0A442E23
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 10:55:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4F1392680DA1
	for <xenomai@xenomai.org>; Tue, 18 Nov 2025 11:55:58 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=nCQSOny+;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20251118105557678584a17b000207b2-nTEFXK@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-68982-20251118105557678584a17b000207b2-nTEFXK@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
X-GND-Status: LEGIT
X-GND-State: 0
X-GND-VSVerdict: clean
X-GND-VScause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdduudehucetufdoteggodetrfdotffvuc
	frrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthem
	uceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfh
	gtgfggsehtqhertddttdejnecuhfhrohhmpefhlhhorhhirghnuceuvgiiuggvkhgruceofhhlohhr
	ihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepleelff
	ffiedvjefgvddvvdelveetkeeuueeihefhffeiudetgeefteffkeejtdfhnecuffhomhgrihhnpehg
	ihhtlhgrsgdrtghomhenucfkphepudekhedrudefiedrieegrddvvdeinecuvehluhhsthgvrhfuih
	iivgeptdenucfrrghrrghmpehinhgvthepudekhedrudefiedrieegrddvvdeipdhhvghlohepmhht
	rgdqieegqddvvdeirdhsihgvmhgvnhhsrdhflhhofihmrghilhgvrhdrnhgvthdpmhgrihhlfhhroh
	hmpehfmhdqieekleekvddqvddtvdehudduudekuddtheehheejieejkeehkeegrgdujegstddttddv
	tdejsgdvqdhnvffghfgimfesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpd
	hqihgupeeghfdufeelvdeikedtffetuddpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghn
	ohhmrghiseigvghnohhmrghirdhorhhg
X-GND-VSscore: -100
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251118105557678584a17b000207b2
        for <xenomai@xenomai.org>;
        Tue, 18 Nov 2025 11:55:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LXHGdYoGgnt/VidA5VdfEMj55wNULNV0vzgdf8PBtOg=;
 b=nCQSOny+ms8Y5wPVDgdYham1OM+PLx5AZySLWFBhZ9Hic0C/8QgtrSd3zrNEZFSJhwTVz7
 IJr6pfztPNZiXsg0ui5zkvQTIJR+eq5X9e4lsThgdkI3cB2ojW/+O/970RLOa+VHiALgXmDB
 2bC9fmX4rY5mUw6z/g9/79tLhCSCmMBZC5RcV54i6zoaf7nTNfqDWe+B0o0M6mxl8gx8Ey6m
 w92FEGpQV7HNden7Pv9zRFEPT6qYjpAEUPUYcJqFgx2PdgNw3wF+9XEZvD6VqCZpTMYDp6bs
 3XIqT6drjYUq0zpJ7ak4B/5CBW8pioLmDQYpP3VBO+hBxtg7Q5w9KbRA==;
Message-ID: <6a1784b2fbae193c70a08f6a840e2d0a615d5fdc.camel@siemens.com>
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Kiszka, Jan"
	 <jan.kiszka@siemens.com>
Date: Tue, 18 Nov 2025 11:55:56 +0100
In-Reply-To: <f036500881b880d81d25272a4f4745903f28a7a7.camel@siemens.com>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
				<b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
				<87bjn1m28m.fsf@xenomai.org>
				<e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
				<f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
				<8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
				<682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
			 <87qzvrkcip.fsf@xenomai.org>
		 <ed58111d2e01e76f3a64df0379e4f71e90680f0b.camel@siemens.com>
	 <f036500881b880d81d25272a4f4745903f28a7a7.camel@siemens.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfggsehtqhertddttdejnecuhfhrohhmpefhlhhorhhirghnuceuvgiiuggvkhgruceofhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepleelffffiedvjefgvddvvdelveetkeeuueeihefhffeiudetgeefteffkeejtdfhnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvddujedrjedtrddujeekrddvuddvpddukeehrddufeeirdeigedrvddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduvddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehfmhdqieekleekvddqvddtvdehudduudekuddtheehheejieejkeehkeegrgdujegstddttddvtdejsgdvqdhnvffghfgimfesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On Wed, 2025-10-08 at 13:35 +0000, Bezdeka, Florian wrote:
> > > lines:
> > >=20
> > > diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/=
kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> > > index 0958d5e2a..b8c0c39c5 100644
> > > --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> > > +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> > > @@ -10,16 +10,20 @@
> > >  #include <linux/errno.h>
> > >  #include <asm/xenomai/uapi/fptest.h>
> > >  #include <asm/hwcap.h>
> > > +#include <asm/neon.h>
> > > =20
> > >  #define have_fp (ELF_HWCAP & HWCAP_FP)
> > > =20
> > >  static inline int fp_linux_begin(void)
> > >  {
> > > -	return -ENOSYS;
> > > +	kernel_neon_begin();
> > > +
> > > +	return 0;
> > >  }
> > > =20
> > >  static inline void fp_linux_end(void)
> > >  {
> > > +	kernel_neon_end();
> > >  }
> > > =20
> > >  static inline int fp_detect(void)
> > >=20
> > > This was just done in v4 by [1], no issue detected afterwards by the
> > > 'hectic' test (switchtest equivalent).
> > >=20
> > > [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/0396a52a9b=
3dc352ef10e6a9d2ed096718ef5d80
> >=20
> > Thanks for the reminder...
> >=20
> > I'm quite sure I had sent that to the list. Might have got forgotten or
> > it's hiding successfully in my xenomai queue. I will check and take
> > care of the test enablement.
>=20
> I did some tests with that in-kernel FPU usage enabled. My tests were
> based on xenomai/next with Kernels down to 5.10.
>=20
> Results:
> - 5.10: Missing backport
> - 5.15: Missing backport
> - 6.1 : Has the backport but that looks slightly different compared to
>         6.12. At least the following is needed to get the kernel into
>         a "stable" state, but still no test success:
>=20
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 7ee823a6a5e45..be3d37554de0f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -2216,6 +2216,7 @@ void fpsimd_suspend_inband(void)
>  	 */
>  	if (__this_cpu_read(fpsimd_context_busy)) {
>  		fpsimd_save_state(kfpu);
> +		__put_cpu_fpsimd_context();
>  		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
>  	}
>  }
> @@ -2224,8 +2225,11 @@ void fpsimd_resume_inband(void)
>  {
>  	struct user_fpsimd_state *kfpu =3D
> this_cpu_ptr(&in_kernel_fpstate);
> =20
> -	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED))
> +	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED)) {
>  		fpsimd_load_state(kfpu);
> +		__get_cpu_fpsimd_context();
> +	}
> +
>  }
> =20
>  #endif
>=20
> - 6.12 and newer: OK
>=20
>=20
> Btw: I'm on vacation for ~2 weeks now. So please don't expect any
> progress on that topic ;-)
>=20

I finally found some time to debug that issue again. To recap: As soon
as I enable the in-kernel oob FPU usage (see patch at the beginning of
this mail) the xenomai3 switchtest utility will fail when running ontop
of Dovetail < 6.12.

The winner is

aefbab8e77eb ("arm64: fpsimd: Preserve/restore kernel mode NEON at context =
switch")

which is part of 6.8 and newer. That explains why Dovetail versions
below 6.12 show this problem. It allows to preempt in-kernel FPU usage
sections by implementing the necessary context save/restore.

My summary for now is that the hard_preempt_disable() in
kernel_neon_begin() - as part of get_cpu_fpsimd_context() - does not
work as it should. Seems we need a fix for Dovetail < 6.12.

Could someone please have a look and share some thoughts? Confirming my
assumption / theory would be a nice starting point for me.

Possible workaround: I could implement a version specific test
enablement, but I'm not sure if that is papering over a real problem.
The FPU usage in such a context looks valid to me.

Best regards,
Florian

