Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92E331ED4
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504311; cv=none; b=kLUjGmDcfAafmiuwpFwIPlzji8dlBks3TeX/D8FC9gZq4MZnlbo37Qz4xJMKU+ABoqW79Sr7M8FK/B1Vuf4LpRHZ+ixuQb0rN8T1WT/lGvqW0zChVJcDSab2WhkDtxJZbEXrA90OjRyDHwZgJ8yuOIXyzRaulUWvQZxD4/9GugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504311; c=relaxed/simple;
	bh=1ExsNByg1NGBFMLfWRdbr486PtIgh72USFCbcOCOk3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSsfuSqV7O/sPvCDLqwTHw30g+/7l1YrbcCaMUbP05GQRY+6XRe3yn3tasfaYYhrPy3/0O3VQwnaENFVlfODja3y3i+m6L3z53WIU4Ll3iTH+gxq7T+RmCUe7nvk+G6cb+wQG8iidn1Nb6V2GcvJfYkkc6jGrF9yxO3hKFGAvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IKuDgDKL; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IKuDgDKL"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260708095135e4beb1e20e000207d9
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 11:51:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=slt7/vIHxIW4dcjDAECobg2xtlpkOb/1xVIjbZwsUuA=;
 b=IKuDgDKL6A+t8ujVBQM5vJz96wAgl2Lbf1Z0upFtj3JOg6rRSgJbCKozHLECHfV2vgDXFu
 sKF6lz9BkQ6ccJwNuO39PU2xbwnmwMs3YXPp5rj4VxjYJ+nLSZxV6ytyPjslMmqp05hJftAZ
 CKpQh4ga6w9CCIXYxYdmU4O7HSh54VNscAaFhZdSauNSLbrwUQtezxZstz8/JNcRPoT1w0h2
 wWzaUJfEbWSlrV6ouSphnzCPZPOd1vNgdnQXqOQCpb8Jzm5JiaBNFuF81qpLNxCpD0UJUolt
 2s1UxoQgkm2cYDiN2P0k0Jgf/5ISeUdVdobP8BSXh69WrI0j0gCNJnZg==;
Message-ID: <a72d61e20ebd3c5279b1f80f2a7d5225eb8fdb08.camel@siemens.com>
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
 xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 08 Jul 2026 11:51:35 +0200
In-Reply-To: <87zf01lv1z.fsf@xenomai.org>
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
		<837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
		<40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
		<e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
		<4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
		<bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com>
	 <87zf01lv1z.fsf@xenomai.org>
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

On Wed, 2026-07-08 at 10:55 +0200, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > On 08.07.26 08:26, Tobias Schaffner wrote:
> > >=20
> > >=20
> > > On 7/8/26 08:07, Jan Kiszka wrote:
> > > > On 08.07.26 07:17, Tobias Schaffner wrote:
> > > > > On 7/8/26 00:30, Florian Bezdeka wrote:
> > > > > > On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > this series introduces an initial EVL port for RISC-V.
> > > > > > >=20
> > > > > > > While some tests are still failing, I=E2=80=99d like to share=
 this early
> > > > > > > version with the community to gather feedback, reviews, and h=
opefully
> > > > > > > some assistance in refining the port.
> > > > > > >=20
> > > > > > > The patches have been tested in combination with the Dovetail=
 RISC-V
> > > > > > > port on top of v6.12-evl1-rebase.
> > > > > > >=20
> > > > > > > Looking forward to your feedback and suggestions.
> > > > > > >=20
> > > > > >=20
> > > > > > I tried to apply this series today, and run into the following =
issues
> > > > > > reported by my tooling.
> > > > > >=20
> > > > > > Patch 1 is fine, patch 2 has some checkpatch findings.
> > > > > >=20
> > > > > > A couple of debatable warnings like:
> > > > > >=20
> > > > > > WARNING: Misplaced SPDX-License-Identifier tag - use line 1 ins=
tead
> > > > > > #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
> > > > > > + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> > > > > >=20
> > > > > > WARNING: unnecessary whitespace before a quoted newline
> > > > > > #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
> > > > > > +
> > > > > >=20
> > > > > > In addition to a serious one:
> > > > > >=20
> > > > > > ERROR: Missing Signed-off-by: line by nominal patch author 'sha=
nnmu
> > > > > > <shanmu1901@gmail.com>'
> > > > >=20
> > > > > I did not get any responses from this email anymore. I can try to=
 reach
> > > > > out to him one last time, but what do we do about it if he will n=
ot
> > > > > reply?
> > > > >=20
> > > >=20
> > > > If I read that patch correctly, it's majority is taken from the
> > > > corresponding Xenomai 3 logic. How much is unique contribution, how=
 much
> > > > was your work, Tobias?
> > >=20
> > > I added the evl_set_fpregs/evl_check_fpregs content which is a
> > > translation from what Gilles Chanteperdrix
> > > <gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectu=
res
> > > with some isa enablement bits added.
> > >=20
> > > This should be the initial version by shanmu where I added this on to=
p:
> > > https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/
> > > evl_port/arch/riscv/include/asm/evl/fptest.h
> > >=20
> >=20
> > At least for this patch, I think it would be fair to claim authorship
> > for the final one and only refer to shanmu as provider of a baseline.
> >=20
>=20
> Agreed.  This is a trivial adaptation of the pre-existing
> arch/arm*/include/asm/evl/fptest.h, which is in and of itself
> boilerplate code.
>=20

We had a short chat about this topic in the Xenomai community call
today. To avoid further delay of the dovetail 7.1 release we decided
that we will move out the risc-v series again.

Tobias will use the time to clarify a couple of those co-author and
signed-off topics. Each series (dovetail, evl, libevl) seems to have
those issues.

We will have to wait for a reply for some time, but we hope to address
those issues within the 7.2 cycle.

Evl and Dovetail v7.1-rebase branches should be up to date now.

Florian
