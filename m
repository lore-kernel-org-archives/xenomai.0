Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26C36E47A
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113965; cv=none; b=IRhbKuy5MIiZzW+eFEIlMBOs/pULMVJ1IPknyQ+JtgFNIlKwlURnZoiW4gFOD0mbaJC2wOWslWspjrsXKYSyqtI4mlw07sQOWAQjCtdM6UL9iA/6dItpE+bJECvlm5LA8vPvtPZSFRmbBBUad5FC6bpz/pK+8QkvDiMlPx4QBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113965; c=relaxed/simple;
	bh=2Ucx8yX01e7IxV3pU3pIM88xBN9AF90zfmM1QhWI4wY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgzqHWeN+3HGDjW1KSRJsufvuh4Sb0MGD6Hovv0NKLyMVcIXg9rtI8MXx4WnwTj4TmWQJGLcEJ37MPJLsNWfquNdq6pchCTrdwDDHrq7q/Ya2bf3Eov3NmgKOC3/dgnIYzi7kTKB0uxlHgAWXBWv/UBNmbleegoSyYjDbV4faTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SqG0eMIQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SqG0eMIQ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202606220739165624b91e6f000207ea
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 09:39:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2Ucx8yX01e7IxV3pU3pIM88xBN9AF90zfmM1QhWI4wY=;
 b=SqG0eMIQopIKPsgOrADhG2qYPRCR/zGlcEjO9JFcHRhzNtarHcOGDI/YKPxhnG8vjOKgfu
 L9qnlL9OhDAyGiDL895xRuJIeBs+mv4P3ZG7S+8kIq0Lzv4Ny1j05mKTzZn5zhhRtOei/tDh
 HtSzIbdfsjaTYgoRH4S1CP8wVryfmUu8L0zrQh51Y3k2mcP2eZ/qhzo6xtlTqIJCrAsW5rA/
 qSp86R++Sv3IIBbiwJd4iXkS1BZ9aS5aXpVffujsMSa+S27sA0qBPao27dtQF1LObkzJ+oap
 EphXqJJVT5vixqLeqWcE6OaV2rXUJ7ujNZ8Ah7aVh5AZ4p0PUGs7uNQA==;
Message-ID: <6fab68d3def30cfc168e81fc9a4e7334c18ec035.camel@siemens.com>
Subject: Re: Possible Xenomai 3 latency regression on arm64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, Xenomai
	 <xenomai@lists.linux.dev>, Quirin Gylstorff <quirin.gylstorff@siemens.com>
Date: Mon, 22 Jun 2026 09:39:16 +0200
In-Reply-To: <877bnrf3o8.fsf@xenomai.org>
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
		<87tsr4fe74.fsf@xenomai.org>
		<28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
		<87cxxsfan7.fsf@xenomai.org> <877bnrf3o8.fsf@xenomai.org>
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

On Mon, 2026-06-22 at 09:13 +0200, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
>=20
> > Jan Kiszka <jan.kiszka@siemens.com> writes:
> >=20
> > > On 15.06.26 09:35, Philippe Gerum wrote:
> > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > it seems we got some >10% worst-case latency increase over the la=
st
> > > > > month with Xenomai head and 6.12 - that is at least the setup we =
use in
> > > > > our long-running weekly test.
> > > > >=20
> > > > > Tonight, the RPi4 test triggered by exceeding the configured limi=
t of
> > > > > 150 =C2=B5s [1]. About half a year ago, we were in 130 =C2=B5s ra=
nge with it [2].
> > > > > x86 and beaglebone are apparently not seeing this change.
> > > > >=20
> > > >=20
> > > > My rpi4 fried. Is the issue visible with x4 as well?
> > > >=20
> > >=20
> > > We do not have long-running latency tests for x4 yet, do we, Tobias?
> > >=20
> >=20
> > Ok, I can try this on an odroid c4. Did anyone succeeded in booting a
> > mainline kernel on pi5? Last time I checked, root-over-nfs was not
> > possible yet.
>=20
> A follow up on the latency issue. I did notice a regression in the
> latency figures with v4 too, specifically on arm64. The issue was
> introduced in v6.12.85-cip22-dovetail3-rebase, where vDSO support for
> oob callers was unexpectedly disabled due to applying 682c4aa14fe6. That
> change is correct starting from v6.18.y, but should not have been
> applied to v6.12.y. The bug caused a ~12% increase in the worst-case
> latency figures on odroid c4.
>=20
> With that change reverted, I'm back to normal on c4 with
> v6.12.90-cip24-dovetail2-rebase. A couple of additional fixes to the
> generic lib/vdso support went in as well, but those have no effect on
> latency.
>=20
> All dovetail and v4/evl branches have been updated accordingly.

All those changes are not yet part of the 7.1 branches (which have been
recently rebased to the first 7.1 release). Will you (Philippe) take
care of integrating that or should I pick it?
