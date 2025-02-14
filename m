Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0A265CC4
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545649; cv=none; b=CcGqURz4OS0qnObptSlQ0SV8K6BKzPnESstmy7nuuodBKJEgYezGdGZc/uTKcV3WKPzyya5v/a06toPRzVgsM1WwVizPlFZYWFz8v8cG7CvuOEk/gNIpYyzpXVf5jDjlmYxYQUnpYbBSG5E6bj/gxrt7VXrNl6D8TDPNJDOUlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545649; c=relaxed/simple;
	bh=rUCgn5/VaauIXZ+rW+Xu7SWXmSyu+XBkpALqudOW1B8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sq+PfhOSXZpAhup27TdH+D7EfT57Jyc2GuyWjzN3E7eRtysRt0YOdp+RCnWnsxINoJwbEgXxzTR711gcba00b1qzu8lAjx7mHdXfMGzrpNiPReFdoR/Fik9+Qx4cRiSvjEYD7ohuKGUNLetLq3oJl9B62Uk0aJo3MFzhOLfKUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Uo0PKzGF; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Uo0PKzGF"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 4647243B91
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 15:07:21 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6D5E89413EA
	for <xenomai@xenomai.org>; Fri, 14 Feb 2025 15:07:20 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250214150719c62e7960b1b3efbf72
        for <xenomai@xenomai.org>;
        Fri, 14 Feb 2025 16:07:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=h5VVHYwk4IeZqs+vfpoO3PSey1aQFjzz3ay5D6FL4lg=;
 b=Uo0PKzGFvq5VEgIBJCfj7E1axGKnDUS+gKXKGTU+WMh11VSzOG6xlKluk4gbCHMqf9ccDW
 7XEqQnKD18KwMIl3ZnI3p0WKNhDpFsSQ+43Rd5ZKX8cjx8T3TdrPsyDlYmt2O8VmREJLb6xT
 0eZ4wh2V4+Vhsuplc1fhPlIT9NcYUWU9MV50XoIF2aO/Fg7bB41+ctjfsb6Q+66PCErMfdds
 lO/IaiFNIiWxR1DO5ROWZbo79EGy/XXINrXjbPZNSR+qDGSh2sF8nXTFlbTaGnQteRxkKa0r
 T3NPEPsSL0qK6EzRmo27SjfcJ2cAGILTNqrDUNerUa0sdsK4vwvH5AXA==;
Message-ID: <b277afbb6f3ea484927fd8388d3c503969056f2f.camel@siemens.com>
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: powertree <powertree@163.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Philippe Gerum
	 <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
Date: Fri, 14 Feb 2025 16:07:19 +0100
In-Reply-To: <34c915a8-8d4f-45f9-9f80-8703184e14bc@163.com>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
	 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
	 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
	 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
	 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de> <87ttmwo7by.fsf@xenomai.org>
	 <8dbe101.93d4.1944a9bae5f.Coremail.powertree@163.com>
	 <25336e91-c3e2-41bd-88c1-90822fea4d46@siemens.com>
	 <a42668f5ef9a620cf7caebd59e3fcbcb71989c9b.camel@siemens.com>
	 <34c915a8-8d4f-45f9-9f80-8703184e14bc@163.com>
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
	dkim=pass header.d=siemens.com header.s=fm2 header.b=Uo0PKzGF;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20250214150719c62e7960b1b3efbf72-guq_Sx@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-68982-20250214150719c62e7960b1b3efbf72-guq_Sx@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgggesthhqredttddtjeenucfhrhhomhephfhlohhrihgrnhcuuegviiguvghkrgcuoehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieejuedvjefhfeetgedvheehjeduhfeggeeuheeuhfdvgeffjeeuleetleetueenucffohhmrghinhepuggvnhigrdguvgenucfkphepvddujedrjedtrddujeekrddvuddtpddukeehrddufeeirdeihedrvddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddutddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehfmhdqieekleekvddqvddtvdehtddvudegudehtdejudeltgeivdgvjeeliedtsgdusgefvghfsghfjedvqdhguhhqpgfugiesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On Mon, 2025-01-13 at 19:37 +0800, powertree wrote:
> I don't have any plans recently to backport this patch to the lower=20
> versions of the Dovetail kernel.
> When I'm free in a few months, I might backport this patch to the lower=
=20
> versions and conduct some tests. I will keep everyone informed of the=20
> results.
> Thank you for your advice, Florian Bezdeka and Jan Kiszka

Let me revive this stalled topic:

This issue still persists, the mentioned patch (alone) does not help
here. Dovetail on arm(64) is missing a proper store/restore logic for
in-kernel-FPU usage when an out-of-band is preempting a inband task.

This topic came back while forward porting dovetail to 6.14. The
xenomai test suite is sufficient to trigger a FPU corruption.

We discussed the topic in our Dovetail maintainer sync today. I might
have some time next week to look into this topic. At least for arm64.
arm might need separate care. I will start by revisiting the x86
implementation.

Best regards,
Florian

