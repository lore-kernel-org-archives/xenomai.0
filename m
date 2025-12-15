Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFA2D780C
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793798; cv=none; b=Nym0ofleJ5WIuuGN290zCv7Shx/4BVT41uT3d3GKj8HfkECdRXJHgouqvvQfNP6skM+7d/xwXWd498Bf7WxLgW4qb3GPGfnmMALeGJeMPSkFNjkkqnNInahey2JVjn8vTdd5wEPpY3y8g9A5FIV8jlVIfgAE7oTRUlYv5+HUQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793798; c=relaxed/simple;
	bh=ZN4in7EcxvvPwbo4VxOkz79if5/24QTwA2MEXiQAKio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OK8h1TdVojTyiPAy2nXuWhtQ8arrPvYLm9invW2/OtrfDQkwub498kKa/UH4D475Lf8xMGh0MB8fvPl1xPCVBQ8Lvs+bdCrPYAJQuVyMgbUcCnM3TgcHxbW4RQ1pUYQRclcnfca+PM5zjJFKE7QQtfbgTyaN3DLq1fu5XOup4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=c/GMgkAW; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="c/GMgkAW"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251215101623ac204773cb000207bd
        for <xenomai@lists.linux.dev>;
        Mon, 15 Dec 2025 11:16:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZN4in7EcxvvPwbo4VxOkz79if5/24QTwA2MEXiQAKio=;
 b=c/GMgkAWc6/S3yKi11iBAvmdGVL40FHjhl2RYixe+jv438eVsSlze2OBnJR1NK3oGZ+lGt
 gr1yxLuS8Ckw02ZI5ESiJ8cQT/B5nIArhT5j5BViD2SkFTDr2a+qfewkqD9iAlOfmwngyNfR
 xA+pbWrciGCoDhLDWmfCbcg4BeeNs9YgWfKpO5jcJBF41aY5h4COjLyfylo/tJ+4YtfYpdqa
 QUJNPRLyikuIpxgVlMx2rzx2fqve739i9Ac2oSbLx1AQEEgOk3aIJCaXNcVd5xearOxQyVqA
 1qu7PMz4EFrTpBbZgqh4vHJFKaLfS4dzDZ/AFOFmubIMeDxD68rF8NWg==;
Message-ID: <061af3d688e85a88f29eac6d586796119d9d8984.camel@siemens.com>
Subject: Re: [PATCH 0/6] Some fixes for the select syscall
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
Date: Mon, 15 Dec 2025 11:16:23 +0100
In-Reply-To: <a4b1a462-c36f-40f9-ba20-9010d8c972cc@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
	 <7bf94e8c64a09fc98850d7bc923e2ce47e713f9e.camel@siemens.com>
	 <a4b1a462-c36f-40f9-ba20-9010d8c972cc@siemens.com>
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

On Mon, 2025-12-15 at 07:58 +0100, Jan Kiszka wrote:
> On 05.12.25 11:53, Florian Bezdeka wrote:
> > On Fri, 2025-12-05 at 10:03 +0100, Florian Bezdeka wrote:
> > > Hi all,
> > >=20
> > > this is the result of a short debug session triggered by Andreas who =
was
> > > staring at some strange select() behavior.
> > >=20
> > > The issues were introduced while working at the y2038 support, so
> > > backports should go into the stable 3.2 and 3.3 series as well.
> >=20
> > Still true for 3.3, for 3.2 some more details:
> >=20
> >=20
> > After looking at the problematic user again, we realized that there is =
a
> > different behavior regarding select() between Xenomai 3.2 and 3.3.
> >=20
> > 3.3 comes with the following commit (see Fixes: of patches) which
> > aligned the cobalt select() implementation with Linux, by doing the
> > additional normalization.
> >=20
> > faef02b5e76f ("y2038: cobalt/posix/select: Refactor __cobalt_select()")
> >=20
> > That was done to make sure select() behaves identical under Xenomai and
> > Linux.
> >=20
> > To harmonize 3.2 and 3.3 in this regard we need to backport the
> > mentioned commit upfront. It doesn't apply 1:1 but seems doable. Not
> > sure if all kernels still supported by 3.2 would build, though. Needs
> > checking. In case some users somehow relied on failing select() calls
> > they might be surprised by a stable update.
>=20
> I'm not sure yet why we should backport to 3.2. The normalization
> (instead of rejection) for tv_usec >=3D USEC_PER_SEC was added to 3.3.
> Patch 2 references a commit that is 3.3-only as well. I do not see a
> reason to bother stable/v3.2.x with this series.

I'm fine with skipping the back-porting, as long as it is clear that we
will (still) have different behavior between 3.2 and 3.3. The result
would be

3.2 -> rejection
3.3 -> accept, aligned with Linux

