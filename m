Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4720E319
	for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527431; cv=none; b=s1Vs1PYYT0qtuoe8ZtRFlq/ZFdUC/Q2Er4q7SJ0CSYUbDRL23h0qoEMfxYLHIKZrlHjSMxTtNfPWgWHE26hqiR3vZKYv9JPatN5Rxpj6sOgADQc1irQ9DAgE2popRmwUtGQ8nw9DKGhbnow/4JKkwK+WCDLbvr1dSPHI/sDilGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527431; c=relaxed/simple;
	bh=0rWUntIL3RYot1ykQ+1ehiQC8GkBGygEJhZ0Jop6GQE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnejHb0WXOuf3iI6RV/e3jkqpH/JtHQEV01oaZIP/9CnZzzMZbVLG5OCfEdv9orfdMAgQw7jgCHzOB/z9LvckYd06FhyBzC6MEqexr6FPtdQDjtzJ+mx2Lq0rCuPTONqyuL0QWCv6kUAimiHZN/f7F8sowgWWLvQOi+7KJ9Iu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=arTmzf9I; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="arTmzf9I"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id ECAC2200003
	for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 16:43:44 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 37FD5D80A07
	for <xenomai@xenomai.org>; Fri, 10 Jan 2025 16:43:44 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025011016434332f4e1d0d00d6fc702
        for <xenomai@xenomai.org>;
        Fri, 10 Jan 2025 17:43:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0rWUntIL3RYot1ykQ+1ehiQC8GkBGygEJhZ0Jop6GQE=;
 b=arTmzf9I1P+UZeHk5mB9jncBNPAXGyFV/9IPo0XqMOu+VUvhwY8dfieNMwUY3uzElVFAUU
 6jNZfV+tLwc4MQe2YwoVCA7zzyLY41ZvAmNBI69nJvd+emnJLclbtfJ5UO60464uHNXC2Yij
 Bo4fb82Z3Sqq6+DURpGb4LPZFQGXMM0BtMQYCoGYDI4ha+o9Ts7RIiSgnBUmDL3RmXpea7k0
 PK/zHATqpDRgE58Uglcm85vwSzk7mvVWbKcqxptOuIDU3VtQ+hg4gaNGvnGsct8ZmQUJwbpf
 y/O805k1kC8brstX43YAbbeA82GjkVnS2HzvSa9ImXp8nn2cDbZnXKJg==;
Message-ID: <a42668f5ef9a620cf7caebd59e3fcbcb71989c9b.camel@siemens.com>
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, linz <powertree@163.com>, Philippe
 Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
Date: Fri, 10 Jan 2025 17:43:42 +0100
In-Reply-To: <25336e91-c3e2-41bd-88c1-90822fea4d46@siemens.com>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
	 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
	 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
	 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
	 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de> <87ttmwo7by.fsf@xenomai.org>
	 <8dbe101.93d4.1944a9bae5f.Coremail.powertree@163.com>
	 <25336e91-c3e2-41bd-88c1-90822fea4d46@siemens.com>
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
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=arTmzf9I;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-2025011016434332f4e1d0d00d6fc702-eSvEdm@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-68982-2025011016434332f4e1d0d00d6fc702-eSvEdm@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com

On Fri, 2025-01-10 at 17:21 +0100, Jan Kiszka wrote:
> On 09.01.25 11:28, linz wrote:
> > Hi,=C2=A0 all
> > I think the following patch can resolve the bug,=C2=A0 it allows oob th=
reads to safely preempt kernel_neon_begin() / kernel_neon_end sections.
> > https://source.denx.de/Xenomai/linux-dovetail/-/commit/9b19700e623f9622=
2c69ecb2adecb1a3e3664cc0
> >=20
> > But this patch has been merged into the Linux kernel version 6.8. At pr=
esent, I have no plan to upgrade to version 6.8.
> > I'm not sure if I understand correctly, but if so, is there a plan to b=
ackport this patch to a lower version, such as 5.10?
> >=20
>=20
> Have you tried to backport it to your kernel already to confirm that it
> helps?
>=20
> Unfortunately, it looks like a cleanup to upstream, so we may not get it
> in via normal LTS. But if it help, picking it into dovetail LTS trees is
> imaginable.

That patch at least depends on=C2=A0

13150149 ("arm64: fpsimd: run kernel mode NEON with softirqs disabled")

There is more work to be done to have that properly backported, or
update to one of the recent LTS versions.

Florian

>=20
> Jan
>=20
> >=20
> > At 2024-01-29 16:42:38, "Philippe Gerum" <rpm@xenomai.org> wrote:
> > >=20
> > > Jan Kiszka <jan.kiszka@web.de> writes:
> > >=20
> > > > On 25.01.24 04:18, linz wrote:
> > > > > I think my patch is not suitable after listening to your suggesti=
ons.
> > > > > And I don't have any other good solutions.
> > > > >=20
> > > > > I think x86 is ok because there is no operation of writing global
> > > > > variables in the critical zone.
> > > > >=20
> > > > > kernel_fpu_begin
> > > > > =C2=A0=C2=A0=C2=A0 =3D>kernel_fpu_begin_mask
> > > > > =3D>preempt_disable // enter the critical zone
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(!irq_f=
pu_usable());
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(this_c=
pu_read(in_kernel_fpu));
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>flags =3D hard_con=
d_local_irq_save(); // leave the critcal zone
> > > > >=20
> > > > >=20
> > > > > But in arm64, there is operation of writing global variables in t=
he
> > > > > critical zone, unfortunernaly.
> > > > > efi_call_rts
> > > > > =C2=A0 =3D>__efi_fpsimd_begin
> > > > > =C2=A0=C2=A0=C2=A0 =3D>kernel_neon_begin
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>get_cpu_fpsimd_context
> > > > > =3D>hard_preempt_disable // disable interrupt, enter the critical=
 zone
> > > > > =3D>__get_cpu_fpsimd_context //=C2=A0 first call, modify global v=
ariable
> > > > > fpsimd_context_busy
> > > > > =3D>hard_cond_local_irq_restore // enable interrupt, leave the cr=
itcal zone
> > > > >=20
> > > > > handle_arch_irq_pipelined // Latency timer interrupt triggered
> > > > > =3D>handle_irq_pipelined_finish
> > > > > =C2=A0 =3D>irq_exit_pipeline
> > > > > =C2=A0=C2=A0=C2=A0 =3D>xnsched_run
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__xnsched_run
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>pipeline_schedule
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>run_oo=
b_call
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D>___xnsched_run
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D>pipeline_switch_to
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>dovetail_context_switch
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__switch_to
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>fpsimd_thread_switc=
h
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__get_c=
pu_fpsimd_context // second call
> > > > >=20
> > > > > So, I think there are more todos on arm64. Do you have any other =
good
> > > > > suggestions?
> > > > >=20
> > > >=20
> > > > Philippe, some input on this issue would be helpful to know what th=
e
> > > > next step needs to be. It's still unclear to me how fundemental thi=
s
> > > > issue is (false positive warning or real state corruption?).
> > > >=20
> > >=20
> > > This is a current limitation on arm64 which amounts to a bug
> > > actually. x86 has the proper implementation, which allows oob threads=
 to
> > > safely preempt kernel_fpu_begin() / kernel_fpu_end sections.=C2=A0 Si=
nce
> > > kernel_neon_begin() re-enables hard irqs before leaving, it is creati=
ng
> > > the opportunity for a mess.
> > >=20
> > > The way to fix this is to implement the x86 logic to arm64 when it co=
mes
> > > to in-kernel fpu usage.
> > >=20
> > > --=20
> > > Philippe.
>=20
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

