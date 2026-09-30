Received: from calculus.sigma-star.at (calculus.sigma-star.at [188.245.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3164EE84D
	for <xenomai@lists.linux.dev>; Wed, 30 Sep 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.196.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776124; cv=none; b=XJMUzcgALJInTAuw34Yr8fCyyVMbMQhPJ8RLwe6sLGHldEO0XcmrcT/UZ42MMh7HmtxZTvZQuNycwVFFJON0aBoFt/AyYnhtH0NLuvvv4LbK07MGUzdglayRE/Ad+TGe2NOt5vUsFs0JNbBgZyI11BXBXMKKkNdjOt3qxKsJSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776124; c=relaxed/simple;
	bh=dp/qU7zTHGBZYIxR/tivueKRJPSgkGHRXGychtXRVgk=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=BkSYugLybangzzh0yF9XJ8P/SyqXKJJL4HsKDdj5iKhQvBVBwKQ1EokcCsJH2tkjRSgtv+SDdkXGGYsV4tyfOmwTRoe5Y+yZvz0oszaDsxE5+DOAPa5KadQhNX7zRM2K2Fdw2vTPSE2Rd/LCMgeI/dVduuYIWGC9bFxAESTZwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b=8dS/giPa; dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b=SsdWKUGc; arc=none smtp.client-ip=188.245.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nod.at header.i=@nod.at header.b="8dS/giPa";
	dkim=pass (2048-bit key) header.d=nod.at header.i=@nod.at header.b="SsdWKUGc"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1790775979; bh=dp/qU7zTHGBZYIxR/tivueK
	RJPSgkGHRXGychtXRVgk=; b=8dS/giPakBvRY+1ND38keoR7jGqnCq71FgfrEnsZaYGDBQvHWF
	LfZ7Wd7kHqD7YFN+BQLBkcC299w8VLqFqJAw==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260901; d=nod.at; c=relaxed/relaxed; r=y;
	h=Date:Message-ID:Subject:To:From; t=1790775979; bh=dp/qU7zTHGBZYIxR/tivueK
	RJPSgkGHRXGychtXRVgk=; b=SsdWKUGcEDaZiILsrTyCV12BlSEuiKOCLrK8vtOtA/9VDJSjOr
	D9IsiyyNg0Fa1WOdDu/BdFaCfAOUusvVE5SWtNOUVG4OLMe3nV9UDOQnfvVISJaB2u+JhUCBwrt
	ppXLxtk3UveOSU9yCuNYtf0X/rQSoGmBdpxRRQ8B2+sUY1ArRCG79gSyMEaMM4ulHMgrlT5oFbS
	0nbpiNJT+Ql9IKthA9AgVz8aWfJzFioBjq8E/X0syOd2Ygwbj1yY4BLsG03EdxYdMKnMNMg+kVp
	4zuPIiRiAUbPWAbACg2nLFYuRJ2UlJPw1Pea4KRlyrB2VU3KArl8yRcQvB4M0kwCiwA==;
From: "Richard Weinberger" <richard@nod.at>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>, "Jan Kiszka"
 <jan.kiszka@siemens.com>, "Xenomai" <xenomai@lists.linux.dev>
Cc: "Richard Weinberger" <richard.weinberger@gmail.com>,
 "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>,
 "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Subject: AW: No call tomorrow / Meet-up in Prague
Message-ID: <muo5s5gd.cebfa0e0-a6a8-4b8b-967d-42b905fb8b68@nod.at>
In-Reply-To: <2b5e9f6f2bb082278d921f6c0269ddfcb168d89d.camel@siemens.com>
References: <9509551e-b9e2-4bf0-8669-fecce9ce6403@siemens.com>
 <2b5e9f6f2bb082278d921f6c0269ddfcb168d89d.camel@siemens.com>
Date: Wed, 30 Sep 2026 13:46:19 +0000
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Tue, Sep 29, 2026, 23:09 schrieb Florian Bezdeka <florian.bezdeka@siemen=
s.com>:
> On Tue, 2026-09-29 at 18:22 +0200, Jan Kiszka wrote:
> > Hi all,
> >=20
> > quick note: there won't a community call tomorrow.
> >=20
> > However, if you happen to be in Prague for the OSS EU next week as well=
,
> > we could use that to meet in person. How about gathering after the boot=
h
> > crawl on Thursday evening?
>=20
> Sounds great. I will be there!

Sounds good, I'll try to attend.
I'm still traveling and need to defragment my calendar.

Thanks,
//richard