>=20
>=20
> On 1/11/25 00:43, Florian Bezdeka wrote:
> > On Fri, 2025-01-10 at 17:21 +0100, Jan Kiszka wrote:
> > > On 09.01.25 11:28, linz wrote:
> > > > Hi,=C2=A0 all
> > > > I think the following patch can resolve the bug,=C2=A0 it allows oo=
b threads to safely preempt kernel_neon_begin() / kernel_neon_end sections.
> > > > https://source.denx.de/Xenomai/linux-dovetail/-/commit/9b19700e623f=
96222c69ecb2adecb1a3e3664cc0
> > > >=20
> > > > But this patch has been merged into the Linux kernel version 6.8. A=
t present, I have no plan to upgrade to version 6.8.
> > > > I'm not sure if I understand correctly, but if so, is there a plan =
to backport this patch to a lower version, such as 5.10?
> > > >=20
> > > Have you tried to backport it to your kernel already to confirm that =
it
> > > helps?
> > >=20
> > > Unfortunately, it looks like a cleanup to upstream, so we may not get=
 it
> > > in via normal LTS. But if it help, picking it into dovetail LTS trees=
 is
> > > imaginable.
> > That patch at least depends on
> >=20
> > 13150149 ("arm64: fpsimd: run kernel mode NEON with softirqs disabled")
> >=20
> > There is more work to be done to have that properly backported, or
> > update to one of the recent LTS versions.
> >=20
> > Florian
> >=20
> > > Jan
> > >=20
> > > > At 2024-01-29 16:42:38, "Philippe Gerum" <rpm@xenomai.org> wrote:
> > > > > Jan Kiszka <jan.kiszka@web.de> writes:
> > > > >=20
> > > > > > On 25.01.24 04:18, linz wrote:
> > > > > > > I think my patch is not suitable after listening to your sugg=
estions.
> > > > > > > And I don't have any other good solutions.
> > > > > > >=20
> > > > > > > I think x86 is ok because there is no operation of writing gl=
obal
> > > > > > > variables in the critical zone.
> > > > > > >=20
> > > > > > > kernel_fpu_begin
> > > > > > >  =C2=A0=C2=A0=C2=A0 =3D>kernel_fpu_begin_mask
> > > > > > > =3D>preempt_disable // enter the critical zone
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(!=
irq_fpu_usable());
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(t=
his_cpu_read(in_kernel_fpu));
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>flags =3D har=
d_cond_local_irq_save(); // leave the critcal zone
> > > > > > >=20
> > > > > > >=20
> > > > > > > But in arm64, there is operation of writing global variables =
in the
> > > > > > > critical zone, unfortunernaly.
> > > > > > > efi_call_rts
> > > > > > >  =C2=A0 =3D>__efi_fpsimd_begin
> > > > > > >  =C2=A0=C2=A0=C2=A0 =3D>kernel_neon_begin
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>get_cpu_fpsimd_context
> > > > > > > =3D>hard_preempt_disable // disable interrupt, enter the crit=
ical zone
> > > > > > > =3D>__get_cpu_fpsimd_context //=C2=A0 first call, modify glob=
al variable
> > > > > > > fpsimd_context_busy
> > > > > > > =3D>hard_cond_local_irq_restore // enable interrupt, leave th=
e critcal zone
> > > > > > >=20
> > > > > > > handle_arch_irq_pipelined // Latency timer interrupt triggere=
d
> > > > > > > =3D>handle_irq_pipelined_finish
> > > > > > >  =C2=A0 =3D>irq_exit_pipeline
> > > > > > >  =C2=A0=C2=A0=C2=A0 =3D>xnsched_run
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__xnsched_run
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>pipeline_sche=
dule
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>r=
un_oob_call
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D>___xnsched_run
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D>pipeline_switch_to
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>dovetail_context_switch
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__switch_to
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>fpsimd_thread_sw=
itch
> > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__ge=
t_cpu_fpsimd_context // second call
> > > > > > >=20
> > > > > > > So, I think there are more todos on arm64. Do you have any ot=
her good
> > > > > > > suggestions?
> > > > > > >=20
> > > > > > Philippe, some input on this issue would be helpful to know wha=
t the
> > > > > > next step needs to be. It's still unclear to me how fundemental=
 this
> > > > > > issue is (false positive warning or real state corruption?).
> > > > > >=20
> > > > > This is a current limitation on arm64 which amounts to a bug
> > > > > actually. x86 has the proper implementation, which allows oob thr=
eads to
> > > > > safely preempt kernel_fpu_begin() / kernel_fpu_end sections.=C2=
=A0 Since
> > > > > kernel_neon_begin() re-enables hard irqs before leaving, it is cr=
eating
> > > > > the opportunity for a mess.
> > > > >=20
> > > > > The way to fix this is to implement the x86 logic to arm64 when i=
t comes
> > > > > to in-kernel fpu usage.
> > > > >=20
> > > > > --=20
> > > > > Philippe.
> > >=20
> > > --
> > > Siemens AG, Foundational Technologies
> > > Linux Expert Center
>=20

