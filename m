Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113742;
	b=HLY1Qww++6qROrOAXpV0Hb4YR6JzzEg1+03EhfcX4Ba+lg7/MAdgQD254tN1Jt7tOtzD
	 6EKsub5l/6GJfj6OjANuTRJhov37Klh0dKj50I4Q2EuxvZLMg1I2N9f+lzg3Nq2i+hM4e
	 VJCtIHNHc8WM6jcLhdZvw3pA632G5NPt5xfXNWDZIL9xM+BOAibf/sprlsCIOnebzLkvD
	 aL7bujIRQZJuth6xU4HpR1AOHIK5Y/tQtu5+Xtu34mWkVhOfLrqAfiY6ESJ9xel74hEgO
	 a2gzfgpLrd5tTTaT43VMRIkRzvo5mdxL9O+e+yeEgH5eVcKriCdjh3UYKVR+SCBuH9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113742;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=nw3SjK5EGFOo5pjiEaVjVa9JVEzW7kr36VbkchH7ZHY=;
	b=hP8jGcnSNtfMHK02LXpPcKKXdiV9bw7DXEwMqcjnTajZmX5QAyb8UXHoBvLLbogviiPa
	 ANUuDY8muuONsC2h5N75TKDa6eZmUHlIVWyaPbG/Ktw97jOkqW0Ah62cM0+J1n+rLrfvr
	 6A+xLuxil5WYqV4+dD8nuwS+bSbeTKWD36dwT33TKLlekE1aU6OkBOaSAD6VJmOvN0/y1
	 BYoLXuxbkAwRcEu3mVzBPeq0X5wPwzMfwYmFP2pwSZRnfh0AV1MPeoBX0UOivsii0+O7/
	 sTbktoAjjKCQ002t/+VasBHlhZQWo9Ilt0WVTdEcqatLmaPydqQrFgEdHbFea8o0ECQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=I0kcoYpj;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93525606A31A
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 15:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93525606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=I0kcoYpj
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026102715085578e15e7ea600020777
        for <xenomai@lists.linux.dev>;
        Tue, 27 Oct 2026 16:08:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nw3SjK5EGFOo5pjiEaVjVa9JVEzW7kr36VbkchH7ZHY=;
 b=I0kcoYpjNEC/a0aZ9aS74HDZgacxoiKpf1b+Ubr2HQIqYVtDgVep2/mYZkXHk9njzXbnCx
 VKonngfuAQcpT+wk3AWmnwvCLKE0Mx0ZxtkGj1ux8ctIx33JWhuKCPjWhrUq4Z0Tf7ZY4gb8
 mWDJ1rkGIlaFSW1BIkBKAECtM+q0hEL5In5nwG3QeZ/bueYqE4uJu4RJrgQo3WDaVE6C6IrA
 TajfCJimtSPhXL5lKB9uB8AVZlg5itoReYRVna/MSJYGHs8W36FOdXnxfiYeVadOisDtCFVo
 L8/PrWAPRh5y3SxfbKhwdx7rsXw2tzagRvnd0Yd+02J8BKNSSchQNiPQ==;
Message-ID: <7c081db4d744ccbcc8ab6c92e3cf48d46a2ec3aa.camel@siemens.com>
Subject: Re: BUG at system boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>, 
	xenomai@lists.linux.dev
Date: Tue, 27 Oct 2026 16:08:55 +0100
In-Reply-To: <1209-6ae0b900-157-5a2d1100@131697478>
References: <1209-6ae0b900-157-5a2d1100@131697478>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-10-27 at 15:44 +0100, Fran=C3=A7ois Legal wrote:
> Switching my setup from linux 5.4 Ipipe + Xenomai 3.2 to Linux 6.12 + dov=
etail + Xenomai 3.3, I experience the follwing BUG() at system boot. Machin=
e is zynq7000 SoC :
>=20
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C: platform modifies aux control register=
: 0x02060000 -> 0x02460000
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C: DT/platform modifies aux control regis=
ter: 0x02060000 -> 0x02460000
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 full line of zeros enabled for Cort=
ex-A9
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 dynamic clock gating enabled, stand=
by mode enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310 cache controller enabled, 8 ways, 5=
12 kB
> [=C2=A0=C2=A0=C2=A0 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x46=
460001
> [=C2=A0=C2=A0=C2=A0 0.000000] ------------[ cut here ]------------

> [=C2=A0=C2=A0=C2=A0 0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeli=
ne.c:1873 irq_pipeline_init+0x40/0x158
> [=C2=A0=C2=A0=C2=A0 0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not ta=
inted 6.12.90-cip24-yocto-standard-arksv #1

That version is a bit outdated already. Could you please repeat the test
with the current version in the v6.12.y-cip-dovetail-rebase branch, just
to make sure the problem has not already been fixed.

On first glance that looks like an IRQ pipeline state corruption. I
fixed some of them recently, so please give it a try.

The non-rebase branch - the version you are using - has not been updated
yet. Let's wait for your test results. If successful we can ask Jan to
do a stable release.

> [=C2=A0=C2=A0=C2=A0 0.000000] Hardware name: Xilinx Zynq Platform
> [=C2=A0=C2=A0=C2=A0 0.000000] IRQ stage: Linux
> [=C2=A0=C2=A0=C2=A0 0.000000] Call trace:=20
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_backtrace from show_stack+0x18/0=
x1c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:c0c08f40 r6:c0a94cc8 r5:00000000 r=
4:00000080
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 show_stack from dump_stack_lvl+0x94/0=
xc8
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack_lvl from dump_stack+0x18/0=
x1c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000751 r6:00000009 r5:c0b0e65c r=
4:c0a65b0c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 dump_stack from __warn+0x80/0xe0
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 __warn from warn_slowpath_fmt+0x1b0/0=
x1bc
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000 r6:c0a65b0c r5:c0c08f40 r=
4:c0b4268c
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 warn_slowpath_fmt from irq_pipeline_i=
nit+0x40/0x158
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r8:1eb76000 r7:00000000 r6:00000000 r=
5:c0c97038 r4:c0c97000
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 irq_pipeline_init from start_kernel+0=
x3f8/0x568
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r5:c0c97038 r4:c0c97000
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 start_kernel from 0x0
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 r7:00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] ---[ end trace 0000000000000000 ]---
> [=C2=A0=C2=A0=C2=A0 0.000000] IRQ pipeline enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_struct sizes b=
ased on contention.
> [=C2=A0=C2=A0=C2=A0 0.000000] zynq_clock_init: clkc starts at (ptrval)
> [=C2=A0=C2=A0=C2=A0 0.000000] Zynq clock init
>=20
> I don't really know how to chase this.
>=20
> Fran=C3=A7ois
