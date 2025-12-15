Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DD1FB1
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797577; cv=none; b=oeykyW2DFLJTwaP8dwwDA8HZNwfF09fSLkW3sASRpoDihAv+xQRCwkOwDuBcBSfl7h9oI9VM4vsh07C3KCGLq988e69W/mqveIOZTemaPz/hjndFlTVSBHJ9ONkhFDNvPd1KfftZyoFVAf2Unp7N+CCHNoDFjlB0/y99uTAA8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797577; c=relaxed/simple;
	bh=tw371MR4Kej2pHaxAGUAF9bsWS1GS7XAZGD8m7CA/W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWZ7elLX/pgcR+oWlErySbo5bYXRqJWJGQzlGt6EbIPtxTqQJFB+GGWy3f7g+YBUtKXOzjjUg0HFSis9JTFy/aIVdrGEk/iBCd/3Fsqwl/nVE8CDYmjcXvNNI6Ep5K6WUE4ZB+SMNcsrVjERisiceMEtdnzmDEJhw4ihHo+np7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PfaouNKp; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PfaouNKp"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251215111924cb91b7f3d800020715
        for <xenomai@lists.linux.dev>;
        Mon, 15 Dec 2025 12:19:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tw371MR4Kej2pHaxAGUAF9bsWS1GS7XAZGD8m7CA/W8=;
 b=PfaouNKp+rr6gC68SnHJPHGxN11SjQiMAFQzORqEkHIG4YtQsjZfvQnEQPQCIu8kc9peiv
 1my9kF6o00Zz6k0+uQeT+YpLAOqPB2ajvZZWCv+pMnLlwNc23BSpBB/gJoRGG9aTE5A1RbcU
 gAx9RU9vqMB4b5vN16uyTT/2lwkqPs7QkufAPEXuPW840uQGgUmHTtUZLWJ807vvpuPYvElC
 f9rHmjy36JbP3cTSkYdECmne+7dN/YMEv31DF4O0bVFG1arVZ7LQk/uAHlQI8U+wvVZb8xwE
 0K+gLbaf4Djb6EzOg2KLjRri+mbvUNVqo6Lgk8oUZkSmvrjMKuJZubDw==;
Message-ID: <a1849bb77a5e82a5eaea88d0498dc42ff6d88c1f.camel@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU /
 FPSIMD usage
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 15 Dec 2025 12:19:23 +0100
In-Reply-To: <87h5txuqhp.fsf@xenomai.org>
References: 
	<20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
		<875xaq88tf.fsf@xenomai.org>
		<0b02043cfe5b2032611180d514dcb2eff690d844.camel@siemens.com>
	 <87h5txuqhp.fsf@xenomai.org>
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

On Thu, 2025-12-11 at 13:56 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2025-12-01 at 17:29 +0100, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Hi all,
> > > >=20
> > > > these are the necessary backports for dovetail 6.1 that would allow=
 us to
> > > > enable the in-kernel FPU usage of switchtest. This is currently not
> > > > possible as dovetail < 6.12 does not allow / implement the necessar=
y fpsimd
> > > > context switching.
> > > >=20
> > > > I have backported the necessary patches down to 5.10. That would al=
low
> > > > us to unconditionally enable the tests for the xenomai3-next branch=
. I
> > > > will send out the 5.15 and 5.10 series once we agreed that this ver=
sion
> > > > (targeting 6.1) is correct.
> > > >=20
> > > > Please note that there is a small problem with this series. Patch 1
> > > > removes the check/flag that was used by the dovetail enablement cod=
e to
> > > > detect in-band FPU usage. The new flag is implemented differently i=
n
> > > > patch 2. Patch 2 also fixes the usage of that flag. I had no better
> > > > idea. Otherwise I would have to delete? the in-kernel fpu preemptio=
n
> > > > code (temporary).
> > >=20
> > > TIF_KERNEL_FPSTATE is not covering a preemption of a softirq handler
> > > using the NEON unit by an oob thread when PREEMPT_RT is disabled, ker=
nel
> > > or user for that matter. i.e. It looks like this aspect was overlooke=
d
> > > during the busy -> TIF_KERNEL_FPSTATE transition for Dovetail, so a
> > > broader fix may be required. We may have to use a marker which covers
> > > any type of preempted context.
> > >=20
> >=20
> > I agree, but this is something that we should address in addition / on
> > top, no?
> >=20
>=20
> Yep, would make backporting easier.
>=20
> > This issue seems to affect all versions of dovetail. If we do the
> > backports first we can address the issue on the same feature set. That
> > should simplify the back-porting again. Did I miss something?
> >=20
>=20
> Agreed.

How do we proceed now? Once applied to 6.1 I can send out the versions
for 5.15 and 5.10 so Jan can apply them as well.

Meanwhile I found some time to read the FPU code around
kernel_neon_begin() again. The problem for Dovetail is that there is no
task context for softirqs in the !PREEMPT_RT case. Seems we need some
kind of a per-cpu flag for this scenario to track the FPU usage. Any
thoughts on your end already?

>=20
> --=20
> Philippe.
