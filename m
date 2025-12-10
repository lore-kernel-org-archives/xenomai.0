Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39136322B73
	for <xenomai@lists.linux.dev>; Wed, 10 Dec 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765368915; cv=none; b=eje6JHt93oUEXDZ9QLIsGlLV0JiXEopCDwpDae3iaGfLeCE6ZlFH+r2ay45UOzDrfBG1aPj1MhQGbvuND63YHVEWewZC45TFDPJJ9ZHbx+4u76wwFRGS5R5UnU/XoE+1Xlr9Nep1R3vydRS5hnjxdNldpAPj34mtwmzdJ1kXyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765368915; c=relaxed/simple;
	bh=F5uE5D/vasOXnurvczWSJnaNu3aIIZrJhKsuDb7ftpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/ARB+9Qiy4S9oBK0wGxadu7jC7jYn3f0UFnL6sdL+jAik81gESuGkyyspQr6VZzSTTBjjqhUxCqZbQpPO5SLEa+KSza7LGdeFn2NJanLSIMttYOzBDCD11xMHay5CPgWO6CpWdVXfZIGz8KCL/t8kAXJJU3gup6xExW20K8gnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Yumf1giF; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Yumf1giF"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512101214599c0b619c9600020751
        for <xenomai@lists.linux.dev>;
        Wed, 10 Dec 2025 13:15:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F5uE5D/vasOXnurvczWSJnaNu3aIIZrJhKsuDb7ftpw=;
 b=Yumf1giFJgXJ+J0olwVgwWgfwUWU/qlUZj9JkmfDOwuXwEPW8cEriHfC6tEGoorUFuV3HP
 xG5TOL3TC8sGbXAamO6jHBOgsCU0swKneGGcm+TPr0qxC1DSXDYX1iQghmxdCt7Fz8Sh676O
 KNnCe1T0fn/4e4PnQPon5fZc9WeKeZ1SmSTpM9tc9fjMn1X8PfTYI0wxXvuRrQIPqnjuRikp
 cKKy8WBpK1UMj7h68duGp8IDLCtoX5zYmXX0pHCSKsrTDKaFt2RR7C4wWWUUSDAs1rimsKB3
 84fk7PPvJmDMd64EbG4Vv8WwZAwxlnVf4lm6lhdGTegMT9C1U+ZciulQ==;
Message-ID: <0b02043cfe5b2032611180d514dcb2eff690d844.camel@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU /
 FPSIMD usage
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 10 Dec 2025 13:14:59 +0100
In-Reply-To: <875xaq88tf.fsf@xenomai.org>
References: 
	<20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
	 <875xaq88tf.fsf@xenomai.org>
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

On Mon, 2025-12-01 at 17:29 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi all,
> >=20
> > these are the necessary backports for dovetail 6.1 that would allow us =
to
> > enable the in-kernel FPU usage of switchtest. This is currently not
> > possible as dovetail < 6.12 does not allow / implement the necessary fp=
simd
> > context switching.
> >=20
> > I have backported the necessary patches down to 5.10. That would allow
> > us to unconditionally enable the tests for the xenomai3-next branch. I
> > will send out the 5.15 and 5.10 series once we agreed that this version
> > (targeting 6.1) is correct.
> >=20
> > Please note that there is a small problem with this series. Patch 1
> > removes the check/flag that was used by the dovetail enablement code to
> > detect in-band FPU usage. The new flag is implemented differently in
> > patch 2. Patch 2 also fixes the usage of that flag. I had no better
> > idea. Otherwise I would have to delete? the in-kernel fpu preemption
> > code (temporary).
>=20
> TIF_KERNEL_FPSTATE is not covering a preemption of a softirq handler
> using the NEON unit by an oob thread when PREEMPT_RT is disabled, kernel
> or user for that matter. i.e. It looks like this aspect was overlooked
> during the busy -> TIF_KERNEL_FPSTATE transition for Dovetail, so a
> broader fix may be required. We may have to use a marker which covers
> any type of preempted context.
>=20

I agree, but this is something that we should address in addition / on
top, no?

This issue seems to affect all versions of dovetail. If we do the
backports first we can address the issue on the same feature set. That
should simplify the back-porting again. Did I miss something?

Best regards,
Florian
